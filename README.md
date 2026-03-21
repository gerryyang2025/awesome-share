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

The **site chrome** (top bar, sidebar, post layout, theme toggle) comes from the Chirpy gem. The **article body** is intentionally tuned to look like **[GitHub-style Markdown](https://github.com/github/markup)**: neutral text grays, blue links, light gray code block panels, 6px rounding on code UI, and matching dark-mode equivalents.

| Piece | Role |
| --- | --- |
| **Chirpy (gem)** | Global layout, typography baseline, TOC panel, `[data-theme="dark"]` / `.theme-dark` for dark mode. Version is pinned in `Gemfile` (currently **7.5.0**). |
| **`_includes/metadata-hook.html`** | Theme hook: injects the stylesheets and `code-copy.js` below (load order matters). |
| **`assets/css/markdown-extras.css`** | Main content layer: scoped to `.post-content`, `#post-content`, `.content`. Defines **`--md-*` CSS variables** (foreground, muted text, borders, canvas, link colors, inline-code background) for **light and dark**; vertical rhythm (`1rem` block spacing, `line-height: 1.65` on paragraphs); **h2** with bottom border; link underlines; footnotes, task lists, `details`/`summary`, `kbd`, `mark`, `hr`, images; **kramdown `{:toc}`** (`#markdown-toc`) — hidden when the theme TOC is on (`article[data-toc="true"]`), sticky side column on wide screens when per-post `toc: false`. |
| **`assets/css/blockquote.css`** | Blockquotes: left accent border, muted body color (uses `var(--md-fg-muted)` when available). |
| **`assets/css/inline-code.css`** | Backtick inline code: ~85% size, pill background, monospace stack; scoped with `#post-body` and post content selectors. |
| **`assets/css/code-copy-btn.css`** | `.highlight` container (border, radius, padding) and **copy** button position; uses `var(--md-*)` with hex fallbacks. |
| **`assets/css/rouge-highlight.css`** | Rouge token colors (reds/blues for keywords/strings, etc.) — **GitHub-flavored** palette. |
| **`assets/css/table.css`** | Chirpy wraps tables in **`.table-wrapper`**; rules align with the theme’s table markup, including striped rows and dark-mode `--tb-*` variables. |
| **`assets/js/code-copy.js`** | Copy-to-clipboard for code blocks (paired with `code-copy-btn.css`). |

**Changing the look later:** adjust the **`--md-*` blocks** at the top of `markdown-extras.css` (light + dark) so links, borders, and code surfaces stay consistent; then review `table.css` / `inline-code.css` for any hard-coded colors that should follow. Shell colors (sidebar, navbar) live in the theme’s SCSS unless you add `_sass` overrides.

**Unused asset:** `assets/css/home.css` defines classes like `.home-content` / `.category-grid` but nothing in the repo links it today (`index.html` only sets `layout: home`). Include it from a hook or layout if you adopt that markup.

- **Requirements**: Ruby **>= 3.1** and Jekyll **~> 4.3** (Chirpy depends on Jekyll 4.3 and Ruby ~> 3.1).
- **Home**: `index.html` uses layout `home` (rendered by the theme).
- **Tabs**: Navigation pages are under `_tabs/` (Categories, Tags, Archives, About). Edit `_tabs/about.md` for the About page.
- **Permalinks**: Posts use `/posts/:title/` (set in `_config.yml`).
- **404**: The 404 page is provided by the theme (no custom `404.html` in the repo).
- **Feed**: Atom feed is at `/feed.xml` (generated by `jekyll-feed`). The file `assets/feed.xml` overrides the theme asset so only the plugin writes to `/feed.xml`.
- **Contents (TOC)**: With `toc: true` in `_config.yml` (posts default to this in `defaults`), Chirpy shows the **Contents** panel on the **right** on large viewports and the mobile TOC control below that breakpoint—same idea as [Writing a New Post · Chirpy](https://chirpy.cotes.page/posts/write-a-new-post/). The stock theme’s [tocbot](https://github.com/tscanlin/tocbot) only scans **`h2`–`h4`** inside `.content`, so a body `#` heading never appeared in the panel; this repo **overrides** `assets/js/dist/post.min.js` so headings are **`h1`–`h4`** (the page title `<h1 data-toc-skip>` lives in `<header>`, not in `.content`, so it stays excluded). After upgrading `jekyll-theme-chirpy`, re-copy `post.min.js` from the new gem and re-apply that one-line `headingSelector` change, or diff against the theme. In-article `{:toc}` stays hidden when the theme TOC is on; use `toc: false` if you only want kramdown `{:toc}` (wide screens: right column in `assets/css/markdown-extras.css`).

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

### Code blocks: prefer `{% highlight %}`

To avoid code blocks rendering as a single line (a known issue with the theme/compress pipeline), use Jekyll’s **`{% highlight %}`** tag instead of Markdown fenced blocks (`` ``` ``).

- **Syntax**: `{% highlight lang %}` … `{% endhighlight %}` (e.g. `{% highlight bash %}`, `{% highlight yaml %}`, `{% highlight go %}`).
- **Line breaks**: Content between the tags is output as-is, so line breaks and formatting are preserved.
- **Rouge**: Syntax highlighting uses Rouge; supported language names match [Rouge lexers](https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers) (e.g. `bash`, `yaml`, `go`, `python`, `json`).
- **Liquid in code**: If the snippet contains `{{` or `{%`, wrap the block in `{% raw %}…{% endraw %}` or escape so Liquid does not interpret it.
- **Converting posts**: To convert existing `` ```lang … ``` `` blocks in a post to `{% highlight %}`, run:
  `ruby tools/convert_fenced_to_highlight.rb _posts/YYYY-MM-DD-post-name.markdown`

### Common deployment issue (Ruby too old)

If your server is using Ruby 2.x (e.g. Ruby 2.5), `bundle install` / `./optools start` will fail for Chirpy/Jekyll 4.x. The `optools` script can attempt an automatic fix (rbenv + Ruby 3.2) on Ubuntu; otherwise upgrade Ruby manually, then run `bundle install`.

## Optional enhancements

1. **Pagination** (optional) – With 200+ posts, add `jekyll-paginate` or `jekyll-paginate-v2` and paginate the 文章列表 section to improve load time and scrolling.
2. **Excerpts** – Set `show_excerpts: true` in `_config.yml` and add `excerpt` or `excerpt_separator` in posts to show short summaries in the list.
3. **Category pages** – Add a dedicated layout or collection for each category (e.g. `/categories/go/`) so "文章分类" can link to category pages instead of listing all posts on the index.
4. **Search** – Add client-side search (e.g. Simple Jekyll Search, Lunr) or a static JSON index for finding posts by title/category.
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
./optools help         # show help
```

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


