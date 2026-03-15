---
layout: post
title:  "Minimax in Action"
date:   2026-02-28 12:30:00 +0800
categories: ML
tags:
  - Minimax
  - Machine Learning

---

* Do not remove this line (it will not be displayed)
{:toc}


# MiniMax

https://platform.minimaxi.com/subscribe/coding-plan

![cc44](/assets/images/202601/cc44.png)

![cc45](/assets/images/202601/cc45.png)


**邀请码：**

```
🎁 MiniMax 跨年福利来袭！邀好友享 Coding Plan 双重好礼，助力开发体验！
好友立享 9折 专属优惠 + Builder 权益，你赢返利 + 社区特权！
👉 立即参与：https://platform.minimaxi.com/subscribe/coding-plan?code=5XvxeGS5Uv&source=link
```

![cc46](/assets/images/202601/cc46.png)


# 在 Claude Code 中使用 MiniMax-M2.1

![cc0](/assets/images/202601/cc0.png)

参考：https://platform.minimaxi.com/docs/guides/text-ai-coding-tools

MiniMax-M2.1 & MiniMax-M2.1-lightning 兼容 OpenAI 和 Anthropic 接口协议，适用于代码助手、Agent 工具、AI IDE 等多种场景。

> MiniMax 开放平台提供两种计费方案接入文本模型：Coding Plan 以及 按量计费。您可按照使用需求选择。调用计费模式取决于您所使用的 API Key，不同类型的 Key 将触发不同的计费方式。

![cc1](/assets/images/202601/cc1.png)

在 `.bashrc` 添加下面命令：

```bash
unset ANTHROPIC_AUTH_TOKEN
unset ANTHROPIC_BASE_URL
```


## 安装 Claude Code

