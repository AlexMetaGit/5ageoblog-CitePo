# My Blog

A blog powered by [CitePo](https://citepo.com).

## Project Structure

```
├── blog.json        # Blog configuration
├── style.css        # Custom styles (overrides theme)
├── content/         # Blog posts (MDX)
├── asset/           # Static assets
│   └── images/      # Image files
└── .gitignore
```

## Quick Start

```bash
# Start development server
npx citepo dev
```

## Writing Posts

Create `.mdx` files in the `content/` directory with frontmatter:

```mdx
---
title: My First Post
description: A short description
date: 2025-01-01
tags: [blog, intro]
---

Your content here...
```

## Configuration

Edit `blog.json` to customize your blog. See [CitePo Documentation](https://citepo.com/docs) for details.

## Custom Styles

Add custom CSS to `style.css`. These styles load after the theme and have higher priority.

## Learn More

- [CitePo Documentation](https://citepo.com/docs)
- [CitePo GitHub](https://github.com/LinklyAI/citepo-cli)
