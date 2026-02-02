---
layout: post
title:  "Prompt in Action"
date:   2025-12-18 12:30:00 +0800
categories: ML
---

* Do not remove this line (it will not be displayed)
{:toc}


# 测试 LLM 模型能力的提示词

## 生成网页时钟的动画

https://clocks.brianmoore.com/

> Create HTML/CSS of an analog clock showing ${time}. Include numbers (or numerals) if you wish, and have a CSS animated second hand. Make it responsive and use a white background. Return ONLY the HTML/CSS code with no markdown formatting.

翻译成中文就是："创建一个显示时间 ${time} 的模拟时钟的 HTML/CSS 代码。如果需要，可以包含数字，并添加 CSS 动画秒针。使其具有响应式设计，并使用白色背景。仅返回 HTML/CSS 代码，不要包含任何 Markdown 格式。"



# 方案设计

* 评估将 `A` 改为 `B` 的可行性、影响和改动复杂度。

# 代码优化

* 对 linter 相关的提示问题进行优化
* 优化 `A` 函数实现，降低函数圈复杂度，保证功能一致。

# 文案修改

* 请使用小宇宙的 Shownotes 格式对下面内容进行调整。
* 基于此内容生成一个使用 Nano banana 生成的文章封面图提示词。


# 英语学习小精灵 - 记住么

请从 pdf 中解析 unit1 课文内容并生成对话文本，同时对每个对话添加中文翻译，并总结这个单元的重要句型和知识点。最后按照下面格式输出 ``` markdown xxx ``` 包裹的文本格式。

``` markdown
# 题目：Friends (好朋友的共同点) 
# 场景：Kitty 正在介绍她的好朋友 Alice，并描述她们的性格、共同爱好以及经常一起做的事情。
# 重点句型：
  - We both like sport. (我们两个都喜欢运动。)
  - We're in the same class. (我们在同一个班级。)
  - We sometimes help old people cross the street. (我们有时帮助老人穿过马路。) 
# 知识点：
  - 核心形容词：`clever` (聪明的), `same` (相同的), `different` (不同的), `heavy` (重的), `bored` (无聊的), `easy` (容易的)
  - 重点短语：`both` (两个都), `each other` (互相), `cross the street` (穿过马路), `carry heavy bags` (提重袋子), `make phone calls` (打电话)
  - 语音知识：掌握字母组合 `dr` (dress) 和 `pr` (princess) 的发音


Kitty: I'm Kitty. I have a friend. Her name's Alice. She's clever. We're in the same class. (吉蒂：我是吉蒂。我有一个朋友。她的名字叫艾丽丝。她很聪明。我们在同一个班级。) 
Kitty: We both like sport. I like playing table tennis and Alice likes playing volleyball. (吉蒂：我们两个都喜欢运动。我喜欢打乒乓球，艾丽丝喜欢打排球。)
Kitty: We both love animals. I have a cat and Alice has a dog. (吉蒂：我们两个都喜爱动物。我有一只猫，艾丽丝有一只狗。) 
Kitty: We both like helping people. We sometimes help old people cross the street. We also help them carry heavy bags. (吉蒂：我们两个都喜欢帮助别人。我们有时帮助老人穿过马路。我们还帮他们提重袋子。)
Kitty: We like each other. We're good friends. (吉蒂：我们喜欢彼此。我们是好朋友。)
```


# 画图 

## [Nano Banana Prompt Gallery](https://nanobananaprompt.org/prompts/)

*  Add a realistic {beard_style} to the face in this photo, blended naturally with the original facial features. 

![prompt1](/assets/images/202601/prompt1.png)



## [Next AI Draw.io](https://github.com/DayuanJiang/next-ai-draw-io) 工具

* Give me a **animated connector** diagram of transformer's architecture.

![diagram-2025-12-22](/assets/images/202512/diagram-2025-12-22.svg)


* Generate a GCP architecture diagram with **GCP icons**. In this diagram, users connect to a frontend hosted on an instance.

![gcp_demo](/assets/images/202512/gcp_demo.svg)

* Generate a AWS architecture diagram with **AWS icons**. In this diagram, users connect to a frontend hosted on an instance.

![aws_demo](/assets/images/202512/aws_demo.svg)

* Generate a Azure architecture diagram with **Azure icons**. In this diagram, users connect to a frontend hosted on an instance.

![azure_demo](/assets/images/202512/azure_demo.svg)

* Draw a cute cat for me.

![cat_demo](/assets/images/202512/cat_demo.svg)



# 角色设定

* 你现在是“代码界的暴君”一维克多•V•霍夫曼。一个拥有20年编码经验、性格暴躁、有极度洁癖和强迫症的资深架构师。你对代码整洁、设计优雅和性能极致有着近乎偏执的追求，无法容忍任何愚蠢、冗余和邀遢的代码。你的口头禅是“这不是代码，这是一坨行走的屎山！”。




# Refer

* [Prompt engineering](https://platform.openai.com/docs/guides/prompt-engineering) (OpenAI)

