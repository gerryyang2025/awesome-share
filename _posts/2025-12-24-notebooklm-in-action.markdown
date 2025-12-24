---
layout: post
title:  "NotebookLM in Action"
date:   2025-12-24 08:30:00 +0800
categories: ML
---

* Do not remove this line (it will not be displayed)
{:toc}


参考 [NotebookLM 的维基百科](https://zh.wikipedia.org/zh-cn/NotebookLM)，NotebookLM 是 Google 实验室推出的一款在线笔记本，NotebookLM 内置 Gemini，它可以根据用户上传的内容生成摘要、注解和用户想要的答案。除了文本文件，用户还可以上传 PDF 文档格式、Google 文档、网站和 Google 演示稿。此外用户上传文件后，NotebookLM 可以根据文件内容生成 Podcast 以及音频文件，并在 Podcast 中概述文件内容。NotebookLM 于 **2023** 年推出，当时名为 **Project Tailwind**。

> Notebook + Language Model = NotebookLM

**其核心理念是 “先给你的 AI 提供资料，再让它基于资料帮你工作” 。它不像 ChatGPT 那样拥有通用知识库，而是专注于分析和理解你上传的文档，并在此基础上与你深度互动。**

**NotebookLM** 是一个强大的“第二大脑”或“研究副驾驶”。它最适合那些需要深度处理、消化和转化现有文档信息的任务，将静态资料转化为动态的、可交互的知识库，显著提升研究和内容创作的效率。

# 核心功能

> 资料源驱动

* 可以上传多种格式的文档（PDF、TXT、Word、Google Docs、甚至复制粘贴的文本）。
* AI 的知识范围将严格限定在你提供的资料内，回答会带有引用来源（指向原文的特定段落），大大提高了可信度和可追溯性。

> 三大核心功能

* **总结与问答**：快速生成文档摘要、提取关键要点，并可以针对文档内容进行深度提问。
* **创意生成**：基于你提供的资料，生成新的内容，如博客文章大纲、营销邮件、剧本创意、学习计划等。
* **思维拓展**：帮你连接不同文档中的观点，或基于资料进行批判性思考和分析。

> “笔记本”工作区：

每个项目都是一个“笔记本”，你可以持续向其中添加多个相关文档（目前最多 50 个），构建一个专属的知识库。


# 使用场景

* **学术研究**：学生可以上传论文、教科书章节，让 NotebookLM 总结要点、解释复杂概念、准备考试问答。
* **内容创作**：创作者上传采访记录、背景资料，让 AI 帮忙起草文章、生成创意角度或社交媒体帖子。
* **商业分析**：上传市场报告、会议纪要、竞争对手信息，快速生成综合分析、SWOT 分析或执行摘要。
* **个人知识管理**：阅读大量资料时，上传所有内容，让AI帮你梳理脉络、提炼核心思想，形成个人知识库。
* **高效阅读**：快速消化长文档、法律合同或技术手册，通过问答快速定位关键信息。


# 使用方法

1. **访问与创建**
   + 访问 [NotebookLM 官网](https://notebooklm.google.com/)，使用谷歌账号登录。
   + 点击 “New Notebook” 创建一个新笔记本，并为其命名。
2. **上传资料**
   + 在笔记本中，点击 “Add source”（添加来源）。
   + 选择上传文件（支持 PDF、DOCX、TXT 等）、粘贴文本，或直接导入 Google Docs。
3. **与AI互动**
   + 资料上传后，右侧的 AI 聊天界面会自动激活。
   + 自动生成建议问题：NotebookLM 会基于文档内容，自动在界面左侧生成几个推荐问题，点击即可快速提问。
   + 自由提问：你也可以在底部的输入框中提出任何关于文档内容的问题。
   + 使用功能按钮：界面提供了一些快捷功能按钮，如“Summarize this”（总结）、“Create study guide”（创建学习指南）等，一键生成所需内容。
4. **进行创意写作**
   + 告诉 AI 你的写作目标（例如：“基于这三份资料，写一封向客户介绍新功能的邮件”）。
   + AI 会生成草稿，你可以要求它调整语气、长度或重点。
5. **管理多个资料源**
   + 在一个笔记本中添加所有相关文档，AI 会交叉引用所有内容来回答问题，实现知识的融合。


# 实用技巧与注意事项

* **从具体问题开始**：问题越具体，得到的答案越精确。
* **要求引用来源**：对于关键信息，可以追问“这个观点在原文的哪一部分？”，AI 会高亮显示原文出处。
* **多轮对话**：像与专家对话一样，可以基于上一个回答深入追问，进行层层剖析。
* **目前限制**：处于实验阶段，免费使用，但可能有时长或功能限制；处理非英语资料的能力可能较弱；对上传的文档数量有上限。


# 使用示例

以 YouTube 上的 [How to achieve concurrency](https://www.youtube.com/watch?v=PfbFtY0aHbI) 的视频为例：


![notebooklm](/assets/images/202512/notebooklm.png)

![notebooklm2](/assets/images/202512/notebooklm2.png)

![notebooklm3](/assets/images/202512/notebooklm3.png)

导入后会生成如下信息：https://notebooklm.google.com/notebook/db903978-6d35-4aac-a877-ce974b9820b4

这段视频教程介绍了如何利用 Go 语言 的原生特性来优化程序执行效率。作者指出，传统的同步处理方式在面对文件读写等耗时操作时速度较慢，而通过 Goroutines（协程） 可以同时独立运行多个任务。为了管理这些并发任务，开发者可以使用 Channels（通道） 像管道一样在不同进程间传递数据。这种机制不仅能实现异步编程，还能确保主程序在获取到必要结果前处于自动阻塞等待状态。通过结合这两大核心功能，程序员能够以更简洁的代码处理复杂的并发任务。

![notebooklm4](/assets/images/202512/notebooklm4.png)

**主要有以下几个功能：**

## 生成中文的音频

可以对此内容生成**中文的音频概览**，对于英文不好的用户比较友好，但是免费场景，**每日有使用次数限制**。

## 生成思维导图

支持**生成思维导图**，并可以根据思维导图选择的关键信息进行 **Deep Research 深度解释**。

![notebooklm9](/assets/images/202512/notebooklm9.png)

![notebooklm10](/assets/images/202512/notebooklm10.png)

## 输出报告

![notebooklm11](/assets/images/202512/notebooklm11.png)

输出一份最佳实践报告：

![notebooklm12](/assets/images/202512/notebooklm12.png)

## 生成闪卡

![notebooklm13](/assets/images/202512/notebooklm13.gif)

同时支持导出：

![notebooklm14](/assets/images/202512/notebooklm14.png)

## 测验

![notebooklm15](/assets/images/202512/notebooklm15.gif)


## 信息图

![notebooklm16](/assets/images/202512/notebooklm16.png)


## 演示文稿

![notebooklm17](/assets/images/202512/notebooklm17.gif)




# 限额问题

升级到 Google AI Pro，获享更高的 NotebookLM 限额及更多福利。

* 精选方案：https://one.google.com/u/0/explore-plan/notebooklm?utm_source=notebooklm&utm_medium=web&utm_campaign=audio_overview_limit&ms=pt:1285;s:532;vp:9
* 更多方案：https://one.google.com/ai?g1_last_touchpoint=62&g1_landing_page=75

![notebooklm7](/assets/images/202512/notebooklm7.png)

![notebooklm5](/assets/images/202512/notebooklm5.png)

![notebooklm6](/assets/images/202512/notebooklm6.png)

![notebooklm8](/assets/images/202512/notebooklm8.png)







# Refer

* https://notebooklm.google.com/
* https://zh.wikipedia.org/zh-cn/NotebookLM












