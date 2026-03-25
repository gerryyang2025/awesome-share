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

- `_posts/` - Blog posts in Markdown with YAML front matter (title, date, layout, categories, tags)
- `_config.yml` - Jekyll configuration (theme: **jekyll-theme-chirpy**, plugins, archives)
- `index.html` - Home page (`layout: home` from the theme)
- `_tabs/` - Nav tabs (About, Categories, Tags, Archives)
- `Gemfile` - Ruby dependencies (Jekyll ~> 4.3, **jekyll-theme-chirpy** 7.5.0, kramdown-parser-gfm, jekyll-feed, jekyll-sitemap, jekyll-archives)
- `_includes/metadata-hook.html` - `post-content-bundle.css` only (regenerate bundle: `./tools/bundle-post-content-css.sh`)
- `_includes/js-selector.html` - Overrides theme; removes unused SimpleJekyllSearch from script bundle (site uses `blog-search.js`)

## Key Configuration

The `_config.yml` sets:

- Site title, description, `url` / `share_base_url`
- Markdown: kramdown with GFM input, Rouge highlighting (`css_class: highlight`)
- Plugins: jekyll-feed, jekyll-seo-tag, jekyll-sitemap, jekyll-archives
- Development server: see `_config.yml` (`port`, `host`; default via **optools** is port **8080**)
