---
layout: post
title:  "Pithy Wisdom: Go Proverbs for Philosophy and Pedagogy"
date:   2025-12-24 12:30:00 +0800
categories: [GoLang]
---

* Do not remove this line (it will not be displayed)
{:toc}

Rob Pike 在 2015 年 Gopherfest 上的演讲，探讨了如何通过 **“编程谚语”来传达 Go 语言的核心哲学。他借鉴了围棋中富有诗意且内涵丰富的教导方式，提出了诸如“通过通信共享内存”和“清晰优于聪明”等简洁名言。这些谚语不仅是初学者的教学工具，更封装了关于并发处理、接口设计和依赖管理的深刻工程实践。作者强调，Go 语言的真正力量不仅在于语法，更在于其社区形成的独特编程文化与思维方式**。通过这些易于记忆的准则，开发者能够更直观地理解如何编写更具可维护性与鲁棒性的代码。

> 学习 Go 语言就像学习烹饪。语法是识别食材和刀具，而这些箴言就像是顶级厨师总结出的“火候秘籍”。它们并不规定你必须切多大的块，但会告诉你“过度的调料会掩盖食材的原味”，指引你做出清爽且高质量的佳肴。


* [02:42](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=162s) Don't communicate by sharing memory, share memory by communicating.
* [03:42](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=222s) Concurrency is not parallelism.
* [04:20](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=260s) Channels orchestrate; mutexes serialize.
* [05:18](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=318s) The bigger the interface, the weaker the abstraction.
* [06:25](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=385s) Make the zero value useful.
* [07:36](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=456s) interface{} says nothing.
* [08:43](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=523s) Gofmt's style is no one's favorite, yet gofmt is everyone's favorite.
* [09:28](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=568s) A little copying is better than a little dependency.
* [11:10](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=670s) Syscall must always be guarded with build tags.
* [11:52](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=712s) Cgo must always be guarded with build tags.
* [12:37](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=757s) Cgo is not Go.
* [13:50](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=830s) With the unsafe package there are no guarantees.
* [14:34](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=874s) Clear is better than clever.
* [15:23](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=923s) Reflection is never clear.
* [16:13](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=973s) Errors are values.
* [17:27](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=1047s) Don't just check errors, handle them gracefully.
* [18:10](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=1090s) Design the architecture, name the components, document the details.
* [19:08](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=1148s) Documentation is for users.



# Go 箴言的起源与目的

* **灵感来源**：概念源自围棋（[Go game](https://en.wikipedia.org/wiki/Go_(game))）中的“围棋谚语”，用于向学习者传授复杂的模式和策略。
* **教学价值**：它们被用作一种**教学工具（Pedagogy）**，帮助开发者超越简单的语法学习，理解 Go 语言背后的深层哲学和架构决策。
* **核心特性**：有效的箴言应当是**简短、通用且具有启发性的**，即使它们在某些工程场景下可能互相对立。

# 关于并发与同步的核心观点

* **不要通过共享内存来通信，而要通过通信来共享内存**：这是最著名的 Go 箴言，强调通过通道（Channel）传递指针或对象所有权，以实现安全的并发。
* **并发（Concurrency）不等于并行（Parallelism）**：并发是关于**程序结构的组织**（使其可扩展、易理解），而并行是关于多任务的**同时执行**。
* **通道负责编排，互斥锁负责序列化**：互斥锁（Mutexes）用于细粒度的内存保护，而通道（Channels）用于协调程序的大规模结构。

# 接口与抽象的设计哲学

* **接口越大，抽象越弱**：强大的抽象（如 `io.Reader`）通常只有极少的方法。接口越小，复用性和组合性就越强。
* **空接口（`interface{}`）不传达任何信息**：过度使用空接口会丧失静态检查的优势。开发者应尽量定义具体的接口方法来明确意图。


# 软件工程与代码质量

* **让零值（`Zero Value`）变得有用**：优秀的 API 设计应确保类型的零值无需显式初始化即可直接使用（如 `sync.Mutex` 或 `bytes.Buffer`）
* **宁可少量的拷贝，也不要增加依赖**：为了保持依赖树的精简和编译速度，有时拷贝几行代码比引入一个庞大的库更明智。
* **清晰胜过聪明**：Go 追求代码的可维护性和稳定性，不鼓励追求极度紧凑或深奥的“聪明”写法。
* **`gofmt` 的风格没人喜欢，但它是每个人的最爱**：标准化的格式化工具虽然不能满足所有人的审美，但消除了关于代码样式的无谓争论。


# 错误处理与底层机制

* **错误是值（`Errors are values`）**：不要仅仅把错误当成异常处理，它们是可以被编程、存储和传递的对象。
* **不要只检查错误，要优雅地处理它们**：开发者应考虑如何对错误进行包装或根据错误采取具体行动，而不仅仅是向上层返回。
* **警惕 Cgo、Unsafe 和反射**
  + **CGO 不是 Go**：使用 CGO 会破坏内存安全、垃圾回收和跨平台稳定性。
  + **反射永不清晰**：反射非常强大但难以使用且缺乏编译时检查，建议初学者远离。
  + **unsafe 包没有任何保证**：使用它意味着代码可能在未来的版本中失效。

# 文档与命名

* **设计架构，命名组件，记录细节**：良好的命名应承担表达设计意图的主要责任。
* **文档是给用户看的**：编写文档（GoDoc）时应站在使用者的角度，而非实现者的角度。


# Refer

* [Gopherfest 2015 - Go Proverbs with Rob Pike](https://www.youtube.com/watch?v=PAAkCSZUG1c)
* https://www.youtube.com/@golang
* https://notebooklm.google.com/notebook/fe1d8b50-fdaa-4be5-aa92-524039b32f81 (NotebookLM 解读)












