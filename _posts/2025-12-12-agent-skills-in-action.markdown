---
layout: post
title:  "Agent Skills in Action"
date:   2025-12-12 12:30:00 +0800
categories: ML
tags:
  - Agent Skills
  - Machine Learning

---

* Do not remove this line (it will not be displayed)
{:toc}


# 背景与问题：强大的通用代理缺乏专业知识

> 今天的 AI Agent 就像一个“智商 300 的数学天才”，它非常聪明，但在面对复杂的税务、法律或特定企业流程时，往往因为缺乏专业知识而显得力不从心。Anthropic 官方技术分享 [Don't Build Agents, Build Skills Instead – Barry Zhang & Mahesh Murag, Anthropic](https://www.youtube.com/watch?v=CEvIs9y1uog) 提出了一个颠覆性的观点：我们应该停止重复造轮子去构建各种垂直领域的 Agent，转而开始构建“Skill”。什么是 Skill？为什么 Anthropic 认为“文件夹”才是封装 AI 能力的最佳方式？在这场深度分享中，讲述了关于 Agent 架构的最新演进：**如何利用代码作为通用接口，如何通过 MCP 与 Skill 的组合让 AI 瞬间变身行业专家，以及如何让 AI 在与你共事的第 30 天比第 1 天好用得多**。这不仅是一场技术发布，更是一份关于未来**人机协作模式的行动指南**。


* **现状**：以 Claude Code 为代表，现代大模型已经能够构建通用代理，通过代码执行和文件系统等完整计算环境处理复杂任务。

* **痛点**：虽然通用能力强大，但当任务涉及特定领域（如金融分析、生物信息学、内部公司流程）时，它们**缺乏深入、可组合、易扩展的专业知识**。为每个用例从头定制专属代理，效率低下且难以维护。


# 解决方案：Agent Skills（智能体技能包）

**Skills** are **folders of instructions, scripts, and resources** that Claude **loads dynamically to improve performance on specialized tasks**. Skills teach Claude how to complete specific tasks in a repeatable way, whether that's creating documents with your company's brand guidelines, analyzing data using your organization's specific workflows, or automating personal tasks.

For more information, check out:

* [What are skills?](https://support.claude.com/en/articles/12512176-what-are-skills)
* [Using skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude)
* [How to create custom skills](https://support.claude.com/en/articles/12512198-creating-custom-skills)
* [Equipping agents for the real world with Agent Skills](https://anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)



这是为解决上述问题提出的创新概念。**可以将其理解为为 AI 代理准备的、可插拔的“专业工具包”或“知识模块”**。

* **是什么：一个有组织的文件夹**，里面包含：
  + **操作指南**：关于如何完成特定任务的详细指令。
  + **脚本与工具**：可执行的代码、函数或 API 调用。
  + **资源文件**：相关数据、模板、配置等。


* **核心功能**：代理可以动态发现和加载这些技能包，从而在需要时立刻获得相关领域的能力，**从“通才”变身为“专才”**。


> **Agent Skills 代表了一种范式转变：从为每个特定任务“建造专属代理”，转向为强大的通用代理“装备可组合的技能包”**。它旨在解决 AI 代理专业化过程中的**可扩展性、可移植性和知识复用问题**，通过将人类专家的知识封装成模块化资源，让 AI 代理能更灵活、高效地适应各种复杂领域任务。这标志着 AI 代理正朝着更模块化、生态化的方向发展。





# 核心比喻：如同“新员工入职指南”


这是理解其价值的关键比喻：

* **传统方式（定制代理）**：如同为每个新岗位招聘一个完全定制的、只能做一件事的机器人。成本高，不灵活。

* **Skills 方式（赋能通用代理）**：如同招聘一个聪明的新人（通用代理），然后给他一本精心编写的“**岗位入职指南**”（Skill）。这个指南里包含了公司的具体流程、工具使用方法和专业知识。新人通过阅读指南，就能快速胜任特定工作。

* **优势**：这种方式实现了**知识（Skills）与主体（Agent）的解耦**。**知识可以被封装、复用、组合和共享**，极大提升了效率和灵活性。


#  运作方式与意义

* **对代理（如 Claude）**：从“万能但不够专精”转变为 “一个可随时装备专业技能的基础平台” 。

* **对开发者/用户**：无需从头训练或复杂编程，只需将自己的流程性知识打包成 Skill，即可赋予代理专业能力。这降低了专业化 AI 的应用门槛。

* **生态价值**：Skills 可以被分享和交易，促进一个围绕 AI 代理能力的生态系统形成。






# Claude Agent Skills

**Claude** can now use `Skills` to improve **how it performs specific tasks**. `Skills` are **folders** that include `instructions`, `scripts`, and `resources` that **Claude** can load when needed.

**Claude will only access a skill when it's relevant to the task at hand**. When used, skills make Claude better at specialized tasks like working with `Excel` or following your organization's brand `guidelines`.

参考：[Agent Skills: Specialized capabilities you can customize](https://www.youtube.com/watch?v=IoqpBKrNaZI)

> Claude is powerful, but real work requires procedural knowledge and organizational context. Introducing Agent Skills, a new way to build specialized agents using files and folders.

![agent_skills2](/assets/images/202512/agent_skills2.png)





# How Skills work

While working on tasks, Claude scans available `skills` to find relevant matches. **When one matches, it loads only the minimal information and files needed—keeping Claude fast while accessing specialized expertise**.

`Skills` are:

* **Composable**: Skills stack together. Claude automatically identifies which skills are needed and coordinates their use.
* **Portable**: Skills use the same format everywhere. Build once, use across Claude apps, Claude Code, and API.
* **Efficient**: Only loads what's needed, when it's needed.
* **Powerful**: **Skills can include executable code for tasks** where traditional programming is more reliable than token generation.

Think of `Skills` as custom onboarding materials that let you package expertise, making Claude a specialist on what matters most to you. **For a technical deep-dive on the Agent Skills design pattern, architecture, and development best practices, read our engineering blog** - [Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills).


# Skills work with every Claude product

## Claude apps

`Skills` are available to Pro, Max, Team and Enterprise users. We provide skills for common tasks like document creation, examples you can customize, and the ability to create your own custom skills.

![agent_skills](/assets/images/202512/agent_skills.png)

Claude automatically invokes relevant skills based on your task—no manual selection needed. You'll even see `skills` in Claude's chain of thought as it works.

**Creating `skills` is simple**. The "skill-creator" skill provides interactive guidance: **Claude asks about your workflow, generates the folder structure, formats the `SKILL.md` file, and bundles the resources you need. No manual file editing required**.

参考：[Creating custom Skills with Claude](https://www.youtube.com/watch?v=kS1MJFZWMq4)


## Claude Code

`Skills` extend Claude Code with your team's expertise and workflows. Install skills via plugins from the **anthropics/skills** marketplace. Claude loads them automatically when relevant. Share skills through version control with your team. You can also manually install skills by adding them to `~/.claude/skills`. The Claude Agent SDK provides the same Agent Skills support for building custom agents.


# Getting started

* Claude Code: [Documentation](https://docs.claude.com/en/docs/claude-code/skills)
* Example Skills to customize: [GitHub repository](https://github.com/anthropics/skills)

## Skill Sets

* [./skills](https://github.com/anthropics/skills/blob/main/skills): Skill examples for Creative & Design, Development & Technical, Enterprise & Communication, and Document Skills
* [./spec](https://github.com/anthropics/skills/blob/main/spec): The Agent Skills specification
* [./template](https://github.com/anthropics/skills/blob/main/template): Skill template

## Creating a Basic Skill

**Skills** are simple to create - just a folder with a `SKILL.md` file containing YAML frontmatter and instructions. You can use the **template-skill** in this repository as a starting point:

``` yaml
---
name: my-skill-name
description: A clear description of what this skill does and when to use it
---

# My Skill Name

[Add your instructions here that Claude will follow when this skill is active]

## Examples
- Example usage 1
- Example usage 2

## Guidelines
- Guideline 1
- Guideline 2
```

The **frontmatter** requires only two fields:

> frontmatter 指的是书籍或正式文档中，位于正文 (main matter) 之前的部分。它通常包含与书籍相关但并非正文内容的信息。

* `name` - A unique identifier for your skill (lowercase, hyphens (连字符) for spaces)
* `description` - A complete description of what the skill does and when to use it

The markdown content below contains the instructions, examples, and guidelines that Claude will follow. For more details, see [How to create custom skills](https://support.claude.com/en/articles/12512198-creating-custom-skills).



# What's next

We're working toward simplified skill creation workflows and enterprise-wide deployment capabilities, making it easier for organizations to distribute skills across teams.

**Keep in mind, this feature gives Claude access to execute code**. While powerful, it means being mindful about which skills you use—stick to trusted sources to keep your data safe. [Learn more](https://support.claude.com/en/articles/12512180-using-skills-in-claude#h_2746475e70).




# The anatomy of a skill

参考：[Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

To see Skills in action, let’s walk through a real example: one of the skills that powers [Claude’s recently launched document editing abilities](https://www.anthropic.com/news/create-files). Claude already knows a lot about understanding PDFs, but is limited in its ability to manipulate them directly (e.g. to fill out a form). This [PDF skill](https://github.com/anthropics/skills/tree/main/document-skills/pdf) lets us give Claude these new abilities.

At its simplest, **a skill is a directory** that contains a `SKILL.md` file. This file must start with YAML frontmatter that **contains some required metadata**: `name` and `description`. At startup, the agent pre-loads the `name` and `description` of every installed skill into its system prompt.

This **metadata** is the **first level** of progressive disclosure: it provides just enough information for Claude to know when each skill should be used without loading all of it into context. The actual body of this file is the **second level** of detail. If Claude thinks the skill is relevant to the current task, it will load the skill by reading its full `SKILL.md` into context.

![agent_skills3](/assets/images/202512/agent_skills3.png)

## 案例背景：赋予 Claude PDF 编辑的“手”

* 通用能力的局限：Claude 作为通用模型，擅长理解和分析 PDF 内容，但天生缺乏直接操作和编辑 PDF 文件的能力（例如填写表格、合并页面）。

* 技能的赋能：**“PDF 技能包”就是一个 “操作手册+工具集”** ，它赋予了 Claude 这双原本不具备的“手”，使其能完成从“读懂”到“修改”的完整工作流。


## 技能的核心结构：一个目录与一个文件

* **技能**在物理上表现为一个文件夹。

* 其最关键的文件是 `SKILL.md`，它包含了该技能的全部定义。

* 这个文件采用 **“元数据+详细内容” 的分层结构**，这是实现高效管理的关键。


## 核心机制：渐进式披露

这是整个设计中最精妙的部分，旨在**平衡“能力丰富性”与“运行效率/上下文限制”**。

![agent_skills4](/assets/images/202512/agent_skills4.png)


## 运作流程图示

1. **启动**：Claude 加载所有技能的 **名称** 和 **描述**（**元数据**）。
2. **接收请求**：用户提出任务，例如 “帮我填写这份 PDF 纳税表格。”
3. **技能路由**：Claude 扫描内存中的技能元数据列表，发现“PDF 编辑技能”的描述与此任务匹配。
4. **动态加载**：Claude 自动将“PDF 编辑技能”文件夹中完整的 `SKILL.md` 内容读入当前工作上下文。
5. **执行任务**：Claude 现已成为“PDF 专家”，它根据刚加载的详细指南，调用其中描述的脚本或方法，逐步完成表格填写操作。

## 总结与意义

这种 **“渐进式披露”** 的架构设计具有重大优势：

![agent_skills5](/assets/images/202512/agent_skills5.png)


As skills grow in complexity, they may contain too much context to fit into a single `SKILL.md`, or context that’s relevant only in specific scenarios. In these cases, skills can bundle additional files within the skill directory and reference them by name from `SKILL.md`. These additional linked files are the **third level** (and beyond) of detail, which Claude can choose to navigate and discover only as needed.

In the PDF skill shown below, the `SKILL.md` refers to two additional files (`reference.md` and `forms.md`) that the skill author chooses to bundle alongside the core `SKILL.md`. By moving the form-filling instructions to a separate file (`forms.md`), the skill author is able to keep the core of the skill lean, trusting that Claude will read `forms.md` only when filling out a form.

![agent_skills6](/assets/images/202512/agent_skills6.png)

当一项技能变得非常复杂时，把所有信息都堆在 `SKILL.md` 主文件里会导致：

1. **文件臃肿**：AI（如 Claude）每次调用技能时都需要处理大量上下文，效率低下。
2. **信息混杂**：核心指令和只在特定场景下才需要的细节混在一起，干扰主要任务。

**解决方案是创建一个技能文件夹，里面包含一个核心文件和多个专项文件**。

三级信息层级结构：

![agent_skills9](/assets/images/202512/agent_skills9.png)


> **总结来说，这是一种借鉴了软件工程中“模块化”和“关注点分离”思想的设计模式。它通过创建一种智能的、可导航的文档结构，让 AI 能够高效地管理和运用复杂的技能知识，只在需要时才深入细节。**




**Progressive disclosure is the core design principle that makes Agent Skills flexible and scalable**. Like a well-organized manual that starts with a table of contents, then specific chapters, and finally a detailed appendix, skills let Claude load information only as needed:

![agent_skills7](/assets/images/202512/agent_skills7.png)

Agents with a filesystem and code execution tools don’t need to read the entirety of a skill into their context window when working on a particular task. This means that the amount of context that can be bundled into a skill is effectively unbounded.


## Skills and the context window

The following diagram shows how the context window changes when a skill is triggered by a user’s message.


![agent_skills8](/assets/images/202512/agent_skills8.png)

The sequence of operations shown:

1. To start, the context window has the core system prompt and the metadata for each of the installed skills, along with the user’s initial message;
2. Claude triggers the PDF skill by invoking a Bash tool to read the contents of `pdf/SKILL.md`;
3. Claude chooses to read the `forms.md` file bundled with the skill;
4. Finally, Claude proceeds with the user’s task now that it has loaded relevant instructions from the PDF skill.


## Skills and code execution

Skills can also include code for Claude to execute as tools at its discretion.

Large language models excel at many tasks, but certain operations are better suited for traditional code execution. For example, sorting a list via token generation is far more expensive than simply running a sorting algorithm. Beyond efficiency concerns, many applications require the deterministic reliability that only code can provide.

In our example, the PDF skill includes a pre-written Python script that reads a PDF and extracts all form fields. Claude can run this script without loading either the script or the PDF into context. And because code is deterministic, this workflow is consistent and repeatable.

![agent_skills10](/assets/images/202512/agent_skills10.png)


**核心理念：让 AI “想”和“做”各司其职**

大型语言模型（LLM）如 Claude 的核心优势在于**理解、推理和生成语言**。但对于某些**逻辑计算、数据处理或确定性操作，传统代码是更优的工具**。

将代码作为“工具”提供给 AI，意味着：

* **AI 是“大脑”和“决策者”**：它负责理解用户意图、规划任务流程、判断何时该调用哪个工具。

* **代码是“瑞士军刀”或“精密仪器”**：当遇到它擅长的任务时，AI就把它拿出来使用，并获得一个确定、可靠的结果。


**为什么要让 AI 使用代码工具？**

![agent_skills11](/assets/images/202512/agent_skills11.png)


**这种设计的巨大优势**


![agent_skills12](/assets/images/202512/agent_skills12.png)



# Developing and evaluating skills

Here are some helpful guidelines for getting started with authoring and testing skills:

![agent_skills13](/assets/images/202512/agent_skills13.png)

技能是为 AI 助手（Claude）扩展能力的工具包，通常包含：

* **指令**：告诉 AI 如何思考、何时使用该技能。
* **代码**：AI 可以执行或参考的脚本。
* **文档**：提供背景知识和上下文。

> 开发和评估技能的四大核心原则

![agent_skills14](/assets/images/202512/agent_skills14.png)




# Security considerations when using Skills

Skills provide Claude with new capabilities through instructions and code. While this makes them powerful, it also means that malicious skills may introduce vulnerabilities in the environment where they’re used or direct Claude to exfiltrate data and take unintended actions.

We recommend installing skills only from trusted sources. When installing a skill from a less-trusted source, thoroughly audit it before use. Start by reading the contents of the files bundled in the skill to understand what it does, paying particular attention to code dependencies and bundled resources like images or scripts. Similarly, pay attention to instructions or code within the skill that instruct Claude to connect to potentially untrusted external network sources.


技能赋予 AI 强大能力的同时，也带来了潜在风险。指南给出了明确警告：

![agent_skills15](/assets/images/202512/agent_skills15.png)




# The future of Skills

Agent Skills are [supported today](https://www.anthropic.com/news/skills) across [Claude.ai](https://claude.ai/), Claude Code, the Claude Agent SDK, and the Claude Developer Platform.

In the coming weeks, we’ll continue to add features that support the full lifecycle of creating, editing, discovering, sharing, and using Skills. We’re especially excited about the opportunity for Skills to help organizations and individuals share their context and workflows with Claude. We’ll also explore how Skills can complement [Model Context Protocol](https://modelcontextprotocol.io/) (`MCP`) servers by teaching agents more complex workflows that involve external tools and software.

Looking further ahead, we hope to enable agents to create, edit, and evaluate Skills on their own, letting them codify their own patterns of behavior into reusable capabilities.

Skills are a simple concept with a correspondingly simple format. This simplicity makes it easier for organizations, developers, and end users to build customized agents and give them new capabilities.

We’re excited to see what people build with Skills. Get started today by checking out our Skills [docs](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview) and [cookbook](https://github.com/anthropics/claude-cookbooks/tree/main/skills).

这部分是关于 AI 技能（Skills）未来发展的路线图与愿景，清晰地展示了当前支持、近期计划、长期目标及核心理念。

> 当前状态：已全面支持

技能现已是一个成熟、可用的功能，覆盖了 Claude 的各大平台：

* Claude.ai：普通用户交互界面。
* Claude Code：面向编程的特定环境。
* Claude Agent SDK：供开发者构建智能体（Agent）的工具包。
* Claude 开发者平台：更广泛的开发与集成平台。

这意味着你现在就可以在这些平台上使用和创建技能。

> 近期计划（未来几周）：完善生态与能力

![agent_skills16](/assets/images/202512/agent_skills16.png)


> 长期愿景：自主进化的智能体

这是一个非常前瞻性的目标：**希望未来能让智能体（Agent）自主地创建、编辑和评估技能**。

**意义**：这意味着 AI 能将自己在实践中摸索出的成功行为模式，主动“固化”成可重复使用的技能。这标志着 AI 从“工具使用者”向“自我优化者”的演进，能显著加速其能力增长和专业化。

> 核心理念：简单性

文章再次强调了技能的**设计哲学：简洁**。

* **格式简单**：易于理解和上手。
* **价值**：正是这种简洁性，降低了使用门槛，使得企业、开发者和最终用户都能更方便地定制专属的智能体，赋予它们新的能力。






# Refer

* [Introducing Agent Skills](https://claude.com/blog/skills)
* [Equipping agents for the real world with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)
* [Using Skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude)
* https://github.com/anthropics/skills
* [Don't Build Agents, Build Skills Instead – Barry Zhang & Mahesh Murag, Anthropic](https://www.youtube.com/watch?v=CEvIs9y1uog) (Anthropic 官方技术分享)，[小宇宙翻译版本](https://www.xiaoyuzhoufm.com/episode/6943bf87c4f10bdeea0d738b?s=eyJ1IjogIjY1YTY2NGY2ZWRjZTY3MTA0YTM5YjY2NCJ9)
* [How to create custom Skills](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)











