# Gerry's Blog

> 🏗️ Jekyll-powered knowledge repository | 📝 Dev tutorials • 🎓 English learning • ✨ Life logs

This is a personal blog built with [Jekyll](https://jekyllrb.com/), serving as my curated knowledge repository. I document technical insights from software development, share practical strategies for English language learning, and reflect on meaningful life experiences. Through concise articles and tutorials, I aim to solidify my understanding while offering value to fellow developers, language learners, and curious minds exploring the intersection of technology and personal growth.

# Blog Philosophy

> "他山之石，可以攻玉" (Stones from other hills may serve to polish the jade of this one)

This ancient Chinese proverb reflects my approach to learning and sharing knowledge. Every article, tutorial, and insight shared here is a stone that has helped polish my understanding, and I hope they can serve the same purpose for others.


# Content Categories

## Learning & Life
- **English Learning** - Language learning strategies and resources
- **Career Development** - Professional growth and workplace insights
- **Reading Notes** - Book summaries and reflections
- **Personal Growth** - Life experiences and learning journeys

## Programming & Development
- **C/C++** - Deep dives into C++ features, best practices, memory management, templates, smart pointers, and performance optimization
- **GoLang** - Go programming language tutorials, concurrency patterns, and framework usage
- **Python** - Python development and scripting
- **JavaScript/Web** - Frontend development, Vue.js, and web technologies
- **Lua** - Lua programming and scripting
- **Assembly** - Low-level programming and assembly language
- **Data Structures & Algorithms** - Computer science fundamentals

## Tools & Technologies
- **Development Tools** - VS Code, Git, CMake, Bazel, Make, and various development utilities
- **Static Analysis** - Cppcheck, AddressSanitizer, Valgrind, and code quality tools
- **Debugging** - GDB, core dumps, and debugging techniques
- **Performance** - Linux performance analysis, profiling, and optimization
- **Build Systems** - GCC/Clang compilation, optimization techniques

## Cloud Native & DevOps
- **Docker & Kubernetes** - Containerization and orchestration
- **Istio & Microservices** - Service mesh and microservice architecture
- **Monitoring** - Prometheus, Grafana, Telegraf, and observability
- **Infrastructure** - Ansible, Helm, and infrastructure as code

## Databases & Storage
- **MySQL** - Database management and optimization
- **Redis** - In-memory data structures and caching
- **ClickHouse** - Column-oriented database
- **InfluxDB** - Time series database
- **Elasticsearch** - Search and analytics engine

## Networking & Protocols
- **TCP/IP** - Network programming and protocols
- **HTTP** - Web protocols and APIs
- **TLS/SSL** - Security and encryption
- **DNS** - Domain name system

## Machine Learning & AI
- **ML Tools** - Claude Code, DeepSeek, and AI development tools
- **AI Applications** - Practical machine learning implementations



# Theme: Chirpy

This site uses [jekyll-theme-chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) (see [Jekyll docs: overriding theme defaults](https://jekyllrb.com/docs/themes/#overriding-theme-defaults)).

### Style stack (Chirpy + custom CSS)

The **site chrome** (top bar, sidebar, post layout, theme toggle) and **syntax-highlighted code blocks** (Rouge markup, line numbers, language/filename header, copy control) come from the **Chirpy** gem. The **article body** adds **[GitHub-style Markdown](https://github.com/github/markup)**-like prose: neutral text grays, blue links, 6px rounding on common UI, and matching dark-mode variables where noted below.

| Piece | Role |
| --- | --- |
| **Chirpy (gem)** | Global layout, typography baseline, TOC panel, code-block chrome and Rouge styling, `[data-theme="dark"]` / `.theme-dark` for dark mode. Version is pinned in `Gemfile` (currently **7.5.0**). |
| **`_includes/metadata-hook.html`** | Theme hook: loads **`post-content-bundle.css`** (**one runtime request**). Regenerate the bundle after editing any bundled source: **`./tools/bundle-post-content-css.sh`**. |
| **`assets/css/post-content-bundle.css`** | Generated file — do not hand-edit; order: **markdown-extras → blockquote → table → inline-code**. |
| **`assets/css/markdown-extras.css`** | Main content layer: scoped to `.post-content`, `#post-content`, `.content`. Defines **`--md-*` CSS variables** (foreground, muted text, borders, canvas, link colors, inline-code background) for **light and dark**; vertical rhythm (`1rem` block spacing, `line-height: 1.65` on paragraphs); **h2** with bottom border; link underlines; footnotes, task lists, `details`/`summary`, `kbd`, `mark`, `hr`, images; **kramdown `{:toc}`** (`#markdown-toc`) — hidden when the theme TOC is on (`article[data-toc="true"]`), sticky side column on wide screens when per-post `toc: false`. |
| **`assets/css/blockquote.css`** | Blockquotes: left accent border, muted body color (uses `var(--md-fg-muted)` when available). |
| **`assets/css/inline-code.css`** | Inline `` `code` ``: **`.content code`** (covers `p`/`li`/headings, not only direct children of `.content`), Chirpy **`var(--code-color)`** / **`var(--inline-code-bg)`** with v7.5 **fallbacks**; **`pre` / `.highlight code`** reset so block Rouge output stays on the theme’s block styles. Blockquote: **`color: inherit`** on `:not(pre) > code`. |
| **`assets/css/table.css`** | Chirpy wraps tables in **`.table-wrapper`**; rules align with the theme’s table markup, including striped rows and dark-mode `--tb-*` variables. |

**Changing the look later:** edit the source files under `assets/css/` (same order as the bundle), then run **`./tools/bundle-post-content-css.sh`** so **`post-content-bundle.css`** picks up changes. Prefer adjusting **`--md-*`** at the top of `markdown-extras.css` first. Shell colors (sidebar, navbar) and code-block palettes live in the theme’s SCSS unless you add `_sass` overrides.

- **Requirements**: Ruby **>= 3.1** and Jekyll **~> 4.3** (Chirpy depends on Jekyll 4.3 and Ruby ~> 3.1).
- **Home**: `index.html` uses layout `home` (rendered by the theme).
- **Tabs**: Navigation pages are under `_tabs/` (Categories, Tags, Archives, About). Edit `_tabs/about.md` for the About page.
- **Categories layout**: `_layouts/categories.html` overrides the theme for **leaf categories** (no sub-categories). In Chirpy, **`.category-trigger`** is only for the real expand control (`fa-angle-down`, wired by `category-collapse.js` to `.collapse`); stock HTML reused a **disabled** chevron on leaves, which reads as a broken button. This site uses an empty **`.category-leaf-spacer`** (same **1.7rem** square as in [`_categories.scss`](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/_sass/pages/_categories.scss)) so rows align without implying interaction. Diff against the gem when upgrading Chirpy.
- **Permalinks**: Posts use `/posts/:title/` (set in `_config.yml`).
- **404**: The 404 page is provided by the theme (no custom `404.html` in the repo).
- **Feed**: Atom feed is at `/feed.xml` (generated by `jekyll-feed`). The file `assets/feed.xml` overrides the theme asset so only the plugin writes to `/feed.xml`.
- **Contents (TOC)**: With `toc: true` in `_config.yml` (posts default to this in `defaults`), Chirpy shows the **Contents** panel on the **right** on large viewports and the mobile TOC control below that breakpoint—same idea as [Writing a New Post · Chirpy](https://chirpy.cotes.page/posts/write-a-new-post/). The stock theme’s [tocbot](https://github.com/tscanlin/tocbot) only scans **`h2`–`h4`** inside `.content`, so a body `#` heading never appeared in the panel; this repo **overrides** `assets/js/dist/post.min.js` so headings are **`h1`–`h4`** (the page title `<h1 data-toc-skip>` lives in `<header>`, not in `.content`, so it stays excluded). After upgrading `jekyll-theme-chirpy`, re-copy `post.min.js` from the new gem and re-apply that one-line `headingSelector` change, or diff against the theme. In-article `{:toc}` stays hidden when the theme TOC is on; use `toc: false` if you only want kramdown `{:toc}` (wide screens: right column in `assets/css/markdown-extras.css`).

### Search (top-right panel)

Chirpy’s [demo site](https://chirpy.cotes.page/) uses the same panel markup and loads **`/assets/js/data/search.json`**. Upstream wires **[SimpleJekyllSearch](https://github.com/christian-fei/Simple-Jekyll-Search)** (no debounce, default **`limit: 10`**, results in post order), which caused **input lag** on large sites (full-text `indexOf` on every keystroke) and **buried title matches** (e.g. “CPP Lab” under many `content` hits such as `cpp` + *label*).

This repo instead uses **`assets/js/blog-search.js`** from **`_includes/search-loader.html`**: **~280 ms debounce**, **one `fetch`** of the JSON, **`content` truncated to 5000 characters** per post in **`assets/js/data/search.json`** (Liquid + front matter, overrides the theme’s static file). After load, each row is **indexed once** (lowercased title/body fields + `Date` ms); a **generation counter** drops stale `fetch` callbacks. Matching keeps the same rule as SimpleJekyllSearch (**all query words must appear in the same field**), then **sorts by relevance** (title-first); ties by **newer `date`**. **`_includes/js-selector.html`** overrides the theme and **drops `simple-jekyll-search` from the script list** so it is **not downloaded or parsed** (still diff this file when upgrading Chirpy). After upgrading Chirpy, diff **`search-loader.html`** too; keep **`layout: null`** on `assets/js/data/search.json` so JSON is not passed through HTML compress.

### Using the Tags tab

`_tabs/tags.md` defines the **Tags** tab in the nav. It uses Chirpy’s `layout: tags`, which shows a tags index (all tags and their post counts). Clicking a tag goes to `/tags/<tag-name>/` (generated by `jekyll-archives`).

**To use tags on posts:** add a `tags` field in the front matter of each post. Tags are separate from categories (you can use both).

**Example (post front matter):**

```yaml
---
layout: post
title: "Your Post Title"
date: 2025-01-15 12:00:00 +0800
categories: [ML]
tags: [prompt, LLM, tutorial]
---
```

- **Tags index**: Visit the **Tags** tab (or `/tags/`) to see all tags.
- **Tag page**: `/tags/prompt/` lists all posts with tag `prompt`.
- **Multiple tags**: Use a list, e.g. `tags: [Go, Kubernetes, tutorial]`. Tags have been added to all posts via `tools/add_tags_to_posts.rb`; see **[tools/README.md](tools/README.md)** for usage and options.

### Code blocks (Chirpy / kramdown)

Per [Writing a New Post — Code Block](https://chirpy.cotes.page/posts/write-a-new-post/), **the Jekyll tag `{% highlight %}` is not compatible with this theme**. Use **Markdown fenced blocks** (`` ```language ``) so Rouge, line numbers, optional filename label, and the theme’s copy control work as intended.

- **Syntax**: open with a line of three backticks plus the lexer name (e.g. `bash`, `yaml`, `go`, `python`); close with a line of three backticks only. Lexers follow [Rouge](https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers).
- **Line numbers**: By default, kramdown shows line numbers for most languages (`_config.yml` → `kramdown.block.line_numbers`). To hide them on a block, add a line after the closing fence: `{: .nolineno }` (see Chirpy docs).
- **Filename label**: After the closing fence, use e.g. `{: file="path/to/file.sh" }`.
- **Liquid in code**: If the snippet contains `{{` or `{%`, wrap the fence (and both lines of backticks) in `{% raw %}…{% endraw %}`, or set `render_with_liquid: false` in the post’s front matter (Jekyll 4+).
- **Legacy migration**: Older posts that used `{% highlight %}` were converted with `ruby tools/convert_highlight_to_fenced.rb _posts` (or a single file path). **`compress_html`** in `_config.yml` is already disabled for `development` and `production`, so fenced blocks keep newlines without needing Liquid `highlight` tags.

### Common deployment issue (Ruby too old)

If your server is using Ruby 2.x (e.g. Ruby 2.5), `bundle install` / `./optools start` will fail for Chirpy/Jekyll 4.x. On **Ubuntu**, run **`AUTO_FIX=1 ./optools ruby-upgrade`** (or rely on **`./optools check`** / **`start`** with **`AUTO_FIX=1`**, the default) to install **rbenv**, Ruby **`RBENV_RUBY_VERSION`** (default **3.2.3**), **bundler**, and **bundle install**. Use **`./optools ruby-check`** if `bundle` reports **GemNotFoundException** for bundler. On other OSes, upgrade Ruby manually, then run **`bundle install`**.

## Optional enhancements

1. **Pagination** (optional) – With 200+ posts, add `jekyll-paginate` or `jekyll-paginate-v2` and paginate the 文章列表 section to improve load time and scrolling.
2. **Excerpts** – Set `show_excerpts: true` in `_config.yml` and add `excerpt` or `excerpt_separator` in posts to show short summaries in the list.
3. **Category pages** – Add a dedicated layout or collection for each category (e.g. `/categories/go/`) so "文章分类" can link to category pages instead of listing all posts on the index.
4. **Search** – Implemented with **`assets/js/blog-search.js`** (debounced, ranked); see **Search** under Theme: Chirpy. Optional: tune `debounceMs`, `maxResults`, or `truncate` in `assets/js/data/search.json`.
5. **Theme customization** – Override theme files by adding the same paths under `_layouts`, `_includes`, `_sass`, or `assets` (Jekyll will use your site files before the theme gem).
6. **RSS** – Ensure `jekyll-feed` is enabled (already in `_config.yml`) and link the feed in the theme UI if needed.
7. **Performance** – Lazy-load or limit the number of posts in the initial list (e.g. latest 20), with a “View all” link to a full archive page.

# 🚀 Getting Started

## Prerequisites

- Ruby **3.1+** (required for Chirpy / Jekyll 4.3)
- Bundler
- Git

## Installation & Setup

```bash
git clone https://github.com/gerryyang2025/awesome-share.git
cd awesome-share

# Install dependencies (Ruby 3.1+ required)
bundle install

# Optional: check environment (Ruby, Bundler, gems); optools can auto-fix Ruby via rbenv on Ubuntu
./optools check

# Run the blog (see "Running the Blog" below)
./optools start
```

## Running the Blog

Use the **optools** script for environment checks, start/stop, and status:

```bash
./optools              # show help (no subcommand)
./optools start        # start Jekyll in background (port 8080)
./optools stop         # stop Jekyll
./optools restart      # stop then start
./optools status       # show if running and last log lines
./optools check        # check Ruby/Bundler/gems only (no start)
./optools ruby-check   # print Ruby/Bundler paths and versions (diagnostics)
./optools ruby-upgrade # Ubuntu: rbenv + Ruby (RBENV_RUBY_VERSION), bundler, bundle install (+ ~/.bashrc rbenv block)
./optools shell-init   # append rbenv to ~/.bashrc if missing (then: source ~/.bashrc)
./optools liquid-check # Liquid syntax check for all _posts (see tools/check_liquid_posts.rb)
./optools run -- CMD   # run CMD with rbenv first (alternative to liquid-check / manual bundle exec)
./optools help         # show help
```

**注意事项（optools）**

- **统一入口**：与环境、Ruby、Bundler、Jekyll 相关的**常用命令**（启停服务、依赖检查、Liquid 检查、在正确 Ruby 下执行 `bundle exec` 等）请尽量通过 **`./optools <子命令>`** 完成；脚本内会加载 rbenv（若已安装），与 **`./optools start`** 使用同一套 gem，减少「终端里 `ruby` / `bundle` 仍指向系统旧版」的问题。
- **扩充约定**：在 `tools/` 或其它目录新增**需要经常手动执行**的维护脚本时，请**同时**在 **`optools`** 中增加对应子命令，并更新 **`./optools help`** 与本节命令列表，避免 README、`tools/README` 与口头约定各自一套命令。
- **为准**：子命令以 **`./optools help`** 为准；若与上表不一致，以脚本为准，并请将 README 改到一致。

- The dev server listens on **port 8080** by default (`_config.yml`). For debugging (e.g. Liquid/build errors), set `DEBUG=1` to append `--trace` to the serve command: `DEBUG=1 ./optools start`, then inspect `run.log` (or `tail -f run.log`).

# 📊 Blog Statistics

- **Total Posts**: 200+ technical articles and tutorials
- **Categories**: 20+ different technology and learning categories
- **Time Span**: 2018 - Present
- **Languages**: English and Chinese content


# 🔗 Quick Links

- **GitHub**: [@gerryyang](https://github.com/gerryyang2025)
- **CSDN Blog**: [delphiwcdj](https://blog.csdn.net/delphiwcdj)



---

*Built with ❤️ using Jekyll and the Chirpy theme*


