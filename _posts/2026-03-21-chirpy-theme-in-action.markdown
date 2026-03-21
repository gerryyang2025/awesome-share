---
layout: post
title:  "Chirpy 主题使用指南"
date:   2026-03-21 12:00:00 +0800
categories: Tools
tags:
  - Jekyll
  - Chirpy
  - 博客

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

# 新建站点与本地预览

推荐使用官方维护的 Starter，减少手工对齐目录与配置的成本：

1. 使用 GitHub 上的 **[chirpy-starter](https://github.com/cotes2020/chirpy-starter)** 生成仓库（Use this template），或按该仓库 README 克隆后安装依赖。
2. 在项目根目录执行 `bundle install`，再执行 `bundle exec jekyll serve`（或本仓库提供的 `./optools start` 等脚本）本地预览。

已有 Jekyll 站点若要换成 Chirpy，需按主题 README 调整 `_config.yml`、目录结构（如 `_tabs`、资源路径）与插件列表；步骤以官方文档为准，升级大版本前请阅读主题的 **Release notes**。

# 文章 Front Matter

每篇文章顶部使用 YAML，常用字段如下（与官方演示文一致）：

{% highlight yaml %}
---
title: "文章标题"
description: "摘要，多用于 SEO 与列表展示"
date: 2026-03-21 12:00:00 +0800
categories: [大类, 子类]   # 或单个字符串
tags: [标签一, 标签二]
# 可选
author: 你的名字
pin: true                 # 置顶
math: true                # 本页启用 MathJax
mermaid: true             # 本页启用 Mermaid
image:
  path: /path/to/cover.png
  alt: 封面说明
---
{% endhighlight %}

- 仅当文中含 **数学公式** 时设 `math: true`；含 **` ```mermaid `** 代码块时设 `mermaid: true`，避免全站不必要的脚本加载。
- `categories`、`tags` 会参与归档与分类页（需主题与 `jekyll-archives` 等配置配合，与本仓库 `_config.yml` 中 `jekyll-archives` 段一致）。

# Markdown 与主题扩展

下列写法摘自主题官方演示，可直接复制到文章中试用（更多变体见 [Text and Typography 源码](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/_posts/2019-08-08-text-and-typography.md)）。

## 提示块（Prompt）

在引用块后接 Kramdown 属性，类型为 `tip` / `info` / `warning` / `danger`：

{% highlight markdown %}
> 这是一条提示。
{: .prompt-tip }

> 这是一条信息。
{: .prompt-info }

> 这是一条警告。
{: .prompt-warning }

> 这是一条危险/重要提醒。
{: .prompt-danger }
{% endhighlight %}

## 行内「文件路径」样式

{% highlight markdown %}
编辑 `config.yml`{: .filepath} 以修改站点配置。
{% endhighlight %}

## 代码块：语言高亮与文件名

普通围栏代码块会按 `_config.yml` 里 Kramdown / Rouge 设置显示行号。若要为块标题显示「文件名」，在代码块**后**一行使用 `file=`：

{% highlight markdown %}
```bash
echo "hello"
```
{: file='scripts/hello.sh'}
{% endhighlight %}

## 数学公式（需 `math: true`）

使用 `$$ ... $$` 或行内 `$ ... $`，与 MathJax 兼容的写法即可；公式编号与 `\eqref` 等用法见官方演示文。

## Mermaid（需 `mermaid: true`）

{% highlight markdown %}
```mermaid
flowchart LR
  A[开始] --> B[结束]
```
{% endhighlight %}

## 图片：宽度、对齐与明暗主题

主题为图片提供了 `{: ... }` 扩展属性，例如宽度、`.left` / `.right` 浮动、`.light` / `.dark` 仅在某主题下显示等，完整列表与示例仍以 [Text and Typography](https://chirpy.cotes.page/posts/text-and-typography/) 为准。

## 脚注

{% highlight markdown %}
正文中的引用[^fn1]。

[^fn1]: 脚注内容。
{% endhighlight %}

本仓库 `_config.yml` 中 `kramdown.footnote_backlink` 可自定义返回正文符号样式。

## 内嵌视频

主题提供 Liquid 片段，例如 YouTube（具体 `include` 路径以当前主题版本为准）：

{% highlight liquid %}
{% raw %}{% include embed/youtube.html id='视频ID' %}{% endraw %}
{% endhighlight %}

## 标题与目录

若不希望某标题出现在侧边目录中，可为该标题添加属性，例如：

{% highlight markdown %}
## 附录
{: data-toc-skip='' }
{% endhighlight %}

（与官方演示文中对标题的写法一致。）

# 站点级配置（`_config.yml`）

与本主题相关的常见项包括：

- **`theme: jekyll-theme-chirpy`**（或通过 `remote_theme` 引入）。
- **`toc`**：是否默认开启文章目录。
- **`theme_mode`**：浅色 / 深色 / 跟随系统（空字符串常表示跟随主题默认逻辑，以当前版本文档为准）。
- **`comments`**：Disqus、Utterances、giscus 等，填好对应字段后启用。
- **`analytics`**：各统计平台 `id` 或配置块。

修改主题默认值时，仍建议将自定义样式与脚本放在站点目录（如 `assets`、`_sass`）中**覆盖**主题文件，而不是直接改 gem 内文件，便于升级。

# 小结

- 想**一眼看完主题能力**，打开 [Text and Typography](https://chirpy.cotes.page/posts/text-and-typography/) 并对照其 [GitHub 上的 Markdown 源文件](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/_posts/2019-08-08-text-and-typography.md) 最省事。
- 想**搭新站或升级**，以 [jekyll-theme-chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) 的 README 与 Release 说明为准；本帖只作本站使用的速查与中文导读。
