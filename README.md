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

- **Requirements**: Ruby **>= 3.1** and Jekyll **~> 4.3** (Chirpy depends on Jekyll 4.3 and Ruby ~> 3.1).
- **Home**: `index.html` uses layout `home` (rendered by the theme).
- **Tabs**: Navigation pages are under `_tabs/` (Categories/Tags/Archives/About).
- **Permalinks**: Posts default to `/posts/:title/` (configured in `_config.yml`).

### Common deployment issue (Ruby too old)

If your server is using Ruby 2.x (e.g. Ruby 2.5), `bundle install` / `./optools start` will fail for Chirpy/Jekyll 4.x. Upgrade Ruby first, then reinstall gems.

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
# Clone the repository
git clone https://github.com/gerryyang2025/awesome-share.git
cd awesome-share

# Install dependencies
bundle install

# Start the development server
bundle exec jekyll serve
```

## Running the Blog

```bash
# Start the blog server
./optools start

# Stop the blog server
./optools stop
```

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


