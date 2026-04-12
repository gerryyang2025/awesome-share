---
layout: post
title:  "Cocos in Action"
date:   2026-04-12 14:00:00 +0800
description: "基于 Cocos Creator 3.8 官方手册归纳：在 macOS 上通过 Cocos Dashboard 安装与启动、工程目录与版本控制要点、编辑器面板与典型开发流程、Hello World（场景与 TypeScript 组件）、首个 2D/3D 小游戏学习路径，以及示例仓库、社区与 Cocos Store 等获取帮助的渠道。"
categories: Game
tags:
  - Cocos
  - Cocos Creator
  - 游戏开发
  - TypeScript
  - 2D
  - 3D
  - macOS
---

* Do not remove this line (it will not be displayed)
{:toc}

> [Cocos Creator](https://www.cocos.com/creator) 是 Cocos 旗下的集成式游戏开发工具，面向 2D、3D、UI 与跨平台发布；脚本以 **TypeScript** 为主，编辑器提供场景搭建、资源管理、动画与预览等完整工作流。官方中文手册（以 3.8 为例）：[新手入门](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/)。本文按「在 macOS 上从安装到做出第一个小游戏」的路径整理，便于对照文档逐步实践。

**文档与官网（官方索引）**

- **Cocos Creator User Manual**：[https://docs.cocos.com](https://docs.cocos.com) — 用户手册总入口（各版本在路径中切换，例如 Creator 3.8 中文：`/creator/3.8/manual/zh/`）。
- **Cocos Engine Official Website**：[https://www.cocos.com](https://www.cocos.com) — Cocos 引擎与产品站。
- **手册源码仓库**：[cocos/cocos-docs](https://github.com/cocos/cocos-docs) — 《Cocos Creator User Manual》的 Markdown 内容与构建脚本（本地可 `npm install` 后按仓库 README 用 VitePress 开发/构建）；与线上 [docs.cocos.com](https://docs.cocos.com) 对应，适合对照勘误、提 issue 或贡献文档。

# Cocos Creator 是什么

**Cocos Creator** 将引擎能力与可视化编辑器结合在一起：用**场景与节点**组织内容，用**组件（脚本）**驱动逻辑，再经**构建发布**导出到 Web、原生移动与桌面等目标。与纯代码引擎相比，它更强调**编辑器内闭环**（资源导入、Prefab、动画、预览与构建）。

从 **v2.3.2** 起，官方通过 **Cocos Dashboard** 统一管理多版本编辑器下载、升级与项目入口，减少「装错版本、项目打不开」一类问题。详见 [安装和启动](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/install/)。

---

# 在 macOS 上安装与启动

## 下载 Cocos Dashboard

从 [Cocos Creator 产品页](https://www.cocos.com/creator) 获取 **Dashboard** 安装包（macOS 为 **dmg**）。安装完成后，将 **CocosDashboard.app** 拖入「应用程序」或任意目录，双击启动。

**常见 macOS 提示处理**（与官方说明一致）：

- 若提示 dmg/app **已损坏**、**身份不明开发者**或**恶意软件**：在访达中 **右键 → 打开**，在对话框中再次确认打开；必要时在 **系统设置 → 隐私与安全性** 中选择 **仍要打开**。
- 若安装时出现 **「已损坏，无法打开」**：检查是否有 **Xcode** 等软件占用 Dashboard 安装目录相关文件，先退出冲突软件，卸载 Dashboard 后重装。

**系统版本**：官方写明 Dashboard 支持的 **Mac 最低为 OS X 10.9**（以当前安装包要求为准，见 [安装和启动](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/install/)）。

## 运行 Dashboard 并登录

启动 **Cocos Dashboard** 后，使用 **Cocos 开发者账号** 登录；若无账号可在登录界面注册。登录后可使用在线服务、更新通知等；本地会保留 session，一般无需每次手动登录。

在 Dashboard 的 **「编辑器」** 分页中安装所需 **Cocos Creator** 版本；在 **「项目」** 分页 **新建 / 打开** 工程。具体引擎版本号建议与团队或教程要求一致。

## 显卡与预览

编辑器依赖 **GPU** 做界面与场景渲染。若在 **Windows** 等平台遇到 **WebGL 不支持** 类报错，通常是显卡驱动过旧；**macOS** 上一般通过系统更新与使用官方驱动环境即可。详见文档 [安装和启动 → 检查显卡驱动](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/install/)（跨平台说明同样有助于理解预览失败原因）。

---

# 工程结构（项目目录）

用 Dashboard 创建并打开项目后，根目录大致如下（摘自 [项目结构](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/project-structure/)）：

| 路径 / 文件 | 作用 |
| :--- | :--- |
| `assets/` | **资源根目录**：脚本、贴图、场景等；仅此处内容会出现在 **资源管理器**；每个资源对应 `.meta`（需纳入版本控制） |
| `build/` | **构建输出**（执行构建发布后生成） |
| `library/` | 资源导入后的生成目录；可删后重开工程自动重建 |
| `local/` | 本机编辑器窗口布局等，一般不需关心 |
| `profiles/` | 编辑器与构建等配置 |
| `settings/` | 项目设置，**建议在团队间同步并纳入版本控制** |
| `temp/` | 临时缓存，可关闭编辑器后清理 |
| `extensions/` | 项目级扩展（可手动创建） |
| `package.json` | 与 `assets` 一起作为合法 Creator 工程的标志 |

**版本控制建议**：新建项目会生成 `.gitignore`；通常应提交 **`assets`、`extensions`、`settings`、`package.json`** 及你主动加入的关联文件；**不要**把仅本机生成的冗余目录无差别提交。详见官方 [项目结构 → 版本控制](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/project-structure/)。

---

# 编辑器 Cocos Creator：界面与职责

编辑器由多块**可拖拽、可组合**的面板构成，默认布局可参考 [编辑器界面介绍](https://docs.cocos.com/creator/3.8/manual/zh/editor/)：

- **层级管理器**：场景节点树，与场景编辑器中可见对象一一对应。
- **资源管理器**：展示 `assets` 下资源，支持从外部拖入文件或导入资源。
- **场景编辑器**：摆放、变换节点，**所见即所得**编辑场景。
- **属性检查器**：编辑选中节点与组件的属性；脚本里用 `@property` 暴露的字段也会在此显示。
- **动画编辑器**：编辑动画剪辑与简单联动（复杂管线可结合文档中动画章节）。
- **项目预览**：在浏览器或模拟器等环境预览运行效果。
- **控制台**：报错、警告与日志。

另可在菜单中打开 **偏好设置**（全局）、**项目设置**（单项目），以及集成在编辑器内的 **Cocos Service** 等服务面板，详见文档同页链接。

---

# Cocos Creator 的典型开发流程

结合官方「新手入门」与「Hello World / 快速上手」章节，一条常见闭环是：

1. **Dashboard**：安装对应版本 **Creator**，**新建项目**（可选 Empty、2D 模板等）。
2. **编辑场景**：在 **场景编辑器** 中创建节点（2D 精灵/UI 多在 **Canvas** 下；3D 用立方体、胶囊体等），在 **层级管理器** 调整父子关系。
3. **编写脚本**：在 `assets` 下 **创建 TypeScript**，继承 `Component`，在 `start` / `update` 中写逻辑；用 **input** 等 API 处理输入。
4. **挂载组件**：将脚本挂到节点（**属性检查器 → 添加组件** 或拖拽脚本）。
5. **保存场景**：**Ctrl/Cmd + S** 保存场景资源，避免丢失。
6. **预览**：点击工具栏 **预览**，在浏览器等环境查看；可用开发者工具查看 `console` 输出。
7. **构建发布**：菜单 **项目 → 构建发布**，生成对应平台的 `build` 产物。

更细的步骤以 [Hello World](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/helloworld/) 与下方「快速上手」两节为准。

---

# Hello World 示例（最小闭环）

官方 [Hello World 项目](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/helloworld/) 建议流程摘要：

1. 在 Dashboard **新建** 工程，模板可选 **empty**。
2. 在 **资源管理器** 中 **创建 → Scene**，得到新场景。
3. 在 **层级管理器** 中 **创建 → 3D 对象 → Cube**，场景中可见立方体。
4. **创建 → TypeScript**，例如命名为 `HelloWorld`；在 **偏好设置 → 外部程序** 中指定 **VS Code** 等默认脚本编辑器。
5. 在脚本中为组件实现 `start()`，内写 `console.info('Hello world')`（完整模板见官方页面）。
6. 选中 Cube，在 **属性检查器** 底部 **添加组件 → 自定义脚本 → HelloWorld**，保存场景后点 **预览**；在浏览器开发者工具控制台中应能看到输出。
7. 可选：选中 **Main Camera**，用 **Gizmo** 或 **Position** 调整相机，使立方体在画面中更清晰。

这一步验证的是：**场景 → 节点 → 组件脚本 → 预览** 全链路畅通。

---

# 快速上手：第一个 2D 游戏

官方教程：[快速上手：制作第一个 2D 游戏](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/first-game-2d/) 以 **2D 平台跳跃** 为体裁，核心是：

- 用 Dashboard **新建 Empty(2D)** 工程。
- 用内置 UI 图（如 `internal/default_ui/` 下的资源）拼 **Sprite** 主角与地图块；注意 **2D/UI 需在 Canvas 下** 才可见。
- 建立 **PlayerController** 等脚本，用 **input** 监听 **鼠标**（如左键跳一步、右键跳两步），在 **update** 中根据时间与目标位置更新节点位移。
- 将地图块做成 **Prefab** 复用，场景保存到 `Scene` 等目录以便管理。

完整代码与图示以官方分页为准；跟着做一遍可熟悉 **2D 层级、Prefab、输入与每帧更新**。

---

# 快速上手：第一个 3D 游戏（一步两步）

官方教程：[快速上手：制作第一个 3D 游戏](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/first-game/) 带领完成小游戏 **「一步两步」**（反应类跳跃：根据路面选择跳一步或两步）。要点包括：

- **Player** 空节点 + **Body** 子节点（如 **胶囊体**），父节点管水平移动、子节点管垂直动画，逻辑分离。
- 用 **Cube** 搭跑道；**PlayerController** 脚本中同样通过 **input.on(Input.EventType.MOUSE_UP, …)** 响应操作，用 **update** 做插值移动，并用变量记录步长、目标位置与跳跃状态。

对应 **示例仓库**：[tutorial-mind-your-step-3d](https://github.com/cocos/tutorial-mind-your-step-3d)（与文档配套）。另有一版 **网页导出的分步说明** 可对照：[MindYourStep_Tutorial（gameall3d.github.io）](https://gameall3d.github.io/MindYourStep_Tutorial/index.html)，适合在浏览器中翻阅步骤（与官方 GitHub 示例同源思路，版本以你本机 Creator 为准）。

---

# 示例与教程

官方汇总页：[示例与教程](https://docs.cocos.com/creator/3.8/manual/zh/cases-and-tutorials/) 列出材质、渲染管线、物理、Marionette 动画、UI、网络等 **GitHub / Gitee 示例**，并链接 **B 站系列视频**（如 3D 跑酷、俯视角 RPG、射击与「快上车」等）。下载仓库时请认准 **与当前 Creator 版本匹配的分支**，README 或 release 一般会注明。

**实用方案与整理帖**（论坛）：页面中的 [学习资料整理](https://forum.cocos.org/t/topic/122399) 等可作为补充索引。

---

# 获取帮助和支持

依据 [获取帮助和支持](https://docs.cocos.com/creator/3.8/manual/zh/getting-started/support.html)：

- **社区与提问**：[Cocos 论坛](https://forum.cocos.org/)（文档中专题链接见 [论坛分区](https://forum.cocos.org/c/58)）。
- **技术支持**：[Cocos 技术支持入口](https://www.cocos.com/assistant)。
- **内容生态**：[Cocos Store](http://store.cocos.com/) — 美术、插件、源码与学习 Demo。
- **官方新媒体**：微信公众号、 [B 站 Cocos 官方](https://space.bilibili.com/491120849/dynamic) 等，用于更新与教程直播。
- **参与引擎贡献**：可向引擎仓库提交 PR，说明见 [如何在 GitHub 上向 Creator 提交代码](https://docs.cocos.com/creator/3.8/manual/zh/submit-pr/submit-pr.html)。

第三方工具方面，文档列举 **VS Code**、**WebStorm** 等作为脚本与工程辅助，可与 Creator **外部脚本编辑器** 设置配合使用。

---

# 小结

在 **macOS** 上：**安装 Dashboard → 安装对应版本 Creator → 登录并新建项目**，即可在 **Cocos Creator** 中用 **场景 + TypeScript 组件** 完成从 **Hello World** 到 **2D/3D 官方小游戏** 的学习路径；工程上牢记 **`assets` / `settings` / `package.json` 与 `.meta` 的版本控制习惯**，遇到问题时优先查 **3.8 手册** 与 **论坛 / 技术支持 / Store**。若你接下来会固定某一 Creator 小版本开发，建议把该版本号写进团队 README，并与构建机保持一致，以减少「本地能跑、同事打不开」的差异。
