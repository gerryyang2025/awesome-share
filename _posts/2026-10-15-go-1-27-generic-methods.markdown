---
layout: post
title:  "Go 1.27 泛型方法：用法、适用场景与边界"
date:   2026-10-15 16:55:22 +0800
last_modified_at: 2026-10-15 17:51:08 +0800
description: "从一段 Filter/Map 流水线写起，说明 Go 1.18 的泛型函数和泛型类型还留了哪一个缺口，以及 Go 1.27 的泛型方法如何补上。含声明、类型推断，以及它为什么仍然不能实现接口。"
categories: GoLang
tags:
  - GoLang
  - Go Generics
  - Go 1.27
mermaid: true
---

* Do not remove this line (it will not be displayed)
{:toc}

> 本文对照 [Go 1.27 Release Notes](https://go.dev/doc/go1.27)、[Go 1.27.0 发布记录](https://go.dev/doc/devel/release#go1.27.0)、语言规范中的 [Method declarations](https://go.dev/ref/spec#Method_declarations) 与 [Instantiations](https://go.dev/ref/spec#Instantiations)，以及已接受并在 1.27 实现的提案 [spec: generic methods for Go（#77273）](https://github.com/golang/go/issues/77273)。站内 [Being Confused About When To Use Generics]({% post_url 2025-12-26-being-confused-about-when-to-use-generics %}) 记录的是 Go 1.18 到 1.26 的规则：方法不能声明类型参数。那条限制从 1.27 起放开。何时该用泛型，仍见 [100 Go Mistakes]({% post_url 2025-12-24-100-go-mistakes %}) 第 9 条。
{: .prompt-info }

Go 1.27.0 于 2026-08-19 发布，具体方法可以在方法名后面声明自己的类型参数。要看清它补的是哪一个缺口，得先把 Go 1.18 已经做到的两件事分开：泛型函数，以及「类型上已经带了类型参数」的普通方法。下面用同一份用户列表，从「每种类型写一份函数」走到 `users.Filter(...).Map(...)`。

# 原理与核心概念

## 要算的结果

三个用户，留下 `Active` 的，再取出名字。期望结果是 `[]string{"Ann", "Cy"}`。若再数一下名字有多长，期望是 `[]int{3, 2}`。

```go
type User struct {
	Name   string
	Active bool
}

func sample() []User {
	return []User{
		{"Ann", true},
		{"Bo", false},
		{"Cy", true},
	}
}
```

后面每一步都只改「这段计算写在哪里、类型参数写在哪里」，循环本身不变。

## 第一步：没有泛型时，每种类型写一份

Go 1.18 之前，参数类型必须写死。用户列表和订单列表各要一套：

```go
func activeUsers(users []User) []User {
	out := make([]User, 0, len(users))
	for _, u := range users {
		if u.Active {
			out = append(out, u)
		}
	}
	return out
}

func userNames(users []User) []string {
	out := make([]string, len(users))
	for i, u := range users {
		out[i] = u.Name
	}
	return out
}

names := userNames(activeUsers(sample())) // []string{"Ann", "Cy"}
```

`activeUsers` 和 `userNames` 的循环对 `[]Order` 同样适用，能改的只有切片里的元素类型。类型一变，函数就得再抄一份，或者改成 `[]any` 再做类型断言。断言把错误从编译期推到运行期：取到的若是 `int32`，写成 `.(int64)` 会直接 panic。

这一步的问题是重复。泛型要抽掉的，就是「元素是 User 还是 Order」。

## 第二步：Go 1.18 用类型参数把元素类型抽掉

类型参数是声明里的占位符，调用时换成具体类型。方括号写在函数名后面，`any` 表示这个占位符接受任意类型：

```go
func Filter[T any](items []T, keep func(T) bool) []T {
	out := make([]T, 0, len(items))
	for _, v := range items {
		if keep(v) {
			out = append(out, v)
		}
	}
	return out
}

func Map[T, U any](items []T, f func(T) U) []U {
	out := make([]U, len(items))
	for i, v := range items {
		out[i] = f(v)
	}
	return out
}
```

`Filter` 只有 `T`：进来是 `[]T`，出去还是 `[]T`。`Map` 有两个：`T` 是输入元素，`U` 是函数 `f` 的结果。同一份 `Map` 既能把 `User` 变成 `string`，也能把 `string` 变成 `int`。

```go
users := sample()
names := Map(Filter(users, func(u User) bool { return u.Active }),
	func(u User) string { return u.Name })
// names == []string{"Ann", "Cy"}

lens := Map(names, func(s string) int { return len(s) })
// lens == []int{3, 2}
```

调用处不用写 `Map[User, string]`。编译器看着实参：`users` 是 `[]User`，所以 `T` 是 `User`；传给 `Map` 的函数返回 `string`，所以 `U` 是 `string`。这叫类型推断，1.18 起对泛型函数就可用。

到这里，重复已经消掉。`Filter` 和 `Map` 是包里的函数，数据是它们的第一个参数。下一步才会碰到方法。

## 第三步：方法能挂在泛型类型上，只要不再引入新类型

方法是带接收者的函数。`users.Filter(...)` 里，点号左边的 `users` 就是接收者。把切片定义成自己的类型之后，操作可以出现在这个值的方法列表里：

```go
type List[T any] []T

func (l List[T]) Filter(keep func(T) bool) List[T] {
	out := make(List[T], 0, len(l))
	for _, v := range l {
		if keep(v) {
			out = append(out, v)
		}
	}
	return out
}
```

接收者写成 `List[T]`，表示「使用 `List` 定义里的那个 `T`」。约束仍是类型定义上的 `any`，方法里不能改成别的约束。`List[User]` 这个值一旦造出来，`T` 就是 `User`，`Filter` 的输入和输出都是这个 `User`。

```go
users := List[User](sample())
active := users.Filter(func(u User) bool { return u.Active })
// active 的类型仍是 List[User]
```

这在 Go 1.18 就是合法的。方法没有自己的类型参数，`[T]` 写在接收者上，不写在 `Filter` 这个名字后面。`Len`、`Append` 这类「元素类型在构造时已经知道」的操作，都属于这一类。

```mermaid
flowchart LR
  A["每种类型一份函数"] --> B["泛型函数 Filter / Map"]
  B --> C["泛型类型上的普通方法 Filter"]
  C --> D["Map 还要一个新的结果类型 U"]
  D --> E["1.27：U 写在方法名后面"]
```

## 第四步：Map 的结果类型，接收者身上没有

同一个 `List[User]`，这次想要名字（`string`），下次想要名字长度（`int`）。结果类型取决于这一次传入的函数，不能写进 `List` 的定义，否则一个 `List[User]` 就只能映射成一种结果。

把这个结果类型叫做 `U`，放在方法名后面：

```go
func (l List[T]) Map[U any](f func(T) U) List[U] {
	out := make(List[U], len(l))
	for i, v := range l {
		out[i] = f(v)
	}
	return out
}
```

对照前一步的 `Filter`：

| | `T` 从哪里来 | 还要不要别的类型 | Go 1.18–1.26 |
| :--- | :--- | :--- | :--- |
| `Filter` | 接收者 `List[T]`，值一造出来就定了 | 不要 | 可以 |
| `Map` | 同样来自接收者 | 要，`U` 由这次的 `f` 决定 | 方法上不能写 `[U any]` |
| 包级 `Map` | 第一个参数 | `U` 也写在函数上 | 可以 |

1.26 及更早的编译器对 `Map[U any]` 报 `methods cannot have type parameters`。站内 [Being Confused About When To Use Generics]({% post_url 2025-12-26-being-confused-about-when-to-use-generics %}) 记的就是这条诊断。

两对方括号不要看成重复。左边 `List[T]` 引进类型定义里已有的参数；右边 `[U any]` 才是这次调用新加的参数。1.27 之前，方法只允许有左边那对。

## 第五步：包级函数能编译，调用套在里面

1.18 到 1.26 的做法，是把接收者改回第一个参数。计算和上面的方法体相同：

```go
func MapList[T, U any](l List[T], f func(T) U) List[U] {
	out := make(List[U], len(l))
	for i, v := range l {
		out[i] = f(v)
	}
	return out
}

users := List[User](sample())
names := MapList(users.Filter(func(u User) bool { return u.Active }),
	func(u User) string { return u.Name })
lens := MapList(names, func(s string) int { return len(s) })
```

`Filter` 是方法，点在值后面；`MapList` 是函数，值被塞进参数列表。两步还能看，步骤再多一层，后做的步骤包在外层，阅读顺序和执行顺序相反：

```go
lens := MapList(
	MapList(
		users.Filter(func(u User) bool { return u.Active }),
		func(u User) string { return u.Name },
	),
	func(s string) int { return len(s) },
)
```

最里面的 `Filter` 最先执行，最外面的 `MapList` 最后执行。1.27 把 `Map` 放回方法之后，从左往右就是执行顺序。第一次 `Map` 把 `List[User]` 变成 `List[string]`，第二次 `Map` 的 `T` 已经是 `string`，`U` 推断为 `int`：

```go
lens := users.
	Filter(func(u User) bool { return u.Active }).
	Map(func(u User) string { return u.Name }).
	Map(func(s string) int { return len(s) })
// List[int]{3, 2}
```

还有一个日常能感觉到的差别：包级函数不在 `List` 的方法列表里。编辑器对 `users.` 的补全能列出 `Filter`，列不出 `MapList`，调用方得记得函数在哪个包、第一个参数是不是这个值。提案 [#77273](https://github.com/golang/go/issues/77273) 把方法的这个用途单独说出来：它是挂在类型命名空间上的函数，就算从不拿去实现接口，也值得存在。

## 标准库里的同一缺口

[`math/rand/v2`](https://pkg.go.dev/math/rand/v2) 从 Go 1.22 起几乎每个顶层函数都有 `Rand` 上的对应方法：`IntN`、`Int64N`、`Uint64N` 都是。结果类型写死在方法名里，所以它们是普通方法。

同版本增加的泛型函数 `N` 没有对应方法。它的类型参数 `Int` 表示「任意整数类型」，一次调用可以是 `int`、`uint32`，也可以是底层类型为 `int64` 的 `time.Duration`。这个类型每次调用才选定，接收者 `*Rand` 自己又不是泛型类型，1.26 的方法语法写不出它。

```go
r := rand.New(rand.NewPCG(1, 2))

_ = r.IntN(10)                     // 1.22 起的方法，结果固定为 int
_ = rand.N(100 * time.Millisecond) // 1.22 起的泛型函数，结果是 time.Duration
_ = r.N(100 * time.Millisecond)    // 1.27 起，同一个函数变成了方法
```

1.27 的签名是 `func (r *Rand) N[Int intType](n Int) Int`，行为与顶层 `N` 相同：返回 `[0, n)` 里的伪随机数，`n <= 0` 时 panic。随机源从全局默认源换成了这个 `r`。

## 类型本身可以完全不泛型

前面的 `U` 出现在已经泛型的 `List[T]` 上。另一类更常见：容器类型是固定的，取出来的 Go 类型每次不同。

```go
type Row struct {
	cols map[string]any
}

// 断言写在调用点。动态类型若是 int32，这里会 panic。
id := row.cols["id"].(int64)
```

助手函数能把断言收进去，可是它和 `Row` 的方法列表无关，调用写成 `Get[int64](row, "id")`。`T` 只出现在结果里，推断没有参数类型可用，类型实参 `int64` 必须自己写。1.27 允许这个函数变成方法，调用点的类型实参留在原处：

```go
id, err := row.Get[int64]("id")
```

`Row` 没有类型参数。缺的是 `Get` 这一次返回 `int64` 还是别的类型。完整实现见下文「列类型每次不同」。

## 为什么 1.18 不让方法带上这段语法

方法在 Go 里还负责实现接口。类型不用写 `implements`，方法名和签名对得上，就可以赋给接口。

```go
type Reader interface {
	Read(p []byte) (int, error)
}

type File struct{}

func (f *File) Read(p []byte) (int, error) { return len(p), nil }

var r Reader = &File{} // *File 有匹配的 Read，赋值合法
```

接口值在运行时要调用一个签名固定的 `Read`。它保存具体的值，以及这个值的 `Read` 函数。

假如 1.18 允许方法自带类型参数，就会出现下面这种声明。它不是一个 `Read`，而是一族：`Read[byte]`、`Read[int16]`，以及以后才会写到的每一种 `E`。

```go
type Buf struct{}

func (b *Buf) Read[E any](p []E) (int, error) { return len(p), nil }

var r Reader = &Buf{} // 1.27 同样不合法
```

把 `&Buf{}` 放进 `Reader` 时，编译器不知道以后会把 `E` 实例化成哪一种，也就没有一个固定函数可以放进接口值。类型参数的原始提案把「方法可以带类型参数」和「接口方法也可以」看成同一件事，两件一起搁置。FAQ 里因此写过：不预期 Go 会加入泛型方法。

这个决定一刀切掉了两类方法。`Read[E any]` 确实和接口缠在一起；`List[T].Map[U any]` 并不实现任何接口，它只是想把 `U` 写在方法上。1.18 到 1.26 期间，第二类也只能写成包级函数。

## 1.27 放开的是具体方法这一半

[#77273](https://github.com/golang/go/issues/77273)（Robert Griesemer，2026-01-22）把两件事拆开：具体方法是带接收者的函数，函数可以泛型，带接收者的函数也可以。接口方法的语法仍然是 `MethodName Signature`，中间没有类型参数列表，所以泛型具体方法和接口方法对不上号，不会被当成接口的实现。

调用 `users.Map(...)` 时，`users` 的类型是 `List[User]` 这种具体类型。编译器知道方法是哪一个，再按 `f` 的结果实例化 `U`，后面的代码生成和普通泛型函数相同。提案里的翻译方式，是把这次调用写成「接收者变成第一个参数」的泛型函数调用。已有程序的含义不变，这是去掉一条限制。

> 接口方法仍然不能声明类型参数。`Read[E any]([]E)` 也不会因为某次可以推出 `E` 是 `byte`，就去实现 `io.Reader`。需要 `[]byte` 时，另写一个签名固定的 `Read`，在方法体里调用泛型方法。下文有完整例子。
{: .prompt-warning }

以后碰到一个操作，可以按类型参数出现的位置来选写法：

```mermaid
flowchart TD
  q["这一次调用要再引入一个类型"]
  q --> has{"这个类型是否已由接收者声明"}
  has -->|是，例如 List 的 T| plain["普通方法，1.18 起就能写"]
  has -->|否| via{"调用是否要放进接口"}
  via -->|要，例如 io.Reader| fn["签名固定的方法；泛型部分留在另一个名字上"]
  via -->|不要| gen["泛型方法，类型参数写在方法名后面"]
```

## 语法上多出来的那一对方括号

[方法声明](https://go.dev/ref/spec#Method_declarations) 从 1.27 起是：

```text
MethodDecl = "func" Receiver MethodName [ TypeParameters ] Signature [ FunctionBody ] .
```

和泛型函数一样，类型参数列表在名字后面、参数列表前面。方法上的类型参数可以和接收者上的同时存在。这样声明出来的名字是泛型方法：先实例化，才能调用或当作值使用。见规范的 [Instantiations](https://go.dev/ref/spec#Instantiations) 与 [Type parameter declarations](https://go.dev/ref/spec#Type_parameter_declarations)。

接收者的基类型仍然不能是指针或接口，方法仍然必须和基类型写在同一个包。这些规则没有放宽。

模块要使用这段语法，`go.mod` 的 `go` 行得到 `1.27`。只升级工具链、不改这一行，编译器仍按旧语言版本拒绝方法上的类型参数。

反射没有跟着开放。[`reflect`]({% post_url 2023-04-27-go-reflect-in-action %}) 不能给一个尚未实例化的泛型函数补类型实参，泛型方法同样不能通过 `Method` / `MethodByName` 取出来再在运行时决定类型参数。签名固定的那些方法（例如下面用来实现 `io.Writer` 的 `Write`）照旧出现在反射的方法列表里。

# 使用方法

## 声明

模块的语言版本要到 1.27。Go 1.21 起，`go.mod` 的 `go` 行决定语言版本；工具链已经是 1.27、但 `go` 行仍停在更早版本时，编译器不会接受方法上的类型参数。

```text
module example.com/demo

go 1.27
```
{: file="go.mod" }

最简形式是一个非泛型类型加上一个泛型方法：

```go
type Box struct{ /* ... */ }

func (b *Box) Get[T any](key string) (T, bool) { /* ... */ }
```

接收者类型本身是泛型时，方法上会出现两对方括号。左边那对只是把类型定义里的参数引进方法，名字可以换成别的标识符，约束不能在这里改写。右边那对才是这次调用自己的类型参数，约束写在这里。

```go
type Pipe[T any] struct {
	items []T
}

//            Pipe[T]          [U any]
//            接收者类型参数    方法自己的类型参数
func (p Pipe[T]) Map[U any](f func(T) U) Pipe[U] { /* ... */ }
```

方法自己的类型参数，作用域从方法名之后开始，直到方法体结束。所以它可以出现在参数、结果和后面的约束里。接收者引进的类型参数到方法名之后也在作用域中，方法的约束可以引用它们：

```go
func (p Pipe[T]) Concat[S ~[]T](extra S) Pipe[T] {
	items := make([]T, 0, len(p.items)+len(extra))
	items = append(items, p.items...)
	items = append(items, extra...)
	return Pipe[T]{items: items}
}
```

`S` 的约束 `~[]T` 用到了接收者的 `T`。`extra` 因此具备切片的长度和元素类型，元素可以追加进 `[]T`。

同一基类型上，方法的非空名字必须唯一，而且不能和字段重名。泛型不构成重载：不能再声明一个同名的、不带类型参数的 `Map`。

## 调用与类型推断

实例化规则和泛型函数相同，见规范的 [Instantiations](https://go.dev/ref/spec#Instantiations)。类型实参可以全写上，也可以在推断得出来时全部省略；部分省略必须是完整列表的一个前缀（从右往左省），空的 `[]` 不合法。

推断用的是实参类型与形参类型之间的方程，以及类型参数与其约束之间的方程。结果将要赋给哪个变量，不进入这组方程。类型参数只出现在结果里时，调用处要写出类型实参。

```go
words := Pipe[string]{items: []string{"go", "generic", "method"}}

// U 出现在 f 的结果里，从实参推断为 int。
lengths := words.Map(func(s string) int { return len(s) })

// 与上面相同，只是把类型实参写明。
lengths = words.Map[int](func(s string) int { return len(s) })
```

`words.Map` 这一步，接收者的 `T` 已经是 `string`，因为 `words` 的类型是 `Pipe[string]`。调用方实例化的只有 `U`。

> 想让调用方少写类型实参，就把类型参数放进形参，不要只放进结果。`Decode[T any](data []byte) (T, error)` 这种签名在调用点几乎总要写成 `Decode[User](data)`。
{: .prompt-tip }

1.27 还有一项独立的语言变更：把泛型函数赋给类型已知的变量，或转换成匹配的函数类型时，类型推断也适用。尚未写明类型实参的泛型方法值就是这样一个泛型函数，赋值时走同一套推断。参数能提供信息时，优先依赖参数；下面两种写法都合法：

```go
var toLen func(func(string) int) Pipe[int] = words.Map
toLen = words.Map[int]
```

## 方法表达式与方法值

方法表达式 `T.M` 得到一个函数，第一个参数是原来的接收者。方法若是泛型的，这个函数也是泛型的。接收者基类型若是泛型的，必须先实例化类型，再写方法表达式。`Pipe.Map` 不合法，`Pipe[string].Map` 才合法。

```go
// 类型：func[U any](Pipe[string], func(string) U) Pipe[U]
apply := Pipe[string].Map[int]

out := apply(words, func(s string) int { return len(s) })
```

方法值 `x.M` 在求值时记下接收者，之后调用不再传接收者。泛型方法要先实例化，得到的才是普通函数值：

```go
// 类型：func(func(string) int) Pipe[int]
toLen := words.Map[int]
lengths := toLen(func(s string) int { return len(s) })
```

指针接收者、可寻址值自动取址、`nil` 指针接收者这些规则与普通方法相同。泛型不改变方法集里「值接收者同时属于 `*T`」的那一套规定。

## 标准库里的 Rand.N

[`math/rand/v2`](https://pkg.go.dev/math/rand/v2#Rand.N) 从 Go 1.27.0 起提供：

```go
func (r *Rand) N[Int intType](n Int) Int
```

`Int` 可以是任意整数类型（带符号、无符号，以及底层类型为这些整数的定义类型）。返回值落在半开区间 `[0, n)`。`n <= 0` 时 panic。行为和顶层函数 `N` 一致，随机源换成了这个 `Rand`。

```go
r := rand.New(rand.NewPCG(1, 2))

n := r.N(uint32(10))                  // 从实参推断 Int = uint32
d := r.N(100 * time.Millisecond)      // time.Duration 的底层类型是 int64
k := r.N[int64](100)                  // 显式指定；100 是无类型常量
```

`Rand` 的其他方法，例如 `IntN`、`Int64N`、`Uint64N`，仍然是为单一宽度写的非泛型方法。`N` 把这些宽度收进一个类型参数。它不实现任何接口，这正是提案里举的「方法用于命名空间」的例子。

使用方的 `go` 行也要能看见这个符号。Go 1.27 起，`go test` 默认运行 `stdversion` 检查：文件生效的 Go 版本（由 `go` 行和构建标签决定）若早于符号引入的版本，测试会报出来。在 `go 1.26` 的模块里调用 `(*Rand).N`，会被指认为用了过新的标准库符号。

# 使用示例

前面的片段用来对照四种写法。下面三节是可以放进模块的完整代码：一条会改变元素类型的方法链、一次必须写明类型实参的取值，以及一个泛型方法旁边如何另写方法去实现接口。

## 接收者定元素类型，调用定结果类型

`Filter` 不引入新类型，1.18 就能写。`Map` 要引入 `U`，这是 1.27 的方法。两者放在一起，可以看出方法链在类型变化时怎么接。

```go
package pipe

type Pipe[T any] struct {
	items []T
}

func Of[T any](items ...T) Pipe[T] {
	return Pipe[T]{items: items}
}

func (p Pipe[T]) All() []T { return p.items }

func (p Pipe[T]) Filter(keep func(T) bool) Pipe[T] {
	out := make([]T, 0, len(p.items))
	for _, v := range p.items {
		if keep(v) {
			out = append(out, v)
		}
	}
	return Pipe[T]{items: out}
}

func (p Pipe[T]) Map[U any](f func(T) U) Pipe[U] {
	out := make([]U, len(p.items))
	for i, v := range p.items {
		out[i] = f(v)
	}
	return Pipe[U]{items: out}
}
```
{: file="pipe/pipe.go" }

```go
package pipe_test

import (
	"fmt"

	"example.com/demo/pipe"
)

func ExamplePipe() {
	words := pipe.Of("go", "generic", "method")
	lengths := words.
		Filter(func(s string) bool { return len(s) > 2 }).
		Map(func(s string) int { return len(s) })
	fmt.Println(lengths.All())
	// Output:
	// [7 6]
}
```
{: file="pipe/example_test.go" }

`Filter` 的结果仍是 `Pipe[string]`。`Map` 把 `U` 推断为 `int`，结果是 `Pipe[int]`。1.26 的等价代码要把后一步套在外层：`Map(words.Filter(keep), f)`。计算相同，类型参数 `T` 和 `U` 都写在包函数上，阅读顺序从内往外。

这个例子也说明一件容易混的事：`Of` 是泛型函数，因为它在构造时选择 `T`，那时还没有值可以当接收者。`All` 和 `Filter` 是普通方法，因为它们只使用已经选定的 `T`。只有 `Map` 需要泛型方法。

## 列类型每次不同

数据库扫描或配置表里，容器类型固定，取出的 Go 类型不固定。以前常见的写法是 `any` 加类型断言，断言写错会 panic。把断言收进方法之后，调用点写成类型实参，失败变成返回值。

`T` 不出现在参数里，推断没有方程可解，类型实参必须写出。这是这种 API 的正常形态，不是推断失灵。

```go
package row

import "fmt"

type Row struct {
	cols map[string]any
}

func (r Row) Get[T any](name string) (T, error) {
	var zero T
	v, ok := r.cols[name]
	if !ok {
		return zero, fmt.Errorf("column %q not found", name)
	}
	got, ok := v.(T)
	if !ok {
		return zero, fmt.Errorf("column %q: has %T, want %T", name, v, zero)
	}
	return got, nil
}
```
{: file="row.go" }

```go
id, err := rec.Get[int64]("id")
status, err := rec.Get[Status]("status")
```

方法内部仍然是一次类型断言。泛型改变的是调用方的类型：成功路径上 `id` 的类型就是 `int64`，编译器会检查后续用法。动态类型对不上时，错误里带有实际类型和期望类型，而不是在业务代码里 panic。

`T` 若是接口，断言的含义与普通接口断言相同：动态值实现了该接口才成功。数值宽度不会被自动转换，`int32` 存进去再用 `Get[int64]` 取，会得到错误。这正是把断言留在调用点时容易看错的那种差异。

## 既要泛型操作，又要实现接口

下面的 `Read` 看起来像 `io.Reader`，签名却多了一列类型参数。规范对接口方法的语法是 `MethodName Signature`，中间没有类型参数列表。实现检查比较的是名字和签名，两边对不上。

```go
type Buf struct{ /* ... */ }

func (b *Buf) Read[E any](p []E) (int, error) {
	return len(p), nil
}

// *Buf 的方法集里有 Read[E any]([]E) (int, error)。
// io.Reader 要求 Read([]byte) (int, error)。
var _ io.Reader = (*Buf)(nil)
```

最后一行不能通过编译。不存在一种写法，能把 `Read[byte]` 单独挑出来放进方法集。

需要同时满足接口时，写两个不同名字的方法：签名固定的那个去实现接口，在方法体里调用泛型方法。下面的 `Write` 满足 `io.Writer`；`Store` 接受任意元素类型的切片，把一份副本留在 `saved` 里。`Write` 把 `[]byte` 交给 `Store` 时，`E` 从实参推断为 `byte`。

```go
package archive

import "io"

type Archive struct {
	saved []any
}

// Write 满足 io.Writer。同一个名字不能再声明成泛型方法。
func (a *Archive) Write(p []byte) (int, error) {
	return a.Store(p)
}

// Store 保存一份 items 的副本。E 由 items 的元素类型决定。
func (a *Archive) Store[E any](items []E) (int, error) {
	cp := append([]E(nil), items...)
	a.saved = append(a.saved, cp)
	return len(cp), nil
}

var _ io.Writer = (*Archive)(nil)
```
{: file="archive.go" }

`var _ io.Writer = (*Archive)(nil)` 检查的是 `Write`。`Store` 留在具体类型上，调用写成 `a.Store(int16s)` 或 `a.Store(p)`。

```mermaid
flowchart LR
  call["调用方手里的值"] --> concrete["静态类型是 *Archive"]
  call --> asWriter["静态类型是 io.Writer"]
  concrete --> both["可以调用 Write 和 Store"]
  asWriter --> only["方法表里只有 Write"]
```

# 最佳实践

**接收者类型参数描述这个值，方法类型参数描述这一次调用。** `Pipe[T]` 的 `T` 贯穿 `Filter`、`All` 和 `Map` 的输入。`Map` 的 `U` 只属于这一次映射。若两个类型都在构造时就知道，把它们都放进类型声明，方法保持非泛型，例如 `Pair[A, B].Swap() Pair[B, A]`，这是 1.18 就有的写法。

**有第二个具体类型要共用同一段逻辑时，再增加类型参数。** 只有一种元素类型的容器，用具体类型更直白。这条判断不因方法能泛型而改变，见 [100 Go Mistakes]({% post_url 2025-12-24-100-go-mistakes %}) 对「过早使用类型参数」的讨论。

**让推断有依据。** 类型参数出现在参数里，调用可以省略类型实参，`Map` 和 `Rand.N` 都是这样。它只出现在结果里，就在 API 文档和示例里把类型实参写成调用的一部分，不要指望赋值的左侧能帮你推断。

**要进接口方法表的操作，签名里不要放类型参数。** 用一个固定签名的方法满足接口，在方法体里调用泛型方法。两个方法必须不同名。包外的编译期检查 `var _ io.Writer = (*Archive)(nil)` 仍然有用，它检查的是那个固定签名。

**没有值可以挂靠时，继续用包级函数。** `slices`、`maps` 里的算法作用在内建类型上，调用方不一定想先包一层命名类型。标准库在 1.27 也没有把这些函数改成方法，只补上了 `Rand.N` 这种「类型上本来就该有、以前语法写不出」的缺口。

**约束写成方法体真正依赖的操作。** `Concat` 需要「底层类型是 `[]T` 的切片」，所以约束是 `~[]T`。只是把值存起来或原样返回时，`any` 就够了。过宽的约束要到方法体里用类型断言补操作；过窄的约束会把合法的调用挡在外面。

# 注意事项

**接口方法的语法没有变。** 下面的声明不合法，因为类型参数列表不属于接口方法的语法：

```go
type Mapper[T any] interface {
	Map[U any](func(T) U) []U
}
```

泛型接口本身仍然合法，只是类型参数属于接口类型，不属于其中的某个方法：`type Source[T any] interface { Next() (T, bool) }`。实现它的是普通方法 `Next`，`T` 来自 `Source[int]` 这样的实例化。

**不能把泛型方法的某一个实例化登记进接口。** 讨论 #77273 时有人提议允许再写一行 `Read[byte]`，表示「这个实例化应当出现在方法集里」。该提案没有接受这个扩展。原因之一是，接收者上已有 `List[T]` 这种写法，读者很容易把它理解成「约束收紧」，和「登记一个实例化」不是同一件事。需要 `[]byte` 时，另写一个具体方法。

**方法名不能重载。** 同一类型上 `Read` 和 `Read[E any]` 是同一个名字的两次声明，后者不会覆盖或补充前者。

**未实例化的泛型方法不经过反射实例化。** 运行时根据外部输入选择 `T` 时，仍然需要自己的类型开关或代码生成。泛型方法没有提供 `reflect` 版的类型实参。签名固定的 `Write` 会和其他具体方法一样出现在反射的方法列表里；泛型的 `Store` 没有单独的一份已实例化签名，反射不能再给它补类型实参。

**语言版本写在 `go` 行里。** 只升级工具链、不改 `go 1.27`，新语法和 `(*rand.Rand).N` 都还不能用。`go test` 的 `stdversion` 会抓住「符号新于 `go` 行」这一类问题，自定义 API 则要靠编译器对方法类型参数的检查。

**分析工具要同时看两套类型参数。** `go/types` 的 `Signature` 早已分开提供接收者类型参数和签名上的类型参数。1.27 之前，方法上后者为空。现在两者可以同时非空，只假设「方法没有自己的类型参数」的程序会漏掉 `Map` 这类声明。提案估计外部工具可能要一到两个发布周期才能跟齐。

**函数字面量仍然不能声明类型参数。** 泛型方法是具名方法上的能力。闭包要泛型时，仍然要把类型参数放在外层函数或方法上，由闭包去使用。

# 参考资源

- [Go 1.27 Release Notes](https://go.dev/doc/go1.27)：语言变更原文，以及 `math/rand/v2` 中 `Rand.N` 的说明
- [Release History：go1.27.0](https://go.dev/doc/devel/release#go1.27.0)：1.27.0 于 2026-08-19 发布
- [The Go Programming Language Specification：Method declarations](https://go.dev/ref/spec#Method_declarations)
- [The Go Programming Language Specification：Instantiations](https://go.dev/ref/spec#Instantiations)
- [The Go Programming Language Specification：Type parameter declarations](https://go.dev/ref/spec#Type_parameter_declarations)
- [Proposal #77273：spec: generic methods for Go](https://github.com/golang/go/issues/77273)（Robert Griesemer，2026-01-22 提出，Go 1.27 实现）
- 更早的需求记录：[\#49085](https://github.com/golang/go/issues/49085)、[\#50981](https://github.com/golang/go/issues/50981)
- [`(*Rand).N`](https://pkg.go.dev/math/rand/v2#Rand.N) 与顶层 [`N`](https://pkg.go.dev/math/rand/v2#N)
- 站内 [Being Confused About When To Use Generics]({% post_url 2025-12-26-being-confused-about-when-to-use-generics %})：1.18–1.26「方法不能有类型参数」的背景
- 站内 [100 Go Mistakes]({% post_url 2025-12-24-100-go-mistakes %})：什么时候不该加类型参数
- 站内 [Go Reflect in Action]({% post_url 2023-04-27-go-reflect-in-action %})：反射能看到的类型信息
