---
layout: post
title:  "Godot in Action"
date:   2026-04-09 14:00:00 +0800
last_modified_at: 2026-04-10 01:54:14 +0800
description: "基于 Godot 官方文档归纳：引擎定位、架构分层、功能与系统要求、初学开发与目标平台建议（含 macOS 安装包命名与官方 2D 教程兼容性）、版本策略、从入门到完成首个 2D/3D 小游戏的步骤，以及独立仓库中的 2D/3D 实践示例 Signal Sweep 与 Beacon Runner 3D。"
categories: Game
tags:
  - Godot
  - 游戏开发
  - GDScript
  - 2D
  - 3D
  - 开源
---

* Do not remove this line (it will not be displayed)
{:toc}

> [Godot Engine](https://godotengine.org/zh-cn/) 是自由开源、社区驱动的 2D/3D 游戏引擎，采用宽松的 [MIT 许可](https://docs.godotengine.org/en/stable/about/complying_with_licenses.html)，无版税与使用限制；由 [Godot Foundation](https://godot.foundation/) 支持。官方文档入口：[稳定版文档](https://docs.godotengine.org/en/stable/)；文档总览与结构说明见 [Introduction](https://docs.godotengine.org/en/stable/about/introduction.html)。本文根据官方「About」「Getting Started」「Engine details / Architecture」等章节归纳，便于快速建立心智模型并按步骤做出一个小游戏。

# Godot 引擎概览

Godot 是**通用型** 2D 与 3D 游戏引擎，可在**统一界面**下制作游戏或应用，并导出到桌面、移动、Web 等目标平台（主机需自行评估移植或合作方，见[官网主机说明](https://godotengine.org/consoles/)）。引擎自 2001 年起在工作室内部演进，2014 年开源后持续迭代；商业与开源作品可参考[官方 Showcase](https://godotengine.org/showcase/)。

编辑器集成代码、动画、TileMap、着色器、调试器、分析器等工具，并支持外部工作流（如 [Blender](https://www.blender.org/) 导入 3D、[VS Code](https://github.com/godotengine/godot-vscode-plugin) 等外部编辑器）。

脚本方面，主推 **[GDScript](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html)**（与引擎深度集成、语法轻量）与 **[C#](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html)**；通过 **[GDExtension](https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/what_is_gdextension.html)** 可在 **C++** 等语言中编写高性能或对接第三方库的逻辑而无需重编引擎。引擎本身亦可 fork 后增加模块。

使用 Godot 需要**扎实的编程基础**与面向对象思维（类、对象）；完全零基础可先使用社区资源如 [Learn GDScript From Zero](https://gdquest.github.io/learn-gdscript)（[桌面版](https://gdquest.itch.io/learn-godot-gdscript)），再回到官方入门路径。

文档除手册外，还包括可在编辑器内查阅的 **[Class Reference](https://docs.godotengine.org/en/stable/classes/index.html)**。引擎源码与 issue/PR 见主仓库 [godotengine/godot](https://github.com/godotengine/godot)；入门示例工程见 [godot-demo-projects](https://github.com/godotengine/godot-demo-projects)。

---

# Godot 的架构（Architecture）

官方在 [Godot's architecture overview](https://docs.godotengine.org/en/stable/engine_details/architecture/godot_architecture_diagram.html) 中说明：下图**并非穷尽所有模块**，而是给出**高层组件及其关系**，便于理解引擎如何分层协作。图示原作者：[Hendrik Brucker](https://github.com/Geometror/godot-architecture-diagram)。

![Godot 高层架构示意图](https://docs.godotengine.org/en/stable/_images/godot-architecture-diagram.webp)

*图片来源：[Godot 稳定版文档](https://docs.godotengine.org/en/stable/_images/godot-architecture-diagram.webp)（与 [架构说明页](https://docs.godotengine.org/en/stable/engine_details/architecture/godot_architecture_diagram.html) 一致）*

各层要点如下（与官方描述一致）：

| 层次 | 作用 | 延伸阅读 / 源码位置（官方链接） |
| :--- | :--- | :--- |
| **Scene layer（场景层）** | 最高层，提供**场景系统**，是组织游戏与应用的主要方式；涉及 [SceneTree](https://docs.godotengine.org/en/stable/classes/class_scenetree.html)、[Node](https://docs.godotengine.org/en/stable/classes/class_node.html) 等。 | [Using SceneTree](https://docs.godotengine.org/en/stable/tutorials/scripting/scene_tree.html)；源码 [`/scene`](https://github.com/godotengine/godot/tree/master/scene) |
| **Server layer（服务器层）** | 多数子系统（渲染、音频、物理等）以 **Server 单例** 形式在引擎启动时初始化；与 **RID** 等资源标识配合工作。 | [Why does Godot use servers and RIDs?](https://godotengine.org/article/why-does-godot-use-servers-and-rids)；源码 [`/servers`](https://github.com/godotengine/godot/tree/master/servers) |
| **Drivers / Platform（驱动与平台接口）** | 抽象图形 API、音频后端与操作系统接口；包含各平台的 [OS](https://docs.godotengine.org/en/stable/classes/class_os.html)、[DisplayServer](https://docs.godotengine.org/en/stable/classes/class_displayserver.html) 等实现。 | 源码 [`/drivers`](https://github.com/godotengine/godot/tree/master/drivers)、[`/platform`](https://github.com/godotengine/godot/tree/master/platform) |
| **Core（核心）** | [Object](https://docs.godotengine.org/en/stable/classes/class_object.html)、[ClassDB](https://docs.godotengine.org/en/stable/classes/class_classdb.html)、内存与容器、[Variant](https://docs.godotengine.org/en/stable/engine_details/architecture/variant_class.html)、文件 I/O 等跨引擎复用的基础能力。 | [Core types](https://docs.godotengine.org/en/stable/engine_details/architecture/core_types.html)；源码 [`/core`](https://github.com/godotengine/godot/tree/master/core) |
| **Main（主循环）** | 负责引擎**生命周期**：启动、关闭与**主循环**。 | [MainLoop](https://docs.godotengine.org/en/stable/classes/class_mainloop.html)；源码 [`/main`](https://github.com/godotengine/godot/tree/master/main) |

对日常做游戏而言，**最常用的是场景层**：用节点树搭场景、用脚本响应逻辑；底层 Server/Core 多在排查性能、理解渲染或物理管线时再深入。

更多架构主题见 [Engine architecture 索引](https://docs.godotengine.org/en/stable/engine_details/architecture/index.html)。

---

# 功能与平台（节选）

[功能列表](https://docs.godotengine.org/en/stable/about/list_of_features.html) 极长，此处只列与「快速上手小游戏」最相关的类别：

- **平台**：编辑器与导出目标覆盖 Windows / macOS / Linux、Android、iOS（导出）、浏览器（Web 能力随版本演进，以文档为准）；具体以 [List of features → Platforms](https://docs.godotengine.org/en/stable/about/list_of_features.html#platforms) 为准。**C# 项目在 Web 等平台存在限制**，见文档说明。
- **编辑器**：场景树、内置脚本编辑器、外部编辑器、调试器、可视化分析器、热重载、远程检查器等；可通过[资源库](https://docs.godotengine.org/en/stable/community/asset_library/what_is_assetlib.html)扩展插件。
- **渲染**：Godot 4 提供三种渲染器——**Forward+**（桌面默认，Vulkan/D3D12/Metal）、**Mobile**（移动与部分桌面，更重速度）、**Compatibility**（OpenGL，偏低端与 Web）。详见 [Overview of renderers](https://docs.godotengine.org/en/stable/tutorials/rendering/renderers.html)。
- **2D**：精灵/矢量绘制、TileMap、2D 光照与阴影、粒子、多种物理体与碰撞形状等。
- **3D**：PBR 材质、实时光照与阴影、全局光照与反射探针等（具体以功能列表为准）。
- **其它**：动画、UI、音频、网络、XR 等均有完整章节。

---

# 系统要求（摘要）

完整表格见 [System requirements](https://docs.godotengine.org/en/stable/about/system_requirements.html)。以下为**简单 2D/3D 项目**在桌面端编辑器的常见参考（官方标注为说明性，非硬性保证）：

| 场景 | CPU / 内存 / 存储（示例级） |
| :--- | :--- |
| **最低** | 支持 SSE4.2 的 x86_64（因平台而异）、集成显卡需满足所选渲染器（如 Forward+ 需 Vulkan 1.0 级别）、**约 4 GB RAM**、约 **200 MB** 安装（另需单独下载导出模板等） |
| **推荐** | 四核以上、**8 GB+ RAM**、Vulkan 1.2 级别独显（依渲染器而定）、预留含导出模板在内的更大磁盘空间 |

**导出后的游戏**实际占用与帧率高度依赖分辨率、画质、脚本与资源体量；官方建议在低端机上**自行压测**，必要时提供画质选项。详见文档中的 Exported project 一节。

---

# 初学用户：开发与目标平台建议

「平台」这里分两层：**在哪台机器上装编辑器做开发**，以及**第一个成品主要跑在哪类设备上**。

**开发环境（运行 Godot 编辑器）**

- **建议**：在 **Windows、macOS 或 Linux 桌面**上安装**本地编辑器**，任选你**已熟悉、驱动与系统较稳定**的环境即可；三者均为官方主力支持，并无「新手必须用某一系统」之说。
- **不推荐作为初学主环境**：[网页编辑器](https://docs.godotengine.org/en/stable/tutorials/editor/using_the_web_editor.html)（实验性质，体验与能力不如本地）、在 **Android** 上运行编辑器（实验性质，见 [List of features → Editor / 平台说明](https://docs.godotengine.org/en/stable/about/list_of_features.html#platforms)）。适合偶尔试用，不适合长期跟教程。
- **硬件**：以 [System requirements](https://docs.godotengine.org/en/stable/about/system_requirements.html) 为准；想少踩坑可按文档中的**推荐**档准备内存与显卡驱动。

**GitHub Releases：安装包命名规则（避免下错）**

在 [godotengine/godot Releases](https://github.com/godotengine/godot/releases) 展开某一标签（如 [4.6.2-stable](https://github.com/godotengine/godot/releases/tag/4.6.2-stable)）下的 **Assets** 时，可按下述规则辨认**桌面版 Godot 编辑器**与其它资源：

- **通式**：`Godot_v{主版本.次版本.修订}-{渠道}_{平台或架构}.zip`（Windows 可执行文件多为 `Godot_v4.6.2-stable_win64.exe.zip` 这类 **`*_win64.exe.zip`** 形式）。**稳定版**标签里渠道一般为 **`stable`**（例如 `4.6.2-stable`）。
- **是否 C#**：文件名中若含 **`mono_`**（如 `Godot_v4.6.2-stable_mono_macos.universal.zip`），表示 **Mono/.NET 版编辑器**，供 **C#** 项目使用；**不含 `mono_`** 的为默认编辑器（**GDScript** 及官方入门教程常用）。二者不要混用需求：只做 GDScript 时不要下 mono 包（体积更大且依赖不同）；要用 C# 则必须下带 **`mono`** 的对应平台包。
- **平台字段**：中间一段必须与你的操作系统一致，例如 **`macos`**、**`linux`**、**`win32` / `win64` / `windows_arm64`**。下错平台无法在本地运行（例如在 macOS 上下成 `linux.x86_64` 无效）。

**各桌面系统应对的编辑器包（标准版 / 非 mono 示例名）**

| 你的系统 | 在 Assets 中应寻找的关键片段（`*` 为版本号，如 `4.6.2`） |
| :--- | :--- |
| **macOS**（Intel 或 Apple Silicon） | `Godot_v*-stable_macos.universal.zip` — **universal** 表示通用二进制，无需再选 arm64/x86_64。 |
| **Windows** 64 位（常见 PC） | `Godot_v*-stable_win64.exe.zip`。 |
| **Windows** 32 位 / 老环境 | `Godot_v*-stable_win32.exe.zip`（仅当确需 32 位时）。 |
| **Windows on ARM** | `Godot_v*-stable_windows_arm64.exe.zip`。 |
| **Linux** x86_64 | `Godot_v*-stable_linux.x86_64.zip`。 |
| **Linux** ARM64（如部分 ARM 桌面/树莓派等） | `Godot_v*-stable_linux.arm64.zip`（另有 `arm32`、`x86_32` 等，按 CPU 架构选择）。 |

若使用 **C#**，将上表中文件名在 **`stable_` 之后**插入 **`mono_`**，例如 `Godot_v*-stable_mono_macos.universal.zip`、`Godot_v*-stable_mono_win64.exe.zip`，并与 [C# 文档](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html) 中的环境要求一并配置。

**常见误下载（不是「日常用的桌面编辑器」）**

| 文件名特征 | 实际是什么 |
| :--- | :--- |
| `Godot_v*-stable_export_templates.tpz` | **导出模板**，供编辑器导出游戏到各平台时在「管理导出模板」里使用；**不是**编辑器本体。标准版项目选**不带** `mono_` 的 `export_templates.tpz`；C# 项目选 `Godot_v*-stable_mono_export_templates.tpz`。 |
| `Godot_native_debug_symbols.*` | **原生调试符号**，给深度调试/崩溃分析用，**不是**日常编辑、运行工程所需。 |
| `godot-*-stable.tar.xz` | **引擎源码**压缩包，用于自行编译，**不是**现成编辑器。 |
| `Godot_v*-stable_web_editor.zip` | **网页版编辑器**资源包；初学仍建议本地编辑器。 |
| `Godot_v*-stable_android_editor.apk` / `.aab` 等 | 在 **Android 设备**上跑编辑器的构建，**不是** PC/Mac 安装包。 |
| `godot-lib.*.aar` | **Android 模块/AAR**，面向 Android 集成开发，**不是**桌面编辑器。 |

下载后：**macOS** 解压得到 `Godot.app`，可移入「应用程序」；若首次打开被拦截，在「系统设置 → 隐私与安全性」中放行。也可从 [官网下载页](https://godotengine.org/zh-cn/download) 按系统筛选，避免在 Releases 长列表里选错。

**第一个游戏面向哪里（导出目标）**

- **初学阶段**：优先把可玩版本做到 **PC 桌面**（Windows / macOS / Linux），调试与导出流程相对直接。
- **维度上**：官方建议先完成 [Your first 2D game](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html)，再进 3D；这与操作系统无关，但能降低同步学习成本。
- **移动设备与 Web**：可在掌握基础后再做；会额外涉及分辨率与性能、触控、以及各商店/浏览器的打包与限制（**C# 项目在部分平台有额外说明**，见 [C# 文档](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html)）。

**macOS 上能否完成官方 2D 入门（如 Dodge the Creeps）**

**可以。** [Your first 2D game](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html) 从建工程、导入资源到节点与脚本，在文档中**未限定只能在某一桌面系统**完成（见 [Setting up the project](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/01.project_setup.html)）；2D 所用 API 为引擎跨平台能力，**macOS** 与 Windows / Linux 一样属于官方支持的编辑器环境（[System requirements](https://docs.godotengine.org/en/stable/about/system_requirements.html)、[List of features → Platforms](https://docs.godotengine.org/en/stable/about/list_of_features.html#platforms)）。

- **跟做 GDScript 版**：安装 macOS 用 Godot（如上文 **`macos.universal`** 包）即可，教程无额外系统依赖。
- **若使用 C# 版**：与所有桌面系统相同，需按 [C# 前置条件](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/c_sharp_basics.html) 安装 **.NET SDK** 等，与是否 macOS 无关。
- **环境与权限**：若默认渲染器在本机显卡或驱动上异常，可在项目或引擎设置中改用 **Compatibility** 等渲染器（见 [Overview of renderers](https://docs.godotengine.org/en/stable/tutorials/rendering/renderers.html)）；首次运行 `Godot.app` 若被系统拦截，在「隐私与安全性」中放行（见上文 **GitHub Releases** 一节）。

**一句话**：初学用习惯的 **桌面系统 + 本地 Godot**；第一个完整小作品优先面向 **PC**；先 **2D** 再 **3D**，再扩展到手机或网页。

---

# 版本与发布策略（为何要盯 4.x）

[Release policy](https://docs.godotengine.org/en/stable/about/release_policy.html) 要点：

- 版本号 **`major.minor.patch`**，大致对应语义化版本，但游戏引擎跨渲染、物理、脚本等多领域，**小版本也可能在局部有不兼容调整**。
- **`patch`**：以修复 Bug、安全与平台支持为主，**向后兼容**，建议积极跟进。
- **`minor`**：新功能为主，升级前建议在副本上测试。
- **`major`**：可能需大量迁移工作（如 3.x → 4.x 需转换工具与手工调整）。

**新项目**：官方**推荐 Godot 4.x**（长期支持预期优于 3.x）；若依赖仅 3.x 具备的能力（如文档中举例的 **GLES2 / WebGL 1.0**），再评估 **3.x**。跟随旧教程时建议同时打开 [Upgrading from Godot 3 to 4](https://docs.godotengine.org/en/stable/tutorials/migrating/upgrading_to_godot_4.html) 核对 API 更名。

---

# 学习路径（官方 Getting Started）

建议顺序与官方「入门」结构一致：

1. **[Introduction to Godot](https://docs.godotengine.org/en/stable/getting_started/introduction/introduction_to_godot.html)**：是否适合、能做什么、编辑器与语言概览。
2. **[Learn to code with GDScript](https://docs.godotengine.org/en/stable/getting_started/introduction/learn_to_code_with_gdscript.html)**：在引擎内学 GDScript 基础（若已有语言基础可略读）。
3. **[Step by step](https://docs.godotengine.org/en/stable/getting_started/step_by_step/index.html)**：节点与场景、实例化、脚本、输入、**信号（signals）** 等，为正式小游戏打底。
4. **二选一或先后完成**：
   - **[Your first 2D game](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html)**（「Dodge the Creeps!」）：移动、敌人生成、得分等；**新手优先 2D**，官方说明 2D 更易建立信心。
   - **[Your first 3D game](https://docs.godotengine.org/en/stable/getting_started/first_3d_game/index.html)**（「Squash the Creeps」）：跳跃、Kinematic 移动、物理层、动画与 UI 等；可与 2D 对照学习，但代码复杂度通常更高。

遇到问题可查 [FAQ](https://docs.godotengine.org/en/stable/about/faq.html)，或在 [社区频道](https://godotengine.org/community/)（如 Discord、论坛）提问；视频类资源见 [Tutorials and resources](https://docs.godotengine.org/en/stable/community/tutorials.html)。

---

# 实践示例：Signal Sweep（2D demo） {#godot-demo-signal-sweep}

除官方 [Your first 2D game](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html) 与 [godot-demo-projects](https://github.com/godotengine/godot-demo-projects) 外，下面给出一个**独立 Godot 4.x 工程**，便于对照「节点 + 脚本 + 简单玩法循环」的落地方式。

仓库 **[gerryyang2025/godot-in-action](https://github.com/gerryyang2025/godot-in-action)** 中的 **[demo_2d](https://github.com/gerryyang2025/godot-in-action/tree/master/demo_2d)** 为 2D 小游戏 **Signal Sweep**：驾驶飞船在固定竞技场里回收信标、躲避巡逻无人机；目标 Godot 版本为 **4.6.2**（见目录内 `README.md`）。克隆仓库后可用 `godot --path demo_2d` 运行，或在编辑器中打开 `demo_2d/project.godot`。

![Signal Sweep：2D demo 画面录屏](/assets/images/202604/godot_demo_2d.gif)

*录屏示意：占位几何与基础碰撞、计时与 UI 等均可在此工程中查看；细节以仓库内 `README.md`、`DESIGN.md` 为准。*

---

# 实践示例：Beacon Runner 3D（3D demo） {#godot-demo-beacon-runner-3d}

同仓库 **[demo_3d](https://github.com/gerryyang2025/godot-in-action/tree/master/demo_3d)** 为 3D 小游戏 **Beacon Runner 3D**：在封闭训练场中控制胶囊探测员，收集绿色信标并躲避红色巡逻无人机；含 **CharacterBody3D** 移动、跳跃与坠落判定等，目标 Godot 版本为 **4.6.2**（见目录内 `README.md`）。克隆仓库后可用 `godot --path demo_3d` 运行，或在编辑器中打开 `demo_3d/project.godot`。

![Beacon Runner 3D：3D demo 画面录屏](/assets/images/202604/godot_demo_3d.gif)

*录屏示意：占位 3D 几何、灯光与相机、计时与 UI 等均可在此工程中查看；细节以仓库内 `README.md`、`DESIGN.md` 为准。*

---

# 开发一个小游戏的推荐步骤（归纳）

下面将官方入门路径压缩为可执行的**步骤清单**，适用于自制 2D 或 3D 小游戏（可随项目规模增减）：

1. **环境与版本**
   安装当前推荐的 **Godot 4.x** 稳定版；确认显卡驱动满足所选渲染器（[System requirements](https://docs.godotengine.org/en/stable/about/system_requirements.html)）。需要 C# 时阅读 [C# 平台说明](https://docs.godotengine.org/en/stable/tutorials/scripting/c_sharp/index.html)。

2. **最小语言基础**
   完成 [GDScript 入门](https://docs.godotengine.org/en/stable/getting_started/introduction/learn_to_code_with_gdscript.html) 或等价基础，理解函数、变量与面向对象的基本用法。

3. **理解节点、场景与信号**
   跟完 [Step by step](https://docs.godotengine.org/en/stable/getting_started/step_by_step/index.html)：会搭场景树、会实例化子场景、会写脚本、会用 **信号** 解耦 UI 与游戏逻辑。

4. **选定维度与教程**
   - **2D**：按 [First 2D game](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html) 顺序做——工程设置 → 玩家场景 → 玩家逻辑 → 敌人 → 主场景 → HUD → 收尾；可下载官方资源包与同仓库 [Demo](https://github.com/godotengine/godot-demo-projects/tree/master/2d/dodge_the_creeps)。亦可参考 [实践示例：Signal Sweep](#godot-demo-signal-sweep) 中的 [demo_2d](https://github.com/gerryyang2025/godot-in-action/tree/master/demo_2d) 工程。
   - **3D**：按 [First 3D game](https://docs.godotengine.org/en/stable/getting_started/first_3d_game/index.html)——场景与输入 → 移动 → 怪物与生成 → 跳跃与碾压 → 结束与重开 → 动画与扩展；资源见教程页 [Starter 压缩包](https://github.com/godotengine/godot-docs-project-starters/releases/download/latest-4.x/3d_squash_the_creeps_starter.zip) 与 [Demo](https://github.com/godotengine/godot-demo-projects/tree/master/3d/squash_the_creeps)。亦可参考 [实践示例：Beacon Runner 3D](#godot-demo-beacon-runner-3d) 中的 [demo_3d](https://github.com/gerryyang2025/godot-in-action/tree/master/demo_3d) 工程。

5. **迭代玩法与内容**
   在教程骨架上替换美术、调整数值、加关卡或菜单；保持场景拆分与脚本职责清晰（玩家、敌人、关卡、UI 分场景实例化）。

6. **测试与导出**
   在目标分辨率与低端环境测试；配置 [导出模板](https://docs.godotengine.org/en/stable/tutorials/export/index.html)，按平台打包；必要时加入画质/分辨率选项（可参考官方 [graphics_settings](https://github.com/godotengine/godot-demo-projects/tree/master/3d/graphics_settings) 示例思路）。

7. **持续查阅**
   实现具体功能时查 [手册各专题](https://docs.godotengine.org/en/stable/index.html) 与 **Class Reference**；升级引擎时优先阅读对应版本的 **Release notes**，小版本升级后在分支上回归测试。

---

# 参考资料

下列地址为撰写本文时依据的 Godot 官方参考（与下列清单一致，顺序对应 About → Getting Started → Architecture）：

- 官网（中文）：[https://godotengine.org/zh-cn/](https://godotengine.org/zh-cn/)
- 引擎源码（GitHub）：[https://github.com/godotengine/godot](https://github.com/godotengine/godot)
- 版本发布与安装包（Releases）：[https://github.com/godotengine/godot/releases](https://github.com/godotengine/godot/releases)
- 稳定版文档：[https://docs.godotengine.org/en/stable/](https://docs.godotengine.org/en/stable/)
- 简介：[Introduction](https://docs.godotengine.org/en/stable/about/introduction.html)
- 功能列表：[List of features](https://docs.godotengine.org/en/stable/about/list_of_features.html)
- 系统要求：[System requirements](https://docs.godotengine.org/en/stable/about/system_requirements.html)
- 常见问题：[FAQ](https://docs.godotengine.org/en/stable/about/faq.html)
- 发布策略：[Release policy](https://docs.godotengine.org/en/stable/about/release_policy.html)
- Godot 简介：[Introduction to Godot](https://docs.godotengine.org/en/stable/getting_started/introduction/introduction_to_godot.html)
- GDScript 入门：[Learn to code with GDScript](https://docs.godotengine.org/en/stable/getting_started/introduction/learn_to_code_with_gdscript.html)
- 循序渐进：[Step by step](https://docs.godotengine.org/en/stable/getting_started/step_by_step/index.html)
- 首个 2D 游戏：[Your first 2D game](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html)
- 首个 3D 游戏：[Your first 3D game](https://docs.godotengine.org/en/stable/getting_started/first_3d_game/index.html)
- 引擎架构索引：[Engine architecture](https://docs.godotengine.org/en/stable/engine_details/architecture/index.html)
- 架构图说明：[Godot architecture diagram](https://docs.godotengine.org/en/stable/engine_details/architecture/godot_architecture_diagram.html)
- 实践仓库 2D demo（Signal Sweep）：[https://github.com/gerryyang2025/godot-in-action/tree/master/demo_2d](https://github.com/gerryyang2025/godot-in-action/tree/master/demo_2d)
- 实践仓库 3D demo（Beacon Runner 3D）：[https://github.com/gerryyang2025/godot-in-action/tree/master/demo_3d](https://github.com/gerryyang2025/godot-in-action/tree/master/demo_3d)
