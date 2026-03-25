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

# Ubuntu: Ruby/Bundler diagnostics and rbenv upgrade path
# ./optools ruby-check
# AUTO_FIX=1 ./optools ruby-upgrade

# Liquid parse check for all posts (before/without full jekyll build)
# ./optools liquid-check
# ./optools liquid-check --verbose
# ./optools liquid-check --encoding-report
```

## Blog Structure

- `_posts/` - Blog posts in Markdown with YAML front matter (title, date, layout, categories, tags)
- `_config.yml` - Jekyll configuration (theme: **jekyll-theme-chirpy**, plugins, archives)
- `index.html` - Home page (`layout: home` from the theme)
- `_tabs/` - Nav tabs (About, Categories, Tags, Archives)
- `Gemfile` - Ruby dependencies (Jekyll ~> 4.3, **jekyll-theme-chirpy** 7.5.0, kramdown-parser-gfm, jekyll-feed, jekyll-sitemap, jekyll-archives)
- `assets/css/jekyll-theme-chirpy.scss` - official Chirpy custom entry: `@use 'main'` / `main.bundle`, then `@use 'post-content-bundle' as *`
- `_sass/_post-content-bundle.scss` - generated from `assets/css/*.css` (run `./tools/bundle-post-content-css.sh`)
- `_includes/metadata-hook.html` - optional head hook (post styles compile via `jekyll-theme-chirpy.scss`, not a separate `<link>`)
- `_includes/js-selector.html` - Overrides theme; removes unused SimpleJekyllSearch from script bundle (site uses `blog-search.js`)

## Key Configuration

The `_config.yml` sets:

- Site title, description, `url` / `share_base_url`
- Markdown: kramdown with GFM input, Rouge highlighting (`css_class: highlight`)
- Plugins: jekyll-feed, jekyll-seo-tag, jekyll-sitemap, jekyll-archives
- Development server: see `_config.yml` (`port`, `host`; default via **optools** is port **8080**)
