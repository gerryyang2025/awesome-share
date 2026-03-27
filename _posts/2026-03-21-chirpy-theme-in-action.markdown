---
layout: post
title:  "Chirpy 主题使用指南"
date:   2026-03-21 18:30:00 +0800
last_modified_at: 2026-03-27 10:00:00 +0800
description: "全面介绍 Jekyll Chirpy 主题的安装、写文章规范、Markdown 与 Kramdown 扩展语法，以及常用配置，是其他文章的参考模版。"
categories: Tools
tags:
  - Jekyll
  - Chirpy
  - 博客
  - 教程

---

* Do not remove this line (it will not be displayed)
{:toc}

> [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) 是面向技术写作的 Jekyll 主题，默认支持目录、暗色模式、数学公式、Mermaid、脚注与社交分享等。官方用一篇「文字与排版」文章集中演示这些能力，在线版见 [Text and Typography](https://chirpy.cotes.page/posts/text-and-typography/)，源码在主题的 [`_posts/2019-08-08-text-and-typography.md`](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/_posts/2019-08-08-text-and-typography.md)。

本仓库已在 `Gemfile` 中通过 `jekyll-theme-chirpy` 使用该主题（当前锁定版本与官方仓库 README 中的安装说明一致）。下面说明如何从零搭站、如何写文章，以及常用 Markdown 与 Kramdown 扩展写法；细节与完整示例仍以官方演示文为准。

# 资源链接

| 说明 | 链接 |
| :--- | :--- |
| 主题仓库 | [cotes2020/jekyll-theme-chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) |
| 快速开始 / 配置说明 | 仓库内 [README](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/README.md) 与 Wiki |
| 排版与语法演示（网页） | [chirpy.cotes.page — Text and Typography](https://chirpy.cotes.page/posts/text-and-typography/) |
| 演示文 Markdown 源码 | 同上仓库中 `text-and-typography` 对应 post 文件 |
| **如何写文章（Front Matter、媒体、内嵌等）** | [Writing a New Post](https://chirpy.cotes.page/posts/write-a-new-post/) |

# 新建站点与本地预览

推荐使用官方维护的 Starter，减少手工对齐目录与配置的成本：

1. 使用 GitHub 上的 **[chirpy-starter](https://github.com/cotes2020/chirpy-starter)** 生成仓库（Use this template），或按该仓库 README 克隆后安装依赖。
2. 在项目根目录执行 `bundle install`，再执行 `bundle exec jekyll serve`（或本仓库提供的 `./optools start` 等脚本）本地预览。

已有 Jekyll 站点若要换成 Chirpy，需按主题 README 调整 `_config.yml`、目录结构（如 `_tabs`、资源路径）与插件列表；步骤以官方文档为准，升级大版本前请阅读主题的 **Release notes**。

# 命名与存放路径

- 在站点根目录的 `_posts/` 下新建文件，文件名形如 **`YYYY-MM-DD-TITLE.EXTENSION`**。
- 扩展名只能是 **`md`** 或 **`markdown`**。
- 想少敲样板命令时，可用 [Jekyll-Compose](https://github.com/jekyll/jekyll-compose) 等插件生成 post 骨架（见 [Writing a New Post — Naming and Path](https://chirpy.cotes.page/posts/write-a-new-post/)）。

# 文章 Front Matter

Chirpy 默认把文章的 `layout` 设为 `post`，**Front Matter 里可以不写 `layout`**；写上 `layout: post` 也合法，与官方说明一致。

每篇文章顶部使用 YAML。下面字段与 [Writing a New Post](https://chirpy.cotes.page/posts/write-a-new-post/) 及官方演示文对齐：

```yaml
---
title: "文章标题"
date: 2026-03-21 12:00:00 +0800   # 建议带时区 +/-TTTT，与 _config.yml 的 timezone 配合
description: "摘要；用于 SEO、列表、Further Reading、RSS；也会显示在标题下方"
categories: [大类, 子类]            # 最多两个层级；也可单个字符串
tags: [标签一, 标签二]            # 数量任意；官方建议标签名小写
# 可选
toc: false                        # 关闭本页右侧目录（全站默认见 _config.yml 的 toc）
comments: false                   # 关闭本页评论（全站见 comments.provider）
author: author_id                 # 或 authors: [id1, id2]；见下文「作者」
pin: true                         # 置顶；多篇置顶时按发布日期倒序
math: true
mermaid: true
media_subpath: /path/to/media/    # 本页资源路径前缀，可与 site.cdn 组合
image:                            # 顶部预览图；也可简写为 image: /path/to/cover.png
  path: /path/to/cover.png
  alt: 封面说明
  lqip: /path/to/lqip-or-base64   # 可选：低质量占位图
---
```

**日期与时区**：除在 `_config.yml` 配置 `timezone` 外，建议在每篇文章的 `date` 里写出时区（如 `+0800`），便于准确记录发布时间。

**分类与标签**：`categories` 设计上**最多两个元素**（如 `[Animal, Insect]`）；`tags` 可以为空到任意多个。

**作者**：默认取自 `_config.yml` 的 `social.name` 与 `social.links` 首项。若要按文章指定作者，可在 `_data/authors.yml` 中定义条目（`name`、`twitter`、`url` 等），再在 Front Matter 里写 `author: <id>` 或 `authors: [id1, id2]`。这样页面可带上 `twitter:creator` 等 meta，利于 Twitter Card 与 SEO。

**描述 `description`**：不写则首页列表、Further Reading、RSS 等会用正文开头自动生成；写了则统一用你提供的摘要，并显示在文章标题下方。

**目录 TOC**：全站默认在 `_config.yml` 的 `toc`；单篇关闭用 `toc: false`。

**评论**：全站启用某提供商后，单篇可用 `comments: false` 关闭。

- 仅当文中含 **数学公式** 时设 `math: true`；含 **` ```mermaid `** 代码块时设 `mermaid: true`，避免全站不必要的脚本加载。
- `categories`、`tags` 会参与归档与分类页（需主题与 `jekyll-archives` 等配置配合，与本仓库 `_config.yml` 中 `jekyll-archives` 段一致）。

**MathJax 配置**：自 Chirpy v7.0.0 起，MathJax 选项在 `assets/js/data/mathjax.js`；若用 chirpy-starter 建站，可从 gem 安装目录拷贝该文件到仓库（`bundle info --path jekyll-theme-chirpy`）。

# Markdown 与主题扩展

下列写法摘自主题官方演示，可直接复制到文章中试用（更多变体见 [Text and Typography 源码](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/_posts/2019-08-08-text-and-typography.md)）。

## 提示块（Prompt）

在引用块后接 Kramdown 属性，类型为 `tip` / `info` / `warning` / `danger`：

````markdown
> 这是一条提示。
{: .prompt-tip }

> 这是一条信息。
{: .prompt-info }

> 这是一条警告。
{: .prompt-warning }

> 这是一条危险/重要提醒。
{: .prompt-danger }
````

## 行内「文件路径」样式

````markdown
编辑 `config.yml`{: .filepath} 以修改站点配置。
````

## 代码块：语言高亮与文件名

主题推荐使用 **围栏代码块**（` ```语言 `），**不要用** Jekyll 自带的 **`highlight` / `endhighlight` 这一对 Liquid 标签**（即文档里那种带花括号的代码高亮指令；Liquid 会先于 Markdown 解析这些标签，且与 Chirpy 文档建议不一致；见 [Writing a New Post — Code Block](https://chirpy.cotes.page/posts/write-a-new-post/)）。

默认除 `plaintext`、`console`、`terminal` 外会显示行号。若要去掉行号，在代码块后加 `{: .nolineno }`：

````markdown
```shell
echo 'No more line numbers!'
```
{: .nolineno }
````

若要为块标题显示「文件名」，在代码块**后**一行使用 `file=`：

````markdown
```bash
echo "hello"
```
{: file="scripts/hello.sh" }
````

文中若要**展示 Liquid 源码**，请用 Liquid 的 **raw** / **endraw** 标签整段包裹，或在 Front Matter 加 `render_with_liquid: false`（需 Jekyll 4+）。

## 数学公式（需 `math: true`）

启用后（见 [Writing a New Post — Mathematics](https://chirpy.cotes.page/posts/write-a-new-post/)）：

- **块级公式**：用 `$$ … $$`，且 **`$$` 前后必须有空行**。
- **编号公式**：`$$\begin{equation}…\label{eq:foo}\end{equation}$$`，文中用 `\eqref{eq:foo}` 引用。
- **行内公式**（段落中）：`$$ … $$`，**与前后文字之间不要空行**。
- **列表里的行内公式**：第一个 `$` 写成 `\$$`，例如 `\$$ E=mc^2 $$`。

更完整的排版示例仍以 [Text and Typography](https://chirpy.cotes.page/posts/text-and-typography/) 为准。

## Mermaid（需 `mermaid: true`）

````markdown
```mermaid
flowchart LR
  A[开始] --> B[结束]
```
````

## 媒体 URL 前缀（CDN 与 `media_subpath`）

- 全站 CDN：在 `_config.yml` 设置 `cdn: https://example.com`，头像与文章资源 URL 会带上该域名。
- 单篇前缀：Front Matter 设 `media_subpath: /path/to/media/`，与本页相关的资源可写相对该路径的文件名。
- 最终地址形如：`[site.cdn/][page.media_subpath/]file.ext`，两者可单独或组合使用（见 [Writing a New Post — Media](https://chirpy.cotes.page/posts/write-a-new-post/)）。

## 图片：题注、尺寸、位置、明暗与阴影

- **题注**：图片下一行写*斜体*，会显示为图片说明。
- **宽高**：避免布局抖动建议写尺寸，例如 `![说明](/path/to/img.png){: width="700" height="400" }`；v5+ 可用缩写 `w` / `h`。SVG 至少要指定 **width**，否则可能不渲染。
- **位置**：默认居中；可用 `{: .normal }`（偏左对齐）、`{: .left }`、**`{: .right }` 浮动**。官方说明：**一旦指定位置，不要再加题注**。
- **明暗**：准备两张图时，分别加 `{: .light }` 与 `{: .dark }`，随主题切换。
- **阴影**：窗口截图等可用 `{: .shadow }`。

## 文章顶部预览图（`image`）

- 推荐分辨率约 **1200×630**，宽高比约 **1.91 : 1**；不符合时会被缩放裁剪。
- 复杂写法：`image.path` + `image.alt`；若已设 `media_subpath`，`path` 可只写文件名。
- 简单写法：`image: /path/to/image`。
- **LQIP**：预览图可在 `image.lqip` 写占位图路径或 base64；正文内图片也可用 `{: lqip="/path/to/file" }`（参见官方「Text and Typography」预览图示例）。

更多变体仍以 [Text and Typography](https://chirpy.cotes.page/posts/text-and-typography/) 与 [Writing a New Post — Images](https://chirpy.cotes.page/posts/write-a-new-post/) 为准。

## 脚注

````markdown
正文中的引用[^fn1]。

[^fn1]: 脚注内容。
````

本仓库 `_config.yml` 中 `kramdown.footnote_backlink` 可自定义返回正文符号样式。

## 交叉引用（锚点与内部链接）

Kramdown 支持为标题或任意位置定义锚点，实现同一文章内部或跨文章的引用。

### 定义锚点

在目标标题后添加 `{#anchor-id}`：

````markdown
## 我的章节标题
{: #my-section }
````

### 同一文章内部引用

````markdown
跳转到[我的章节标题](#my-section)
````

### 跨文章引用

使用 Jekyll 的 `post_url` 标签（需加 `relative_url` 或裸 `post_url`）：

````markdown
{% raw %}
跳转到 [另一篇文章的章节]({% post_url 2026-02-28-minimax-in-action %}#在-openclaw-中使用-minimax-m2-5)
{% endraw %}
````

（`post_url` 会自动生成文章的绝对路径，再拼接 `#锚点` 即可定位到目标章节。）

### 注意事项

- 锚点 ID 应使用**英文**且**不含空格**（空格会被转为连字符 `-`），建议全小写。
- 链接中的锚点部分需与定义的 ID 匹配（连字符规则 Kramdown 会自动处理）。
- 若不确定目标文章的 URL 格式，优先使用 `post_url` 方式，而非手写相对路径。

## 内嵌社交平台音视频

统一形式为：`include` 主题的 `embed/<platform>.html`，并传入 `id='<ID>'`（`<platform>` 为小写平台名）。示例（YouTube）：

{% raw %}
```liquid
{% include embed/youtube.html id='H-B46URT4mg' %}
```
{% endraw %}

常见对应关系（摘自 [Writing a New Post — Social Media Platforms](https://chirpy.cotes.page/posts/write-a-new-post/)）：

| 示例 URL | Platform | ID |
| :--- | :--- | :--- |
| `youtube.com/watch?v=…` | `youtube` | 视频 ID |
| `twitch.tv/videos/…` | `twitch` | 视频数字 ID |
| `bilibili.com/video/…` | `bilibili` | 如 `BV…` |
| Spotify 曲目链接 | `spotify` | 曲目 ID |

Spotify 还可加 `compact=1`（紧凑播放器）、`dark=1`（深色）。

## 内嵌本地视频 / 音频文件

{% raw %}
```liquid
{% include embed/video.html src='/path/to/video.mp4' %}
{% include embed/audio.html src='/path/to/audio.mp3' %}
```
{% endraw %}

- **视频** 可选参数：`poster`、`title`、`autoplay`、`loop`、`muted`、`types`（同目录下其它格式，用 `|` 分隔，如 `ogg|mov`）。
- **音频** 可选参数：`title`、`types`（如 `ogg|wav|aac`）。

完整属性列表见 [Writing a New Post — Video Files / Audio Files](https://chirpy.cotes.page/posts/write-a-new-post/)。

## 标题与目录

若不希望某标题出现在侧边目录中，可为该标题添加属性，例如：

````markdown
## 附录
{: data-toc-skip='' }
````

（与官方演示文中对标题的写法一致。）

# 站点级配置（`_config.yml`）

与本主题相关的常见项包括：

- **`theme: jekyll-theme-chirpy`**（或通过 `remote_theme` 引入）。
- **`cdn`**：媒体与头像等资源的 URL 前缀（与单篇 `media_subpath` 组合方式见上文）。
- **`toc`**：是否默认开启文章目录。
- **`theme_mode`**：浅色 / 深色 / 跟随系统（空字符串常表示跟随主题默认逻辑，以当前版本文档为准）。
- **`comments`**：Disqus、Utterances、giscus 等，填好对应字段后启用。
- **`analytics`**：各统计平台 `id` 或配置块。

修改主题默认值时，仍建议将自定义样式与脚本放在站点目录（如 `assets`、`_sass`）中**覆盖**主题文件，而不是直接改 gem 内文件，便于升级。

# 小结

- 想**一眼看完主题能力**，打开 [Text and Typography](https://chirpy.cotes.page/posts/text-and-typography/) 并对照其 [GitHub 上的 Markdown 源文件](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/_posts/2019-08-08-text-and-typography.md) 最省事。
- 想**按字段写 Front Matter、配媒体与内嵌**，以官方 [Writing a New Post](https://chirpy.cotes.page/posts/write-a-new-post/) 为准，本帖已将其要点压缩为中文速查。
- 想**搭新站或升级**，以 [jekyll-theme-chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) 的 README 与 Release 说明为准；本帖只作本站使用的速查与中文导读。
