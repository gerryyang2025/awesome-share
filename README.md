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



# Homepage (Index) Layout

The blog homepage is built from `index.md` with layout `home`. Current structure:

- **文章分类** – Posts grouped by category in a card grid; each card shows category name and post links.
- **文章列表** – Single chronological list of all posts with date and title (no duplicate "Posts" block from the theme).

Custom layout and styles:

- `_layouts/home.html` – Overrides Minima’s home layout so only the content from `index.md` is shown (theme’s default "Posts" section is removed to avoid duplication).
- `assets/css/home.css` – Home-only styles: section titles, category grid, post list with date + link, responsive behavior.

## Further optimization suggestions

1. **Pagination** – With 200+ posts, add `jekyll-paginate` or `jekyll-paginate-v2` and paginate the 文章列表 section to improve load time and scrolling.
2. **Excerpts** – Set `show_excerpts: true` in `_config.yml` and add `excerpt` or `excerpt_separator` in posts to show short summaries in the list.
3. **Category pages** – Add a dedicated layout or collection for each category (e.g. `/categories/go/`) so "文章分类" can link to category pages instead of listing all posts on the index.
4. **Search** – Add client-side search (e.g. Simple Jekyll Search, Lunr) or a static JSON index for finding posts by title/category.
5. **Theme customization** – To change global colors/fonts, copy Minima’s `_sass/minima.scss` and `assets/main.scss` into the repo and adjust variables; keep `assets/css/home.css` for index-only tweaks.
6. **RSS** – The theme’s RSS link is removed from the home layout; ensure `jekyll-feed` is used and add an RSS link in `_includes/footer.html` or the header if desired.
7. **Performance** – Lazy-load or limit the number of posts in the initial 文章列表 (e.g. latest 20), with a “View all” link to a full archive page.

# 🚀 Getting Started

## Prerequisites

- Ruby (for Jekyll)
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
./run.sh

# Stop the blog server
./stop.sh
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

*Built with ❤️ using Jekyll and the Minima theme*


