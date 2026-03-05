---
layout: post
title:  "OpenClaw - Personal AI Assistant"
date:   2026-01-29 12:00:00 +0800
categories: ML
---

* Do not remove this line (it will not be displayed)
{:toc}

# 快速开始

官方文档：[OpenClaw 快速开始指南](https://docs.openclaw.ai/start/getting-started)


# 使用示例

## 在 tui 终端对话

运行 `openclaw tui` 命令后进行对话。

![openclaw0](/assets/images/202601/openclaw0.png)

## 通过 QQ 客户端对话

创建 QQ Channel 并绑定到 QQbot，然后在 QQ 客户端与 QQbot 进行对话。

![openclaw1](/assets/images/202601/openclaw1.png)

注册的 QQbot 信息：

![openclaw2](/assets/images/202601/openclaw2.png)

QQbot 具备的 Skills 能力：

![openclaw3](/assets/images/202601/openclaw3.png)


## 使用示例1 - 配置 HTTP 服务

通过 openclaw 配置一个常驻的 HTTP 服务（可以指定数据访问的目录和端口），可方便通过 Web 浏览器查看和下载 openclaw 在云服务器上生成的文件。

``` bash
# 数据访问目录
/root/.openclaw/workspace/data

# 服务访问端口
8080
```

在 openclaw 创建完 HTTP 服务后，再在腾讯云控制台通过 AI 助手完成网络访问策略的配置：

![openclaw36](/assets/images/202601/openclaw36.png)

通过浏览器测试访问成功：

![openclaw37](/assets/images/202601/openclaw37.png)

![openclaw38](/assets/images/202601/openclaw38.png)

![openclaw39](/assets/images/202601/openclaw39.png)


## 使用示例1 - 实现小游戏

![openclaw4](/assets/images/202601/openclaw4.png)

## 使用示例2 - 生成图片

![openclaw34](/assets/images/202601/openclaw34.png)

![openclaw35](/assets/images/202601/openclaw35.png)


## 使用示例3 - 生成音乐

![openclaw43](/assets/images/202601/openclaw43.png)

![openclaw44](/assets/images/202601/openclaw44.png)


## 使用示例4 - 生成视频




# Skills 最佳实践

> **注意**：
>
> 1. skills 中不能记录敏感信息防止泄漏，例如：LLM API Key 的信息，应该将 API Key 的信息配置在服务器独立的配置文件中，例如：`/root/.openclaw/workspace/.config/api-keys.json`，并只有服务器用户有查看权限。可以通过增加一个 security skill 来保证所需的安全约束。
>
> 2. openclaw 通过 `/root/.openclaw/workspace/TOOLS.md` 记录可以使用的 skills 技能，增删 skills 目录下的技能描述后，也需要同步更新 `TOOLS.md` 文件。

通过 [ClawHub](https://clawhub.ai/) 安装所需的 skills。

以安装 `self-improving-agent` 为例，可以使用以下的方法安装：

1. Install any skill folder in one shot: `npx clawhub@latest install your_skill_name`
2. 或者在 ClawHub 页面直接下载，https://wry-manatee-359.convex.site/api/v1/download?slug=self-improving-agent。
3. 或者执行 `clawdhub install self-improving-agent` 命令。
4. 也可以直接告诉 openclaw 让它来安装，例如：通过 https://clawhub.ai/ 安装 self-improving-agent 这个 skill。

![openclaw41](/assets/images/202601/openclaw41.png)


## [Find Skills](https://clawhub.ai/JimLiuxinghai/find-skills) 发现其他好用的 Skill

Helps users discover and install agent skills when they ask questions like "how do I do X", "find a skill for X", "is there a skill that can...", or express interest in extending capabilities. This skill should be used when the user is looking for functionality that might exist as an installable skill.

**使用场景：**

你想做某件事，但不知道有没有对应的 Skill。例如：想做小红书图片，可以直接让 openclaw 帮你找个适合做小红书图片的技能。然后 openclaw 会根据搜索结果选择一个合适的技能。

**实现原理：**

1. 接收你的需求描述
2. 向 ClawHub 发起搜索请求
3. 对比不同 Skills 的匹配速度
4. 推荐合适的选择



##  [ClawSec](https://clawhub.ai/chrisochrisochriso-cmyk/clawsec) 安全防护

Manage and operate ClawSec Monitor v3.0, a MITM HTTP/HTTPS proxy that logs AI agent traffic, detects exfiltration and injection threats in real time.

## [Self-Improving Agent](https://clawhub.ai/pskoett/self-improving-agent) AI 自我进化

Captures learnings, errors, and corrections to enable continuous improvement. Use when: (1) A command or operation fails unexpectedly, (2) User corrects Clau...

**核心思想：**

让 Agent 记住自己的错误，学到的东西，用户的纠正，并在后续会话中自动参考。

**实现原理：**

1. 自动监控。监听命令执行结果，用户反馈
2. 结构化记录。将学习内容记录在 `.learnings/` 目录下的日志文件中。每条学习记录包括：ID，时间戳，优先级，摘要，复现步骤，建议修复方案
3. 智能检索。遇到类似问题时，自动查询历史记录



## [Tavily Web Search](https://clawhub.ai/arun-8687/tavily-search) 让 AI 拥有实时信息获取能力

AI-optimized web search via Tavily API. Returns concise, relevant results for AI agents.

## [Multi Search Engine](https://clawhub.ai/gpyAngyoujun/multi-search-engine) 适合中文信息搜索

Multi search engine integration with 17 engines (8 CN + 9 Global). Supports advanced search operators, time filters, site search, privacy engines, and WolframAlpha knowledge queries. No API keys required.


## [GitHub](https://clawhub.ai/steipete/github) 代码仓库的自然语言管理

Interact with GitHub using the `gh` CLI. Use `gh issue`, `gh pr`, `gh run`, and `gh api` for issues, PRs, CI runs, and advanced queries.

**使用场景：**

GitHub Skill 通过集成 GitHub CLI 命令行工具（gh 命令行工具），让你可以用自然语言管理 GitHub 仓库。

例如：

1. 搜索开源项目：搜索 Python 爬虫相关的热门仓库。
2. 管理 Issue：查看某仓库的高优先级 Issue。
3. 代码审查：查看最新的 PR 有没有问题。
4. 自动化报告：生成本周项目进展报告。

**实现原理：**

1. 理解用户的自然语言指令
2. 转换为对应的 gh 命令
3. 执行并返回结果


## [Proactive Agent](https://clawhub.ai/halthelobster/proactive-agent) 从被动相应到主动服务

Transform AI agents from task-followers into proactive partners that anticipate needs and continuously improve. Now with WAL Protocol, Working Buffer, Autonomous Crons, and battle-tested patterns. Part of the Hal Stack 🦞

**使用场景：**

让 openclaw 主动跟踪一个项目的学习进度。例如，每周五自动汇总学习成果，并主动推荐下周的学习计划。这种从“被动执行”到“主动服务”的转变，让 AI 更像一个真正的助理。

**实现原理：**

1. 心跳机制。每15分钟自动唤醒
2. 任务监控。持续跟踪进行中的任务
3. 自我迭代。优化工作流程

## [Debug Methodology](https://clawhub.ai/abczsl520/debug-methodology) 问题调试

Systematic debugging and problem-solving methodology. Activate when encountering unexpected errors, service failures, regression bugs, deployment issues, or...





# Skills 数据备份和恢复 (重要)

openclaw 保存 Skills 的目录是 `~/.openclaw/workspace/skills/`，在保证 Skills 中不存在敏感信息泄漏的情况下，可以将 skills 使用 git 来维护，也可以方便其他场景复用。


![openclaw40](/assets/images/202601/openclaw40.png)

![openclaw42](/assets/images/202601/openclaw42.png)




# 背景介绍

> 命名变化：ClawBot -> MoltBot -> OpenClaw

> 可以拓展想象：你买了一台新电脑，里面有一个“幽灵实体”，你把键盘、鼠标和网络权限交给它，把它当成一个虚拟同事。你可以直接跟它说话，交代事情。凡是你能在电脑上做的事，这个 Agent 理论上都能替你完成。这就是它真正强大的地方。

个人 AI 助手 **Clawdbot** 席卷硅谷，国内外社交平台上全是关于它的讨论。不过，项目创始人 **Peter Steinberger** 在 X 平台上发文表示，他被 Anthropic 强制要求更改名称的成 **Moltbot**，这并非他本人的决定。这次改名源于商标问题，但在操作过程中不仅搞砸了 GitHub 的账号更名，连 X 平台的原账号名也被加密货币推广者抢注了。最终，他的新账号名定为 `@moltbot`。使用 **Clawdbot** 后，网友们纷纷给出了很高的评价。“**它是迄今为止最伟大的 AI 应用，相当于你 24 小时全天候专属 AI 员工**”。Creator Buddy 创始人兼 CEO Alex Finn 盛赞道，“**这就是他们 (Anthropic) 希望 Claude Cowork 呈现的样子**”。当前，ClawdBot 项目已经开源：https://github.com/clawdbot/clawdbot。

Alex 展示了给他的 Clawdbot 发信息，让它帮其预订下周六在一家餐厅的座位。当 OpenTable 预订失败时，Clawdbot 利用 ElevenLabs 的技术致电餐厅并完成了预订。

![moltbot21](/assets/images/202601/moltbot21.png)

但 Clawdbot 真正让技术圈兴奋的，并不只是“能干活” ，而是其协作方式极其激进：不会写代码的人，也能直接提 PR。**原因很简单：它几乎是 100% 用 AI 写出来的**，PR 在这里更像是“我遇到了这个问题”，而不是“我写了一段多漂亮的代码”。更有意思的是，这个看似“全开源”的项目，偏偏故意留了一点不开源。创始人 Peter Steinberger 保留了一个名为“soul”的文件只占项目的 0.00001%。他说得很直白：这既是他的"秘密资产"，也是一个刻意留下来的安全靶子。大家真的在试着 hack 它，他就等着看模型到底守不守得住。到目前为止，“soul”还没被偷出来。作为忠实粉丝，Alex 表示这是自 Claude Code 发布以来，自己第一次连续两天没有用它。但是他的 Clawdbot Henry 已经连续 48 小时不停地 Vibe Coding。“**我这辈子都没写过这么多代码。Vibe Coding 已死，Vibe Orchestration 已来。**”

现在，Alex 想要退掉 Mac Mini，换一台价值 1 万美元的 Mac Studio。“我的 Clawdbot Henry 将控制一台人工智能超级计算机。Henry 将使用 Opus 作为大脑，并使用多个本地模型作为员工集群。” **Clawbot 并不是传统意义上只能回答问题的聊天机器人，它本质上是一个持续运行、可以执行任务的个人 AI 智能体**。你可以把它安装在自己的设备上，如 Mac、Windows、Linux，**它可以长期在线，不停地接收指令、处理任务、记住你的偏好和历史对话，随着时间积累变得更懂你、更有“记忆”**。

总的来说，**Clawbot 最令人震撼的地方有三点**：

1. **它几乎可以完全控制你的电脑**。它没有传统意义上的“护栏”，不局限在某几个功能里，而是可以像一个真正坐在电脑前的人一样，操作你电脑上的一切。
2. **它拥有近乎无限的长期记忆**。Clawbot 内置了一套非常复杂的记忆系统。说过的话、做过的事，都会不断被记录下来。每次对话结束后，它都会自动总结聊过的内容，并把关键信息提取出来，存进长期记忆中。
3. **它完全通过聊天应用来交互**。你平时用哪些聊天工具，Clawbot 就能在哪儿跟你对话，这意味着，只要打开一个聊天软件，就可以通过一条消息把任务交给 Clawbot 去做。现在 Clawbot 支持 WhatsApp、Telegram、Slack、Discord、Google Chat、Signal、iMessage、Microsoft Teams、WebChat 等，还有 BlueBubbles、Matrix、Zalo 以及 Zalo Personal。

> 不过，如此放开的权限让其几乎没有护栏，这带来很大的安全隐患，现在 GitHub 上有 500 多个安全的问题，这也让部分网友望而却步。对此，很多使用过的用户几乎都表示，不建议一开始就把 Clawbot 装在主力电脑上。“在你还不熟悉它之前，把它放在一个独立环境里是最安全的选择。”

![moltbot22](/assets/images/202601/moltbot22.png)

不过大家没有想到，这个 AI 员工首先带火的竟然是 **Mac Mini**。很多人为了运行 Clawdbot 会专门买一台电脑，而大部分选择了 Mac Mini，原因是它便宜、兼容好、功率低、安静、占地小。谷歌 DeepMind 产品经理 Logan Kilpatrick 都忍不住订了台 Mac Mini。

![moltbot23](/assets/images/202601/moltbot23.png)

更有网友晒出自己一口气买了 40 台 Mac mini 来运行 Clawdbot。

![moltbot24](/assets/images/202601/moltbot24.png)

但也有网友称可以用一台免费的服务器运行着完全一样的程序，Alex 也称没必要花 600 美元买 Mac mini，有其他便宜得多的方式来运行 Clawbot。买 Mac mini 更多是个人偏好，而不是技术上的必要条件。你完全可以不买任何硬件，只需要一个 VPS。另外，云厂商们动作迅速，有网友发现腾讯云直接推出了 Clawbot 云服务。

随着项目的火爆，其背后的开发者 Peter Steinberger 也备受关注。Peter 在“Open Source Friday”上分享了他一手打造 Clawdbot 的经过，从创建、创始到维护，全由他独自完成。有意思的是，此前甚至有传言称，Peter 可能是一个 bot、Agent，甚至本身就是 AI。而 Peter 的出现也让项目成员和关注者们确认了他是个“真人”。Peter 一度已经退休了，后来又从退休状态里出来开始折腾 AI。从外表来看，Peter 年轻有活力，完全不像已到退休年龄、可领取养老金的人。

![moltbot25](/assets/images/202601/moltbot25.png)





# Quick Start

Fastest chat: open the Control UI (no channel setup needed). Run `moltbot dashboard (PS: 找不到 moltbot 命令可使用 clawdbot 替换，建议将 moltbot 设置为 clawdbot 命令的别名)` and chat in the browser, or open `http://127.0.0.1:18789/` on the gateway host. Docs: [Dashboard](https://docs.molt.bot/web/dashboard) and [Control UI](https://docs.molt.bot/web/control-ui).

Recommended path: use the **CLI onboarding wizard** (`moltbot onboard`). It sets up:

* model/auth (OAuth recommended)
* gateway settings
* channels (WhatsApp/Telegram/Discord/Mattermost (plugin)/…)
* pairing defaults (secure DMs)
* workspace bootstrap + skills
* optional background service

If you want the deeper reference pages, jump to: [Wizard](https://docs.molt.bot/start/wizard), [Setup](https://docs.molt.bot/start/setup), [Pairing](https://docs.molt.bot/start/pairing), [Security](https://docs.molt.bot/gateway/security).


![moltbot27](/assets/images/202601/moltbot27.png)

![moltbot28](/assets/images/202601/moltbot28.png)






# Moltbot (原 Clawdbot)


[Moltbot](https://github.com/moltbot/moltbot) is a personal AI assistant you run on your own devices. It answers you on the channels you already use (WhatsApp, Telegram, Slack, Discord, Google Chat, Signal, iMessage, Microsoft Teams, WebChat), plus extension channels like BlueBubbles, Matrix, Zalo, and Zalo Personal. It can speak and listen on macOS/iOS/Android, and can render a live Canvas you control. The Gateway is just the control plane — the product is the assistant.

If you want a personal, single-user assistant that feels local, fast, and always-on, this is it.

![moltbot1](/assets/images/202601/moltbot1.png)

![moltbot2](/assets/images/202601/moltbot2.png)

![moltbot19](/assets/images/202601/moltbot19.png)

![moltbot20](/assets/images/202601/moltbot20.png)

# What It Does

* **Runs on Your Machine**
  + Mac, Windows, or Linux. Anthropic, OpenAI, or local models. Private by default - your data stays yours.

* **Any Chat App**
  + Talk to it on WhatsApp, Telegram, Discord, Slack, Sigal, or iMessage. Works in DMs and group chats.

* **Persistent Memory**
  + Remembers you and becomes uniquely yours. Your preferences, your context, your AI.

* **Browser Control**
  + It can browse the web, fill forms, and extract data from any site.

* **Full System Access**
  + Read and write files, run shell commands, execute scripts. Full access or sandboxed - your choice.

* **Skills & Plugins**
  + Extend with community skills or build your own. It can even write its own.


# Works With Everything

See https://www.molt.bot/integrations.



# Install the CLI (recommended)

Works on macOS, Windows & Linux. The one-liner installs `Node.js` and everything else for you.

Runtime: **Node ≥22**.

``` bash
#!/bin/bash
# install.sh
curl -fsSL https://molt.bot/install.sh | bash
```

The wizard installs the Gateway daemon (launchd/systemd user service) so it stays running. **Legacy note**: `clawdbot` remains available as a compatibility shim.


![moltbot0](/assets/images/202601/moltbot0.png)

![moltbot26](/assets/images/202601/moltbot26.png)

具体安装过程如下：

![moltbot3](/assets/images/202601/moltbot3.png)

![moltbot4](/assets/images/202601/moltbot4.png)

![moltbot5](/assets/images/202601/moltbot5.png)

![moltbot6](/assets/images/202601/moltbot6.png)

![moltbot7](/assets/images/202601/moltbot7.png)

![moltbot8](/assets/images/202601/moltbot8.png)

![moltbot9](/assets/images/202601/moltbot9.png)

![moltbot10](/assets/images/202601/moltbot10.png)

![moltbot11](/assets/images/202601/moltbot11.png)

![moltbot12](/assets/images/202601/moltbot12.png)

![moltbot13](/assets/images/202601/moltbot13.png)

![moltbot14](/assets/images/202601/moltbot14.png)

![moltbot15](/assets/images/202601/moltbot15.png)

![moltbot16](/assets/images/202601/moltbot16.png)

![moltbot17](/assets/images/202601/moltbot17.png)

![moltbot18](/assets/images/202601/moltbot18.png)


# [Uninstall](https://docs.molt.bot/install/uninstall)

Uninstall the gateway service + local data (CLI remains).

``` bash
moltbot uninstall
moltbot uninstall --all --yes
moltbot uninstall --dry-run
```


# Run the onboarding wizard (and install the service)

``` bash
moltbot onboard --install-daemon
```

What you’ll choose:

* **Local vs Remote** gateway
* **Auth**: OpenAI Code (Codex) subscription (OAuth) or API keys. For Anthropic we recommend an API key; `claude setup-token` is also supported.
* **Providers**: WhatsApp QR login, Telegram/Discord bot tokens, Mattermost plugin tokens, etc.
* **Daemon**: background install (`launchd/systemd`; WSL2 uses systemd)
  + **Runtime**: Node (recommended; required for WhatsApp/Telegram). Bun is not recommended.
* **Gateway token**: the wizard generates one by default (even on loopback) and stores it in `gateway.auth.token`.

Wizard doc: [Wizard](https://docs.molt.bot/start/wizard)


# Auth: where it lives (important)

* **Recommended Anthropic path**: set an API key (wizard can store it for service use). `claude setup-token` is also supported if you want to reuse Claude Code credentials.
* Auth profiles (OAuth + API keys): `~/.clawdbot/agents/<agentId>/agent/auth-profiles.json`

Headless/server tip: do OAuth on a normal machine first, then copy `oauth.json` to the gateway host.


![moltbot30](/assets/images/202601/moltbot30.png)


# Start the Gateway

If you installed the service during onboarding, the Gateway should already be running:

``` bash
moltbot gateway status
```

![moltbot31](/assets/images/202601/moltbot31.png)

Manual run (foreground):

``` bash
moltbot gateway --port 18789 --verbose
```

Dashboard (local loopback): `http://127.0.0.1:18789/` If a token is configured, paste it into the Control UI settings (stored as `connect.params.auth.token`).


# Quick verify (2 min)

``` bash
moltbot status
moltbot status --all

moltbot health

moltbot security audit --deep
```

> Tip: `moltbot status --all` is the best pasteable, read-only debug report. Health probes: `moltbot health` (or `moltbot status --deep`) asks the running gateway for a health snapshot.

![moltbot32](/assets/images/202601/moltbot32.png)

![moltbot33](/assets/images/202601/moltbot33.png)

![moltbot34](/assets/images/202601/moltbot34.png)







# Channles

## [Imessage](https://docs.molt.bot/channels/imessage)

Status: external CLI integration. Gateway spawns imsg rpc (JSON-RPC over stdio).

### Quick setup (beginner)

1. Ensure Messages is signed in on this Mac.
2. Install `imsg`: `brew install steipete/tap/imsg`
3. Configure Moltbot with `channels.imessage.cliPath` and `channels.imessage.dbPath`.
4. Start the gateway and approve any macOS prompts (Automation + Full Disk Access).

Minimal config:

``` json
{
  channels: {
    imessage: {
      enabled: true,
      cliPath: "/usr/local/bin/imsg",
      dbPath: "/Users/<you>/Library/Messages/chat.db"
    }
  }
}
```

![moltbot29](/assets/images/202601/moltbot29.png)

# 使用 lighthouse 部署 OpenClaw 全能助手

## 购买 OpenClaw 云服务

在 https://cloud.tencent.com/act/pro/lighthouse-moltbot 上购买已经集成 OpenClaw 的服务。

![openclaw5](/assets/images/202601/openclaw5.png)

![openclaw6](/assets/images/202601/openclaw6.png)

![openclaw7](/assets/images/202601/openclaw7.png)

## 配置 OpenClaw

![openclaw8](/assets/images/202601/openclaw8.png)

![openclaw9](/assets/images/202601/openclaw9.png)

![openclaw10](/assets/images/202601/openclaw10.png)


## QQ开放平台申请机器人

在 https://q.qq.com/#/ 完成实名注册认证，然后使用注册邮箱登陆。

![openclaw11](/assets/images/202601/openclaw11.png)

![openclaw12](/assets/images/202601/openclaw12.png)

![openclaw13](/assets/images/202601/openclaw13.png)

![openclaw14](/assets/images/202601/openclaw14.png)


在管理页面获取到当前机器人的 AppID 和 AppSecret，并且把自己的服务器 IP 填入到白名单中。

![openclaw15](/assets/images/202601/openclaw15.png)

![openclaw16](/assets/images/202601/openclaw16.png)


登陆终端测试 chatbot 功能是否正常。

![openclaw17](/assets/images/202601/openclaw17.png)

添加 QQ 群和自己的 QQ 号，以调用机器人。

![openclaw18](/assets/images/202601/openclaw18.png)

在手机端 QQ 中，添加机器人：设置 → 群机器人 → 其他

![openclaw19](/assets/images/202601/openclaw19.png)

![openclaw20](/assets/images/202601/openclaw20.png)


## Web Search 能力

### 配置 Brave API (收费)

Brave Search 是内置的 web_search 工具，但是收费，可以让 OpenClaw 禁用它，并替换为其他免费的方案。

![openclaw21](/assets/images/202601/openclaw21.png)

![openclaw22](/assets/images/202601/openclaw22.png)

### 配置 finnhub (免费)

通过 [finnhub](https://finnhub.io/dashboard) 查询股票价格：

![openclaw23](/assets/images/202601/openclaw23.png)

![openclaw24](/assets/images/202601/openclaw24.png)

### 配置 tavily (免费)

https://www.tavily.com/




## Skills

![openclaw25](/assets/images/202601/openclaw25.png)


## 更多用法

[云上 OpenClaw 最全实践教程合辑](https://cloud.tencent.com/developer/article/2624973)



# 常用命令

## 打开终端 openclaw tui

![openclaw28](/assets/images/202601/openclaw28.png)


## 选择配置选项 openclaw configure

![openclaw26](/assets/images/202601/openclaw26.png)


## 重启 gateway 使得配置生效 openclaw gateway restart

![openclaw27](/assets/images/202601/openclaw27.png)

## 问题定位 openclaw logs --follow

![openclaw32](/assets/images/202601/openclaw32.png)

![openclaw33](/assets/images/202601/openclaw33.png)





# Q&A


## MiniMax 接口配置

由于 Kimi、MiniMax、GLM 分了国际版和国内版，Clawdbot 默认集成的是国际版的接口地址，因此如果在配置模型时需要使用这三家的模型，则需要登录国际版控制台申请 API Key：

* Kimi：https://platform.moonshot.ai/
* MiniMax：https://platform.minimax.io/
* GLM：https://z.ai/manage-apikey/apikey-list








# Refer

* https://www.molt.bot/
* https://docs.molt.bot/
* https://github.com/moltbot/moltbot
* https://docs.molt.bot/getting-started
* https://docs.molt.bot/start/getting-started
* https://docs.molt.bot/help/troubleshooting
* https://docs.molt.bot/help/faq
* [被 Anthropic 强制要求改名！Clawdbot 创始人一人开发、100% AI 写代码](https://www.infoq.cn/news/Nb7WV3WYhhCoGdlq6MZy)
* [云上Moltbot（原Clawdbot）最全实践指南合辑](https://cloud.tencent.com/developer/article/2624973)
* [云上Moltbot（原Clawdbot）接入企业微信完全指南](https://cloud.tencent.com/developer/article/2625147)
* [云上Moltbot（原Clawdbot）接入QQ完全指南](https://cloud.tencent.com/developer/article/2625097)