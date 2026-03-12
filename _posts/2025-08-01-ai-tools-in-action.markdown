---
layout: post
title:  "AI Tools in Action"
date:   2025-08-01 12:30:00 +0800
categories: ML
tags:
  - AI Tools
  - Machine Learning

---

* Do not remove this line (it will not be displayed)
{:toc}


# 部署 LLM 和使用方案

## [Ollama](https://github.com/ollama/ollama)

Get up and running with large language models. Ollama 是一个开源工具，旨在帮助你在本地轻松运行和部署大型语言模型。

英文测试：

![ds_local4](/assets/images/202502/ds_local4.png)

中文测试：

![ds_local5](/assets/images/202502/ds_local5.png)


## [Cherry Studio](https://github.com/CherryHQ/cherry-studio)

除了通过 Terminal 与大模型交互，也可以通过 Cherry Studio 提供的 GUI 图形界面工具访问本地的大模型。例如：查看 Ollama 在本地监听的地址：`localhost:11434`，这是 Ollama 服务的默认接口地址。

![ds_local6](/assets/images/202502/ds_local6.png)

然后在 Cherry Studio 设置 -> 模型服务 -> Ollama 中，将 API 地址设置为 `http://localhost:11434/v1/`，并添加本地创建的模型，其中模型 ID 为：`modelscope.cn/unsloth/DeepSeek-R1-Distill-Qwen-7B-GGUF`，添加完成后，点击检查，测试连接是否成功。**注意：模型 ID 务必填写与之前下载的模型版本完全一致的名称，否则会连接失败**。

![ds_local7](/assets/images/202502/ds_local7.png)

连接成功后，创建一个智能体 agent 命名为 `gerry_local_agent` 并设置使用本地创建的大模型 `modelscope.cn/unsloth/DeepSeek-R1-Distill-Qwen-7B-GGUF`。

![ds_local8](/assets/images/202502/ds_local8.png)

测试功能：

![ds_local9](/assets/images/202502/ds_local9.png)

![ds_local10](/assets/images/202502/ds_local10.png)


## [Continue](https://marketplace.visualstudio.com/items?itemName=Continue.continue) (VS CODE 扩展)

Continue is the leading open-source AI code assistant. You can connect any models and any context to build custom autocomplete and chat experiences inside VS Code and JetBrains.

配置选择本地部署的模型服务：

![continue](/assets/images/202502/continue.png)

通过 `command + I` 触发交互命令 (Edit highlighted code)，输入：实现计算一个最大公约数的代码。

![continue2](/assets/images/202502/continue2.png)

选中需要修改的代码，通过 `command + L` 获取当前代码内容 (Add to chat)，输入下一个指令：对当前代码生成注释。

![continue3](/assets/images/202502/continue3.png)

最后选择 accept 接受，完成代码编写。



## [ima.copilot](https://ima.qq.com/) (会思考的知识库)

ima.copilot (简称 ima) 是一款由腾讯混元大模型提供技术支持的智能工作台产品。

![ima](/assets/images/202502/ima.png)




## [Cursor](https://cursor.com/cn/docs)

> Built to make you extraordinarily productive, **Cursor** is the best way to code with AI.

`Cursor` 是 `VS Code` 的一个分支。这使我们能够专注于与 AI 进行编码的最佳方式，同时提供熟悉的文本编辑体验。

![cursor0](/assets/images/202503/cursor0.png)

