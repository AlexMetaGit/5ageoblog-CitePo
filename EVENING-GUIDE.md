# 晚间博客写作指南

## 晚间特色

- **侧重**：实战指南、工具评测、案例复盘
- **字数**：800-1200字
- **语气**：轻松、实践导向、可操作
- **素材优先**：GEO-AEO-Article 的实战经验和案例

## 知识库素材来源

### 1. GEO-AEO-Article（核心素材）
- 路径：`/Users/zz/Documents/Obsidian/Knowledge/GEO-AEO-Article/`
- 重点：实战经验和案例分析

### 2. GEO-AEO-Library（理论支撑）
- 路径：`/Users/zz/Documents/Obsidian/Knowledge/GEO-AEO-Library/`
- 重点：`05-Original-Report/` 和 `SUMMARY.md`

### 3. GEO-AEO-NotebookLM（补充素材）
- 路径：`/Users/zz/Documents/Obsidian/Knowledge/GEO-AEO-NotebookLM/`
- 重点：研究报告中的实用技巧

## 写作规范

### MDX 组件使用
- **无需 import** - 直接使用组件
- **Badge 颜色**：仅支持 blue, green, red, yellow
- **Accordion 结构**：
  ```mdx
  <AccordionGroup>
    <Accordion title="标题">内容</Accordion>
  </AccordionGroup>
  ```
- **避免数字标签**：使用 `少于 1K` 而非 `<1K`

### Frontmatter 模板
```yaml
---
title: 文章标题
description: SEO描述（100-150字符）
date: YYYY-MM-DD
tags: [GEO, AEO, AI搜索, 相关标签]
authors: [WuKong]
draft: false
---
```

## 发布流程

### 1. 搜索热点话题
- 使用 web_search 搜索实战技巧、工具评测等
- 选择与早间、午间不同的话题

### 2. 读取知识库素材
- 重点使用 GEO-AEO-Article 的实战案例
- 补充理论支撑

### 3. 撰写博客文章
- 文件名：`~/5ageoblog/content/zh/YYYY-MM-DD-evening-topic.mdx`
- 结构：实战场景 → 操作步骤 → 工具推荐 → 效果验证

### 4. MDX 语法检查
```bash
grep -n 'Badge color="[^"]*"' ~/5ageoblog/content/zh/YYYY-MM-DD-evening-topic.mdx | grep -v 'color="blue\|color="green\|color="red\|color="yellow"' && echo "❌ Badge 颜色错误" && exit 1
grep -n '<[0-9]' ~/5ageoblog/content/zh/YYYY-MM-DD-evening-topic.mdx && echo "❌ 数字标签错误" && exit 1
```

### 5. 本地验证与推送
```bash
cd ~/5ageoblog
pkill -f "citepo dev" && npm exec citepo dev &
sleep 10
curl -s http://localhost:4321/YYYY-MM-DD-evening-topic | head -10
git add content/zh/YYYY-MM-DD-evening-topic.mdx
git commit -m "Add blog: 文章标题" && git push
npm exec citepo build
```

## 目标人群

- 传统 SEO 从业者
- 品牌市场部人员
- 跨境电商独立站从业者

## 与早间、午间的区别

| 时段 | 侧重点 | 风格 | 主要素材 |
|------|--------|------|----------|
| 早间 | 标准解读、工具推荐 | 信息密集 | Library |
| 午间 | 深度研究、数据分析 | 专业深入 | NotebookLM |
| 晚间 | 实战指南、案例复盘 | 轻松实用 | Article |
