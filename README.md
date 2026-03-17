# 5AGEOBlog

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

# Build for production
npx citepo build

# Preview build output
npx serve dist
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

**⚠️ 重要**：请先阅读 [MDX-WRITING-GUIDE.md](./MDX-WRITING-GUIDE.md)，了解 CitePo 组件的正确用法。

**核心规则**：
- ❌ **不要使用 import 语句**（组件自动可用）
- ✅ Badge 使用 `color` 属性，不是 `variant` 或 `type`
- ✅ Accordion 使用 `<AccordionGroup>` 包裹 `<Accordion>`

## Configuration

Edit `blog.json` to customize your blog. See [CitePo Documentation](https://citepo.com/docs) for details.

## Custom Styles

Add custom CSS to `style.css`. These styles load after the theme and have higher priority.

## Learn More

- [CitePo Documentation](https://citepo.com/docs)
- [CitePo GitHub](https://github.com/LinklyAI/citepo-cli)
