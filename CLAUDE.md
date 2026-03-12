# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Jekyll-powered blog (Gerry's blog) containing technical tutorials, English learning resources, and life reflections. Posts follow the naming convention `YYYY-MM-DD-title.markdown` in the `_posts/` directory.

## Commands

```bash
# Install dependencies
bundle install

# Start development server
./optools start
# Or directly: bundle exec jekyll serve

# Stop the server
./optools stop
```

## Blog Structure

- `_posts/` - Blog posts in Markdown with YAML front matter (title, date, layout, categories)
- `_config.yml` - Jekyll configuration (title, URL, plugins, theme: minima)
- `index.md` - Home page listing posts by category
- `Gemfile` - Ruby dependencies (jekyll ~> 3.8.3, minima ~> 2.0, jekyll-feed)
- `about.md` - About page

## Key Configuration

The `_config.yml` sets:
- Site title, author, description
- URL: http://gerryyang.com
- Markdown processor: kramdown
- Plugins: jekyll-feed, jekyll-seo-tag
- Development server runs on port 80 with IP 172.19.0.16