详细介绍：[Cursor in Action](http://gerryyang.com/ml/2025/03/11/cursor-in-action.html)



## [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview)

> Claude is a highly performant, trustworthy, and intelligent AI platform built by Anthropic. Claude excels at tasks involving language, reasoning, analysis, coding, and more.

**Claude Code** is an **agentic coding tool** that lives in your **terminal**, understands your codebase, and helps you code faster by executing routine tasks, explaining complex code, and handling git workflows -- **all through natural language commands**. Use it in your **terminal**, **IDE**, or `tag @claude` on Github.

![cc_example](/assets/images/202601/cc_example.gif)

详细介绍：[Claude Code in Action](http://gerryyang.com/ml/2025/08/06/claude-code-in-action.html)



## [cline](https://cline.bot/) (AI assistant that can use your **CLI** a**N**d **E**ditor，支持 VS CODE 扩展)

Autonomous coding agent right in your IDE, capable of creating/editing files, executing commands, using the browser, and more with your permission every step of the way.

https://github.com/cline/cline

![cline1](/assets/images/202601/cline1.png)

![cline2](/assets/images/202601/cline2.png)



# Drawing

## [Next AI Draw.io](https://github.com/DayuanJiang/next-ai-draw-io)

A Next.js web application that integrates AI capabilities with draw.io diagrams. Create, modify, and enhance diagrams through natural language commands and AI-assisted visualization.

Features:

![ai-draw](/assets/images/202512/ai-draw.png)



## Nano Banana (Gemini)

* https://aistudio.google.com/prompts/new_chat
* https://aistudio.google.com/apps/bundled/pixshop?showPreview=true&showAssistant=true
* https://nanobananaprompt.org/prompts/
* https://github.com/JimmyLv/awesome-nano-banana

### 手办 (Prompt)

```
Use the nano-banana model to create a 1/7 scale commercialized figure of thecharacter in the illustration, in a realistic style and environment. Place the figure on a computer desk, using a circular transparent acrylic base without any text.On the computer screen, display the ZBrush modeling process of the figure. Next to the computer screen, place a BANDAI-style toy packaging box printed with the original artwork.

中文含义：使用 nano-banana 模型制作一个 1/7 比例的实体模型，风格和环境保持写实。将模型摆放在电脑桌上，底座为圆形透明亚克力材质，且不带任何文字。电脑屏幕上显示的是该模型在 ZBrush 中的建模过程。在电脑屏幕旁边，放置一个 TAMIYA 风格的玩具包装盒，包装盒上印有原始插画。
```

```
transform this image into: A casual photograph of a collectible figure/model kit on a workspace desk with its original packaging box. Scattered hobby tools and supplies around. Background shelves with collections. Natural indoor lighting, soft shadows, smartphone camera quality, warm room ambiance, realistic color temperature, candid photography style.
```

进一步，可以用[即梦](https://jimeng.jianying.com/)或[通义万相](https://tongyi.aliyun.com/wanxiang/)把图片转成视频。

### 自拍照 (Prompt)

```
将上传的人物照片转换成高分辨率的肖像艺术作品，采用编辑类和现代艺术摄影风格。可以改变人物的动作姿势、表情、服饰、造型，增强画面张力。突出人物面部和光影质感。背景呈现柔和渐变效果，从中灰过渡到近乎纯白，营造出层次感与氛围感。细腻的胶片颗粒质感为画面增添了一种柔和质地，让人联想到经典的肖像摄影
```

```
将上传的人物照片转换成高分辨率的黑白肖像艺术作品，采用编辑类和现代艺术摄影风格。可以改变人物的动作姿势、表情、服饰、造型，增强画面张力。突出人物面部和光影质感。背景呈现柔和渐变效果，从中灰过渡到近乎纯白，营造出层次感与氛围感。细腻的胶片颗粒质感为画面增添了一种柔和质地，让人联想到经典的黑白摄影
```

```
将上传的照片转换成高分辨率的彩色肖像摄影作品，采用编辑类和现代艺术摄影风格。背景呈现柔和渐变效果，从中灰过渡到近乎纯白，营造出层次感与氛围感。细腻的胶片颗粒质感为画面增添了一种柔和质地
```

### 万圣节

Maintain the character’s original appearance and details, add Halloween makeup devil horns and demonic features.  ([Featured Nano Banana AI Prompts](https://nanobananaprompt.org/))




# AI Agent


## [Coze Studio](https://github.com/coze-dev/coze-studio)


[Coze Studio](https://www.coze.cn/home) is an **all-in-one AI agent development tool**. Providing the latest large models and tools, various development modes and frameworks, Coze Studio offers the most convenient AI agent development environment, from development to deployment.

* **Provides all core technologies needed for AI agent development**: `prompt`, `RAG`, `plugin`, `workflow`, enabling developers to focus on creating the core value of AI.

* **Ready to use for professional AI agent development at the lowest cost**: Coze Studio provides developers with complete app templates and build frameworks, allowing you to quickly construct various AI agents and turn creative ideas into reality.



## [Eino](https://github.com/cloudwego/eino) (基于 GoLang 的 AI 应用开发框架)

**Eino**`['aino]` (**pronounced similarly to "I know"**) aims to be **the ultimate LLM application development framework in Golang**. Drawing inspirations from many excellent LLM application development frameworks in the open-source community such as `LangChain` & `LlamaIndex`, etc., as well as learning from cutting-edge research and real world applications, **Eino** offers an LLM application development framework that emphasizes on **simplicity**, **scalability**, **reliability** and **effectiveness** that better aligns with Golang programming conventions.

What **Eino** provides are:

* a carefully curated list of **component** abstractions and implementations that can be easily reused and combined to build LLM applications
* a powerful **composition** framework that does the heavy lifting of strong type checking, stream processing, concurrency management, aspect injection, option assignment, etc. for the user.
* a set of meticulously(细致地) designed **API** that obsesses on simplicity and clarity.
* an ever-growing collection of best practices in the form of bundled **flows** and **examples**.
* a useful set of tools that covers the entire development cycle, from visualized development and debugging to online tracing and evaluation.

With the above arsenal, **Eino** can **standardize, simplify, and improve efficiency at different stages of the AI application development cycle**:

![eino_concept](/assets/images/202508/eino_concept.png)


More:

* https://www.cloudwego.io/zh/docs/eino/
* [大语言模型应用开发框架 —— Eino 正式开源](https://www.cloudwego.io/zh/docs/eino/overview/eino_open_source/)
* [Eino: 编排的设计理念](https://www.cloudwego.io/zh/docs/eino/core_modules/chain_and_graph_orchestration/orchestration_design_principles/)


## [Dify](https://github.com/langgenius/dify)

**Dify** is an open-source platform for developing LLM applications. Its intuitive interface combines agentic AI workflows, RAG pipelines, agent capabilities, model management, observability features, and more—allowing you to quickly move from prototype to production.


## [LangGraph](https://github.com/langchain-ai/langgraph)

Trusted by companies shaping the future of agents – including Klarna, Replit, Elastic, and more – LangGraph is a low-level orchestration framework for building, managing, and deploying long-running, stateful agents.

[LangGraph quickstart](https://langchain-ai.github.io/langgraph/agents/agents/)



# Workflow Engine

## [Temporal](https://github.com/temporalio/temporal) (golang)

Temporal 产品和 Demo 介绍：https://www.youtube.com/watch?v=wIpz4ioK0gI

> Developing your application on the **Temporal** platform gives you a secret weapon—durable execution—which guarantees that your code runs to completion no matter what. The result? Bulletproof applications that are faster to develop and easier to support.


**Temporal** is a durable execution platform that enables developers to build scalable applications without sacrificing productivity or reliability. The Temporal server executes units of application logic called Workflows in a resilient manner that automatically handles **intermittent**(断断续续的) failures, and retries failed operations.

**Temporal** is a mature technology that originated as a fork of Uber's Cadence. It is developed by [Temporal Technologies](https://temporal.io/), a startup by the creators of Cadence.


![temporal](/assets/images/202508/temporal.png)

![temporal2](/assets/images/202508/temporal2.png)


### Deployments

实际的部署方案可参考 [Temporal Platform production deployments](https://docs.temporal.io/production-deployment)

To take your application to production, you deploy your application code, including your Workflows, Activities, and Workers, on your infrastructure using your existing build, test and deploy tools.**Then you need a production-ready Temporal Service to coordinate the execution of your Workflows and Activities**.You can use **Temporal Cloud**, a fully-managed platform, or you can **self-host the service**.

> Use Temporal Cloud

You can let us handle the operations of running the Temporal Service, and focus on your application. Follow the [Temporal Cloud guide](https://docs.temporal.io/cloud) to get started.


![temporal3](/assets/images/202508/temporal3.png)


> Run a Self-hosted Temporal Service

Alternatively, you can run your own production level Temporal Service to orchestrate your durable applications. Follow the [Self-hosted guide](https://docs.temporal.io/self-hosted-guide) to get started.

![temporal4](/assets/images/202508/temporal4.png)


### [How Temporal works and how it works for you](https://temporal.io/how-it-works)


> Write your business logic as code

**Temporal SDKs** provide a foundation for your application. Choose the SDK for your preferred language and write your business logic. You can use your favorite IDE, libraries, and tools as you code and then you can build, deploy, and run the application wherever and however you choose.

> Create Workflows that guarantee execution

A **Temporal Workflow** defines your business logic. It might involve moving money between bank accounts, processing orders, deploying cloud infrastructure, training an AI model, or something else entirely.

Because the full running state of a workflow is durable and fault tolerant by default, your business logic can be recovered, replayed or paused from any arbitrary point.

> Code Activities to handle and retry failure-prone logic

Applications need to interact with the messy real world of services, users and devices that are inherently failure prone or take a long time to respond.

With Temporal, these parts of your logic are implemented as Activities, separate functions or methods orchestrated by the Workflow. **Temporal Activities can be run for as long as necessary (with heartbeat), can be automatically retried forever (set as policy) and can be routed to specific services or processes**.

> Deploy your application on YOUR infrastructure

You deploy your application code (Workflow and Activities) on your infrastructure using your existing build, test and deploy tools.

It's up to you how you structure your application. Temporal can be gradually introduced into your existing architecture, be it a monolith or a complex web of microservices.

> Connect your application to a Temporal Service

The **Temporal Service** coordinates the execution of your application code — **Workflows and Activities** — by exchanging events with Workers. The Service can be self-hosted or fully managed and serverless with Temporal Cloud.

Workers poll a Task Queue that feeds it tasks to execute. It reports the result back to the Service, which responds by adding additional tasks to the queue, repeating this process until execution is finished.

The Service maintains a detailed history of every execution. If the app crashes, another Worker automatically takes over by replaying this history in order to recover the state prior to the crash, and then continues.

> Temporal is secure by design

**Workflow** and **Activities** are deployed as part of your application, on your infrastructure and all connections from your app to the **Temporal Service** are **unidirectional(单向的)** so you never need to open up the firewall.

All communications are secure and your data is **encrypted** within your app, with your encryption library and keys. The **Temporal Service** never needs to access your data in clear text.

> Tune Workers to increase scale and availability

At runtime, applications can grow from a few to several thousand instances depending on your requirements for scale, performance and availability. **We recommend that every application has at least two Workers, so there’s no single point of failure**.

You can tune your Workers for optimal performance and we've tested **Temporal Cloud** to scale beyond 200 million executions per second.

> Manage the Temporal Server using terminal

A command-line interface available for macOS, Windows, and Linux enables you to interact with the Temporal Service from your terminal. It allows you to manage Workflow executions and view history.

Additionally, it can be used to spin up (start-dev) a self-contained lightweight Server in less than two seconds, allowing you to develop and test Temporal applications right from your laptop.

> Monitor individual executions of your application

Finally, the **Temporal Web UI** allows you to inspect details of past and present Workflow Executions from a convenient browser-based interface. It can help you to quickly isolate, debug, and resolve production problems.

![temporal5](/assets/images/202508/temporal5.png)


# AI 检测平台

## [朱雀 AI 检测](https://matrix.tencent.com/ai-detect/)

朱雀 AI 检测，是腾讯混元安全团队朱雀实验室推出的 AI 检测工具，包括 AI 生成图片检测系统和 AI 生成文本检测系统，识别 AI 生成的图片和文本内容。

**AI 生成图片检测系统**，通过捕捉真实图片与 AI 生图之间的差异，帮助用户辨别图片是否由 AI 生成，维护数字内容生态的真实、可信。

**AI 生成文本检测系统**，通过对海量 AI 生成文本和人类写作内容的学习，通过分析文本的特征和模式，可以较为准确地判断文本是否为 AI 生成，有助于防止学术抄袭、识别假新闻、保障证据可靠性等。


# Refer

* [Awesome LLM Apps](https://github.com/Shubhamsaboo/awesome-llm-apps)

