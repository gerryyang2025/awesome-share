---
layout: post
title: "Singleflight：并发请求合并原理与实践"
date: 2026-05-08 20:30:00 +0800
last_modified_at: 2026-05-08 20:30:00 +0800
description: "用 singleflight 解决并发下的“缓存击穿/惊群”：把同 key 的重复请求合并为一次执行。本文以 janos/singleflight（resenje.org/singleflight）为例，讲原理、与 x/sync/singleflight 的差异、以及可运行示例。"
categories: [GoLang]
tags:
  - GoLang
  - Concurrency
  - singleflight
  - Context
---

* Do not remove this line (it will not be displayed)
{:toc}

## 这篇文章解决什么问题

当你的服务在高并发下被大量请求同一个“昂贵资源”（比如同一个用户资料、同一个商品详情、同一个配置），最常见的故障路径是：

- **缓存 miss**（或缓存过期）导致请求穿透到 DB / 下游
- 同一时刻大量协程/请求都去做同一件事（同一个 key 的查询、同一个远程调用）
- 下游被重复请求压垮，延迟飙升，进一步触发超时与重试，形成雪崩

这类问题常被概括为 **Thundering Herd（惊群）** 或 “缓存击穿”。`singleflight` 的核心思路非常简单：**同一时刻对同一个 key 的并发调用只执行一次，其它调用等待并复用这次结果**。

