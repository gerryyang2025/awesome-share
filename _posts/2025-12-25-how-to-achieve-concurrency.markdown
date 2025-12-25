---
layout: post
title:  "How to achieve concurrency"
date:   2025-12-25 08:30:00 +0800
categories: [GoLang]
---

* Do not remove this line (it will not be displayed)
{:toc}


本文介绍了 Go 语言 如何通过其核心机制实现高效的并发编程。对比了传统同步处理文件的低效性，并展示了如何利用 Goroutines 这种轻量级线程来独立执行多个任务。为了管理这些并发操作，程序使用 Channels 作为数据通信的管道，在不同任务之间安全地传递结果。这种设计允许程序在数据准备就绪前自动阻塞等待，从而简化了复杂的异步逻辑。通过结合这两大特性，开发者可以更轻松地构建高性能且结构简洁的应用程序。

传统的编程就像**只有一个厨师的厨房**，他必须切完所有的菜才能开始炒菜，非常耗时。而 Go 语言的并发就像是**请了一群助手（Goroutines）**，每个助手负责处理一样食材，并把处理好的食材通过一条**传送带（Channels）**送到主厨面前。主厨不需要时刻盯着助手，他只需要在传送带末端等着，**有食材送达时再继续下一步工作**，这大大提升了整个厨房的出菜速度。

# 并发的核心定义

**并发（Concurrency）独立地处理多个任务**。相比于传统的同步执行（按顺序一个接一个地等待任务完成），并发可以显著提高处理 I/O 密集型任务（如读取文件）的效率。

# Go 语言的两大核心并发特性

Go 语言通过内置的两个功能简化了异步编程：

* **Goroutines（协程）**：可以被视为一种极其高效的线程。通过在函数调用前使用 `go` 关键字，程序可以为每个任务启动一个 goroutine，从而实现并发执行。
* **Channels（通道）**：通道是用于在 goroutines 之间发送和接收数据的工具，它确保了数据流动的有序性。

# 通道（Channels）的工作机制

* **管道比喻**：来源将通道比作一根管道（Pipe），一端用于发送数据，另一端用于接收数据。
* **自动同步功能**：通道不仅负责传递结果（如错误信息或成功标志），还起到了协调执行顺序的作用。当代码尝试从通道接收值时，它会自动进入等待状态，直到有数据到达才会继续执行，这保证了程序不会在任务完成前尝试打印结果,。

# 主要优势

使用 goroutines 和 channels 可以极大简化应用程序中的异步编程，使开发者能够以更简单、更直观的方式编写高效的并发代码。

# 总结

**想象有这样一场接力赛**：

1. **准备阶段**：明确要分头行动（并发概念）。
2. **起跑**：多名运动员（Goroutines）同时出发，不再排队等候。
3. **传递信息**：运动员通过接力棒（Channels）传递处理好的信息。
4. **终点汇总**：裁判（主程序）在终点线等待，只有接到接力棒时才会记录成绩（自动同步），确保不会在比赛结束前宣布结果。

![notebooklm9](/assets/images/202512/notebooklm9.png)

![notebooklm18](/assets/images/202512/notebooklm18.png)

# Refer

* [How to achieve concurrency](https://www.youtube.com/watch?v=PfbFtY0aHbI&list=TLGGqdK3vOoML-EyNDEyMjAyNQ)
* https://www.youtube.com/@golang
* https://notebooklm.google.com/notebook/de556dc2-5421-4a1d-b3b0-d6f3b44ad564 (NotebookLM 解读)