可参考 [Claude Code 文档](https://docs.claude.com/en/docs/claude-code/setup) 进行安装。

## 获取 API Key

### Coding Plan API Key

推荐您订阅 [Coding Plan](https://platform.minimaxi.com/subscribe/coding-plan), 为用户的编程提升效率。

* 访问 Coding Plan 选择最适合的编程套餐
* 前往 [账户管理/Conding Plan](https://platform.minimaxi.com/user-center/payment/coding-plan) 页面，查看订阅的 Coding Plan 套餐，并获得 Coding Plan 的 API Key，用于编程工具使用。


## 开放平台 API Key（按量计费）

* 访问 [MiniMax 开放平台](https://platform.minimaxi.com/user-center/basic-information/interface-key) (国际用户可访问 [MiniMax Developer Platform](https://platform.minimax.io/user-center/basic-information/interface-key))
* 点击“**创建新的密钥**”按钮，输入项目名称以创建新的 API Key
* 创建成功后，系统将展示 API Key。**请务必复制并妥善保存，该密钥只会显示一次，无法再次查看**




## 配置 MiniMax API

### 安装 cc-switch

[cc-switch](https://github.com/farion1231/cc-switch) 是一个便捷的工具，可以快速切换 Claude Code 的 API 配置。

macOS:

```bash
brew tap farion1231/ccswitch
brew install --cask cc-switch
brew upgrade --cask cc-switch
```

Windows:

前往 [cc-switch GitHub Releases](https://github.com/farion1231/cc-switch/releases) 页面下载最新版本的安装包。

下载完成后启动 cc-switch 应用：

![cc2](/assets/images/202601/cc2.png)

### 申请 MiniMax API Key

需要通过绑定银行卡进行实名认证。

![cc4](/assets/images/202601/cc4.png)

![cc5](/assets/images/202601/cc5.png)

https://platform.minimaxi.com/user-center/payment/balance

![cc6](/assets/images/202601/cc6.png)

![cc7](/assets/images/202601/cc7.png)

![cc8](/assets/images/202601/cc8.png)

![cc9](/assets/images/202601/cc9.png)

### 添加 MiniMax 配置

启动 cc-switch，点击右上角 ”+” ，选择预设的 MiniMax 供应商，并填写用户的 MiniMax API Key。

![cc3](/assets/images/202601/cc3.png)

![cc10](/assets/images/202601/cc10.png)



### 配置模型名称

将模型名称全部改为 MiniMax-M2.1，完成后点击右下角的 “添加”。

![cc12](/assets/images/202601/cc12.png)



### 启用配置

回到首页，点击 “启用” 即可开始使用。

![cc11](/assets/images/202601/cc11.png)



## 启动 Claude Code

配置完成后，进入工作目录，在终端中运行 `claude` 命令以启动 Claude Code。

## 信任文件夹

启动后，选择 信任此文件夹 (Trust This Folder)，以允许 Claude Code 访问该文件夹中的文件，随后开始在 Claude Code 中使用 MiniMax-M2.1。


![cc13](/assets/images/202601/cc13.png)

![cc14](/assets/images/202601/cc14.png)

![cc15](/assets/images/202601/cc15.png)


## 执行 `/init` 命令生成 `CLAUDE.md`

![cc18](/assets/images/202601/cc18.png)

![cc19](/assets/images/202601/cc19.png)

![cc20](/assets/images/202601/cc20.png)

## Claude Code CLI 的 Bash 脚本包装器

新建一个 `claude-minimax` 脚本，将从 MiniMax M2 官网获取的[接口参数](https://platform.minimaxi.com/docs/api-reference/text-anthropic-api)填入。

```bash
#!/usr/bin/env bash
# Claude Code CLI wrapper for MiniMax API
# Usage: ./claude-minimax [claude arguments]

CLAUDE_BIN="$HOME/.local/bin/claude"

# Set API credentials for MiniMax
export ANTHROPIC_AUTH_TOKEN="Your Token"
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"
export ANTHROPIC_MODEL="MiniMax-M2"
export API_TIMEOUT_MS=3000000

# Optional: Use separate config directory
export CLAUDE_CONFIG_DIR="$HOME/Tools/llm/claude/claude-minimax"

# Execute Claude CLI with all passed arguments
exec "$CLAUDE_BIN" "$@"
```

功能说明：

* 设置 MiniMax API 的认证信息
* 指定使用 MiniMax-M2 模型
* 配置 API 超时时间为 3000000 毫秒（50分钟）
* 使用独立的配置目录避免与官方 Claude 配置冲突
* 将所有参数传递给原版 Claude CLI

完成后，可以测试一下，看看能否正常运行。

```bash
$ claude-minimax --version
```

![cc22](/assets/images/202601/cc22.png)


## 在 VS Code 使用 Claude Code 生成网页时钟的测试

第一步，新建一个本地目录作为项目目录，比如 `ai-clock`。然后，在 VS Code 里面打开这个目录 `ai-clock`，作为工作区。

第二步，打开 VS Code 的菜单"终端/新建终端"，在这个终端窗口里面，输入 `claude-minimax`。这时，窗口会提示你授予权限，同意后，就会进入主界面，大概就是下面这样。

![cc26](/assets/images/202601/cc26.png)

![cc23](/assets/images/202601/cc23.png)

![cc24](/assets/images/202601/cc24.png)

现在，我们就能在 VS Code 里面使用命令行的 Claude Code 了。这时，你既可以使用 IDE 编写代码，又可以通过命令行使用 AI 模型，兼得两者的优势。

第三步，在 Claude Code 的提示符后面，输入 `/init` 命令，用来在仓库里面生成一个 `CLAUDE.md` 文件，记录 AI 对这个仓库操作。

![cc25](/assets/images/202601/cc25.png)

![cc27](/assets/images/202601/cc27.png)

![cc28](/assets/images/202601/cc28.png)

由于示例仓库是空的，所以选择创建一个标准的 `CLAUDE.md` 模版文件。这个文件的作用是当作上下文，每次查询模型时，都会自动附上这个文件，以便模型了解代码库。

![cc29](/assets/images/202601/cc29.png)

如果在提示框输入反斜杠，Claude Code 就会显示所有可用的命令。通过这些命令，我们就能使用 Claude Code 的强大功能，完成各种 AI 操作了。这一步是 Claude Code 的基础用法，对所有项目都是通用的。

![cc30](/assets/images/202601/cc30.png)

第四步，在提示框输入前面的提示词（下图），让模型生成网页时钟。

> Create HTML/CSS of an analog clock showing ${time}. Include numbers (or numerals) if you wish, and have a CSS animated second hand. Make it responsive and use a white background. Return ONLY the HTML/CSS code with no markdown formatting.

翻译成中文就是："创建一个显示时间 ${time} 的模拟时钟的 HTML/CSS 代码。如果需要，可以包含数字，并添加 CSS 动画秒针。使其具有响应式设计，并使用白色背景。仅返回 HTML/CSS 代码，不要包含任何 Markdown 格式。"

![cc31](/assets/images/202601/cc31.png)

![cc32](/assets/images/202601/cc32.png)

![aiclock-minimax2](/assets/images/202601/aiclock-minimax2.gif)

重新执行 `/init` 命令更新 `CLAUDE.md` 文件。

![cc34](/assets/images/202601/cc34.png)

![cc35](/assets/images/202601/cc35.png)


# [在 Cursor 中使用 MiniMax-M2.1](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools#%E5%9C%A8-cursor-%E4%B8%AD%E4%BD%BF%E7%94%A8-minimax-m2-1)


## 安装 Cursor

* 通过 [Cursor 官网](https://cursor.com/) 下载并安装 Cursor
* 打开 Cursor，右上角“设置”按钮，进入设置界面。点击“Sign in”按钮，登录自己的 Cursor 账户

![cc37](/assets/images/202601/cc37.png)

## 在 Cursor 中配置 MiniMax API

![cc36](/assets/images/202601/cc36.png)

* 点击左侧栏的 “Models”，进入模型配置页面
* 展开 “API Keys” 部分，配置 API 信息：
  + 勾选 “Override OpenAI Base URL”
  + 在下方输入 MiniMax 的调用地址（国内用户使用 https://api.minimaxi.com/v1，国际用户使用 https://api.minimax.io/v1）
* 在 OpenAI API Key 输入框，配置从 [MiniMax 开放平台](https://platform.minimaxi.com/user-center/basic-information/interface-key) (国际用户可访问 [MiniMax Developer Platform](https://platform.minimax.io/user-center/basic-information/interface-key)) 获取的 API Key
* 点击 “OpenAI API Key” 栏右侧的按钮，在弹出的窗口中点击 “Enable OpenAI API Key” 按钮，完成设置验证
* 在 Models 板块中，点击 “View All Models” 按钮，并点击 “Add Custom Model” 按钮
* 输入模型名称 “MiniMax-M2.1” 后，点击 “Add” 按钮
* 启用刚添加的 “MiniMax-M2.1” 模型
* 在聊天面板中选择 “MiniMax-M2.1” 模型，开始使用 “MiniMax-M2.1”

![cc40](/assets/images/202601/cc40.png)

![cc41](/assets/images/202601/cc41.png)

![cc42](/assets/images/202601/cc42.png)

![cc38](/assets/images/202601/cc38.png)

![cc39](/assets/images/202601/cc39.png)

![cc43](/assets/images/202601/cc43.png)


# [在 Cursor 中使用 MiniMax-M2.5](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools#%E5%9C%A8-cursor-%E4%B8%AD%E4%BD%BF%E7%94%A8-minimax-m2-5)

模型名改为 “MiniMax-M2.5”。其余方法参考 [在 Cursor 中使用 MiniMax-M2.1](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools#%E5%9C%A8-cursor-%E4%B8%AD%E4%BD%BF%E7%94%A8-minimax-m2-1)。


# [在 OpenClaw 中使用 MiniMax-M2.5](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools#%E5%9C%A8-openclaw-%E4%B8%AD%E4%BD%BF%E7%94%A8-minimax-m2-5)

OpenClaw（原 Clawdbot） 是一个开源的 AI 助手，完全本地化，可以将各种消息平台与 AI 模型连接起来。它支持 WhatsApp、Telegram、Discord、iMessage 等多种平台，让您可以随时随地与 AI 助手对话。

官方文档：[OpenClaw 快速开始指南](https://docs.openclaw.ai/start/getting-started)

> 配置 MiniMax 模型

> 推荐使用「一键安装 OAuth 并登录」的方式进行安装。

下面是通过 OAuth 登录的配置方法。


## 打开配置设置

如果 openclaw 的初始配置引导没有出现模型配置，则可以通过以下命令再次进行 openclaw 配置：

```bash
openclaw configure
```

## 选择配置选项

* Where will the Gateway run? → 选择 **Local (this machine)**
* Select sections to configure → 选择 **Model**
* Model/auth provider → 选择 **MiniMax**
* MiniMax auth method → 选择 **MiniMax OAuth**
* MiniMax endpoint → 选择 **CN**

![openclaw29](/assets/images/202601/openclaw29.png)

## 登陆授权

登录并授权。

![openclaw30](/assets/images/202601/openclaw30.png)

## 确认模型选择

OAuth 登录完成后，进入模型选择。系统会默认勾选 minimax-portal/MiniMax-M2.1 和 minimax-portal/MiniMax-M2.5，并将 minimax-portal/MiniMax-M2.5 设为默认模型，可直接按回车确认使用。

![openclaw31](/assets/images/202601/openclaw31.png)


## 重启 gateway 使配置生效

执行 `openclaw gateway restart` 重启 gateway 使得配置生效。


![openclaw27](/assets/images/202601/openclaw27.png)

## 测试对话

输入 `openclaw tui`，若成功对话则表示配置成功。

![openclaw28](/assets/images/202601/openclaw28.png)


# Refer

* https://platform.minimaxi.com/user-center/payment/coding-plan
* [通过 AI 编程工具接入](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools)