本文基于开源实现 [`janos/singleflight`](https://github.com/janos/singleflight)（Go module 为 `resenje.org/singleflight`）来讲解与演示。

## 与 `golang.org/x/sync/singleflight` 有什么不同

标准库生态里的 `golang.org/x/sync/singleflight` 已经很常用，但它有两个让人“用起来不够顺手”的点：

- **类型不安全**：返回值是 `interface{}`，调用方要做断言；错了就运行时 panic。
- **context 取消模型不够理想**：当等待者里有人 `ctx.Done()` 时，怎么影响正在执行的那次“真正调用”，在很多业务里需要更细粒度的策略。

`janos/singleflight` 的目标就是在保持 singleflight 模型的同时，提供：

- **泛型（Go 1.18+）**：`Group[K, V]` 直接给出强类型 `V`
- **更智能的取消语义**：文档描述为：**只有当所有等待者的 context 都取消后，执行函数的 context 才会被取消**，避免“某个等待者超时了，把真正执行也提前取消”这种尴尬情况

> 这不是“谁更好”的问题，而是**你希望取消语义是什么**。对“聚合请求、谁来都要算一次”的场景，这种“所有等待者都取消才取消”通常更符合直觉；对“只要没人等就没必要算”的场景，也更节省资源。

### 实现差异与（更贴近业务的）优化点

把两者都当作“同一轮同 key 合并一次执行”的工具时，差异主要集中在**类型、取消/超时传播、以及 key 的表达能力**上：

- **类型与 key 的表达能力**
  - 官方 `x/sync/singleflight`：`key` 是 `string`，返回值是 `interface{}`，业务里通常需要 `fmt.Sprintf` 拼 key + 做类型断言。
  - `janos/singleflight`：`Group[K, V]` 里 **key 是任意 `comparable` 类型**、value 是强类型 `V`。这在工程上往往能减少两类 bug/成本：
    - 少写一堆字符串拼接（减少临时分配，也避免 key 格式写错）
    - 少做类型断言（避免运行时 panic）

- **取消/超时语义（核心差别）**
  - 官方包的 `Do/DoChan` 本身不接收 `context`，因此“某个等待者超时/取消”通常只能影响等待者自己（例如 `select` 超时直接返回），而**不会自然地传递到正在执行的那次 `fn`**；`Forget` 也只是让后续调用开启新一轮执行，并不会取消正在执行的那次调用。
  - `janos/singleflight` 的 `Do(ctx, key, fn)` 把 context 纳入模型，并强调一种更适合“抗惊群”的语义：**只有当所有等待者都取消后，才取消那次真正执行的 `fn` 的 context**。这可以减少“局部超时 → 全局误取消 → 下一波又重新回源”的抖动与放大效应。

- **更容易落地的工程习惯**
  - 两者都会告诉你结果是否 `shared`（是否复用了同一轮合并执行的结果）。在缓存回源场景里，一个常见的工程优化是：**只有 `shared=false` 的那次负责写缓存/打点**，避免同一轮里重复写入或重复统计。

## 官方 `golang.org/x/sync/singleflight` 用法速查

很多时候你不需要额外的取消语义/泛型能力，只要“同 key 合并一次执行”就够了，这时官方包就非常合适：

```bash
go get golang.org/x/sync/singleflight
```

`singleflight` 提供的是一种**重复函数调用抑制机制**：在高并发下，多个 goroutine 同时请求相同资源（同一个 key）时，把并发请求合并成一次执行，让其它调用方等待并共享结果，从而缓解“缓存击穿/惊群”。

### 核心 API：`Group` 的 `Do` / `DoChan` / `Forget`

- **`Do(key, fn)`**：同步阻塞。对同一个 key，第一个调用执行 `fn`，后续调用阻塞等待并共享结果。返回值里的 `shared=true` 表示“这一轮结果被多个调用方共享”，不代表缓存命中。
- **`DoChan(key, fn)`**：异步版 `Do`。返回 `<-chan Result`，适合配合 `select` 做超时/取消控制。
- **`Forget(key)`**：从 `Group` 内部映射里移除 key。移除后，新的调用会重新执行 `fn`（而不是复用之前那次正在执行/已完成的结果）。

### 示例：用 `Do` 防缓存击穿（缓存 + DB 回源）

这个例子演示最常见的模式：先查缓存，miss 时用 `singleflight` 合并回源查询，并在回源函数里**二次查缓存**防止等待期间缓存已被填充。

```go
package main

import (
	"fmt"
	"log"
	"sync"
	"time"

	"golang.org/x/sync/singleflight"
)

// 模拟缓存：用 sync.Map 保证并发安全
var cache sync.Map

func fetchFromDB(key string) (string, error) {
	log.Printf("[DB] query start: key=%s", key)
	time.Sleep(1 * time.Second)
	return fmt.Sprintf("value_for_%s_from_db", key), nil
}

func getOrCreate(g *singleflight.Group, key string) (interface{}, error) {
	// 1) 先查缓存
	if val, ok := cache.Load(key); ok {
		log.Printf("[Cache Hit] key=%s", key)
		return val, nil
	}

	// 2) 缓存 miss，用 singleflight 合并回源
	val, err, _ := g.Do(key, func() (interface{}, error) {
		// 二次查缓存：避免等待期间其他并发已写回缓存
		if val, ok := cache.Load(key); ok {
			return val, nil
		}
		dbVal, err := fetchFromDB(key)
		if err != nil {
			return nil, err
		}
		cache.Store(key, dbVal)
		return dbVal, nil
	})
	return val, err
}

func main() {
	var g singleflight.Group
	key := "hot_key"

	const n = 10
	var wg sync.WaitGroup
	wg.Add(n)

	for i := 0; i < n; i++ {
		i := i
		go func() {
			defer wg.Done()
			val, err := getOrCreate(&g, key)
			if err != nil {
				log.Printf("goroutine %d err: %v", i, err)
				return
			}
			log.Printf("goroutine %d got: %v", i, val)
		}()
	}
	wg.Wait()
}
```

你会看到 `[DB]` 日志只出现一次，说明昂贵查询只执行了一次，其它请求共享结果。

### `DoChan`：可超时等待（常与 `Forget` 搭配）

`DoChan` 返回 `<-chan singleflight.Result`，适合对延迟有硬要求的调用方：超时后不必无限等待。

```go
func getOrCreateWithTimeout(g *singleflight.Group, key string, timeout time.Duration) (interface{}, error) {
	if val, ok := cache.Load(key); ok {
		return val, nil
	}

	ch := g.DoChan(key, func() (interface{}, error) {
		// 这里演示直接回源；真实业务建议同样做二次查缓存
		return fetchFromDB(key)
	})

	select {
	case result := <-ch:
		if result.Err != nil {
			return nil, result.Err
		}
		// 注意：DoChan 只负责把结果送回来；缓存写回/指标统计仍由你自己处理
		cache.Store(key, result.Val)
		return result.Val, nil
	case <-time.After(timeout):
		// 超时后可选择 Forget：让后续请求触发新一轮执行，避免一直挂在慢请求上
		g.Forget(key)
		return nil, fmt.Errorf("timeout waiting for key=%s (>%v)", key, timeout)
	}
}
```

### 关键细节与最佳实践（官方包也同样适用）

1. **错误也会被“共享”**
   - 同一轮合并执行如果返回 error，等待者会一起收到这个 error。
   - 如果你的业务希望“失败后立刻允许重试”，可以在失败场景 `Forget(key)`，避免后续调用继续复用/等待同一轮失败结果。

2. **`Do` vs `DoChan` 的选择**
   - **优先用 `Do`**：简单直接，适用于大多数“回源合并”的场景。
   - **需要超时/不想无限阻塞时用 `DoChan`**：配合 `select` 做超时，必要时 `Forget` 解除对慢调用的绑定。

3. **别把不可重入的副作用塞进 `fn`**
   - `singleflight` 更适合“纯读”或“幂等”的昂贵操作（读 DB、请求第三方、生成可缓存结果）。
   - 像扣库存/发短信这种副作用，会因为“只执行一次”而改变语义。

4. **局限性：进程内有效 + key 高基数会占内存**
   - `singleflight` 的合并只在**单进程内**生效；分布式场景要靠分布式锁/一致性哈希/集中缓存来做跨节点合并。
   - `Group` 内部维护 key→call 的状态，如果 key 种类极多且生命周期短，建议评估内存占用，并在合适时机 `Forget`（或控制 key 的粒度）。

## 安装

在你的 Go module 里：

```bash
go get resenje.org/singleflight
```

## 最小可运行示例：同 key 合并为一次执行

这个示例会并发发起多次对同一个 key 的请求，但真正的“昂贵操作”只会执行一次，其它协程复用结果。

```go
package main

import (
	"context"
	"fmt"
	"sync"
	"time"

	"resenje.org/singleflight"
)

func main() {
	var g singleflight.Group[string, string]

	const n = 5
	var wg sync.WaitGroup
	wg.Add(n)

	for i := 0; i < n; i++ {
		i := i
		go func() {
			defer wg.Done()

			v, shared, err := g.Do(context.Background(), "user:42", func(ctx context.Context) (string, error) {
				fmt.Println("expensive query: start")
				time.Sleep(120 * time.Millisecond)
				fmt.Println("expensive query: end")
				return "profile-of-42", nil
			})

			if err != nil {
				fmt.Printf("goroutine %d error: %v\n", i, err)
				return
			}
			fmt.Printf("goroutine %d got=%q shared=%v\n", i, v, shared)
		}()
	}

	wg.Wait()
}
```

你会看到日志里 `expensive query: start/end` 只出现一次，而 `shared=true` 的 goroutine 会有多个。

## `shared` 的含义（非常关键）

`Do` 的返回值通常是：

- **value**：类型安全的结果
- **shared**：是否复用了别人那次执行的结果
- **error**：错误

`shared=true` 不代表“这是缓存命中”，只代表“你的结果来自同一轮合并执行”。

一个常见用法是：**只有 `shared=false` 的调用方负责把结果写回缓存**（防止同一轮里多个等待者重复写缓存或重复上报指标）。

## 场景示例：用在缓存 miss 的回源（读穿）

### 需求

你有 `GetUserProfile(userID)`：

- 先查缓存
- 缓存 miss 时回源查 DB
- 结果写入缓存

如果同一时刻大量请求都在查同一个 `userID`，你希望只有一个请求去打 DB。

### 示例（可直接复用到你的服务结构里）

```go
package profile

import (
	"context"
	"fmt"
	"time"

	"resenje.org/singleflight"
)

type Cache interface {
	Get(ctx context.Context, key string) (string, bool, error)
	Set(ctx context.Context, key, val string, ttl time.Duration) error
}

type Store interface {
	LoadProfile(ctx context.Context, userID string) (string, error)
}

type Service struct {
	cache Cache
	store Store
	sf    singleflight.Group[string, string]
}

func (s *Service) GetProfile(ctx context.Context, userID string) (string, error) {
	key := fmt.Sprintf("profile:%s", userID)

	if v, ok, err := s.cache.Get(ctx, key); err == nil && ok {
		return v, nil
	}

	v, shared, err := s.sf.Do(ctx, key, func(ctx context.Context) (string, error) {
		// 再查一遍缓存：避免“刚好被其它请求填充了缓存”的重复回源
		if v, ok, err := s.cache.Get(ctx, key); err == nil && ok {
			return v, nil
		}

		p, err := s.store.LoadProfile(ctx, userID)
		if err != nil {
			return "", err
		}
		return p, nil
	})
	if err != nil {
		return "", err
	}

	// 只有非 shared 的那次写缓存（减少重复写入）
	if !shared {
		_ = s.cache.Set(ctx, key, v, 30*time.Second)
	}

	return v, nil
}
```

这里有两个容易忽略但非常实用的点：

- **回源函数内二次查缓存**：防止“缓存已经被其它请求写回了，但你仍然去 DB”。
- **缓存写回只让 shared=false 的那次负责**：更干净，指标也更好统计（例如 `singleflight_primary=1`）。

## 取消语义：为什么这个库强调“只有全体取消才取消执行”

在一个典型的合并中，会出现多种 caller：

- A：用户请求超时 100ms
- B：后台任务超时 1s
- C：另一个 API 调用没有超时

如果执行函数的 context “跟着最早取消的 caller 走”，就会出现：A 超时了 → 把执行也取消了 → B/C 也拿不到结果 → 于是下一波请求又开始回源，反而更糟。

`janos/singleflight` 的语义（按其 README 描述）是：**只有当所有等待者都取消后，执行函数才会被取消**。这样通常能更稳定地“顶住惊群”：哪怕部分请求已经不等了，只要还有人在等，就把这次执行跑完，让后续复用结果。

> 业务落地建议：把“是否值得继续算”的逻辑放到你的执行函数里（例如检测下游负载、熔断状态、请求数等），不要依赖单个 caller 的超时来决定全局取消。

## 进阶建议与常见坑

### 1) key 的粒度要对

- **太粗**：例如所有用户都用一个 key，会把完全不相干的请求串行化，延迟变大。
- **太细**：例如把时间戳带进 key，会完全失去合并效果。

经验上：key 应该对应“昂贵资源”的自然唯一标识（如 `user:42`、`item:123`、`config:prod`）。

### 2) singleflight 不是缓存

`singleflight` 只对“同一时刻”的并发生效；如果你的资源本身可缓存，仍然要配合缓存（内存/Redis）来降低总体回源次数。

### 3) 错误也会被共享

同一轮合并执行如果返回错误，等待者会一起收到这个错误。对外部依赖不稳定的场景，要配合退避、熔断、降级，否则错误会被“更高效地传播”。

### 4) 不要在执行函数里做不可重入的副作用

例如“扣库存、发短信、写审计日志”等，会因为“只有一次执行”而改变语义。`singleflight` 更适合 **纯读** 或 **幂等** 的昂贵操作（读 DB、请求第三方、生成可缓存结果）。

## Reference

- `janos/singleflight`：一个支持泛型、强调更合理取消语义的 singleflight 实现：[`https://github.com/janos/singleflight`](https://github.com/janos/singleflight)
- Go 官方 `x/sync/singleflight`（对照阅读）：[`https://pkg.go.dev/golang.org/x/sync/singleflight`](https://pkg.go.dev/golang.org/x/sync/singleflight)

