# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Bretz'selle (`bretzselle.org`) is a French bicycle repair association in Strasbourg. This is a Jekyll static site hosted on GitHub Pages, rebuilt from the original WordPress site after it was compromised. The site is maintained by non-technical volunteers.

## Commands

```sh
# Install dependencies (first time)
bundle install

# Local development server
bundle exec jekyll serve --livereload

# Build only
bundle exec jekyll build
```

## Architecture

**Jekyll + GitHub Pages.** No build pipeline needed — GitHub Pages builds the site automatically on push to main.

### Key editable files for non-technical editors

| File | Purpose |
|------|---------|
| `_data/hours.yml` | Workshop opening hours (displayed on homepage + footer) |
| `_data/contact.yml` | Address, phone, email |
| `_data/navigation.yml` | Site navigation structure |
| `_posts/YYYY-MM-DD-title.md` | News/events articles |

### Directory structure

- `_layouts/` — page templates: `home` (homepage), `page` (standard content pages), `post` (news articles), `posts` (news listing)
- `_includes/` — shared partials: `header.html` (nav), `footer.html`
- `_data/` — editable YAML data files
- `assets/css/main.css` — all styles in one file; uses CSS custom properties for theming
- `lassociation/`, `activites/`, `participer/` — content page directories matching nav structure

### Adding a news post

Create `_posts/YYYY-MM-DD-slug.md` with front matter:
```yaml
---
layout: post
title: "Titre de l'article"
date: 2025-06-15
categories: [événements]
image: /assets/images/mon-image.jpg  # optional
---
```

### Changing hours or contact info

Edit `_data/hours.yml` or `_data/contact.yml` — changes automatically propagate to the homepage and footer.

## Design

- Brand color: `--yellow: #f2c830` (CSS variable in `main.css`)
- Fonts: Montserrat (headings) + Open Sans (body) via Google Fonts
- No JavaScript framework — one small inline script for the mobile hamburger menu
- No CSS framework — custom CSS only
