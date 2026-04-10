# 午间博客写作指南

## 午间特色

- **侧重**：深度研究、数据分析、行业报告
- **字数**：800-1500字
- **语气**：专业、深入、有洞察力
- **素材优先**：GEO-AEO-NotebookLM 的研究报告和深度分析

## 知识库素材来源

### 1. GEO-AEO-Library（理论基础）
- 路径：`/Users/zz/Documents/Obsidian/Knowledge/GEO-AEO-Library/`
- 重点：
  - `04-Research/` - 研究框架
  - `05-Original-Report/` - 原始报告
  - `SUMMARY.md` - 资料库总结

### 2. GEO-AEO-NotebookLM（核心素材）
- 路径：`/Users/zz/Documents/Obsidian/Knowledge/GEO-AEO-NotebookLM/`
- 重点：
  - `2026-03-16-GEO-AEO-完整指南.md` - 完整指南
  - PDF研究报告和深度分析

### 3. GEO-AEO-Article（案例参考）
- 路径：`/Users/zz/Documents/Obsidian/Knowledge/GEO-AEO-Article/`
- 重点：实战经验和案例

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
- 使用 web_search 搜索"AI搜索趋势"、"跨境电商动态"等
- 选择与早间不同的话题

### 2. 读取知识库素材
- 从三个知识库获取深度素材
- 重点使用 NotebookLM 的研究报告

### 3. 撰写博客文章
- 文件名：`~/5ageoblog/content/zh/YYYY-MM-DD-midday-topic.mdx`
- 结构：热点引入 → 深度分析 → 数据支撑 → 行动建议
- 引用规范：标注来源（如 [来源: GEO-AEO-NotebookLM]）

### 4. MDX 语法检查
```bash
# 检查 Badge 颜色
grep -n 'Badge color="[^"]*"' ~/5ageoblog/content/zh/YYYY-MM-DD-midday-topic.mdx | grep -v 'color="blue\|color="green\|color="red\|color="yellow"' && echo "❌ Badge 颜色错误" && exit 1

# 检查数字标签
grep -n '<[0-9]' ~/5ageoblog/content/zh/YYYY-MM-DD-midday-topic.mdx && echo "❌ 数字标签错误" && exit 1
```

### 5. 本地验证
```bash
cd ~/5ageoblog
pkill -f "citepo dev"  # 停止旧服务器
npm exec citepo dev &    # 启动新服务器
sleep 10
curl -s http://localhost:4321/YYYY-MM-DD-midday-topic | head -10
```

### 6. Git 提交推送
```bash
cd ~/5ageoblog
git add content/zh/YYYY-MM-DD-midday-topic.mdx
git commit -m "Add blog: 文章标题"
git push
```

### 7. 构建验证
```bash
cd ~/5ageoblog
npm exec citepo build
# 验证构建成功，无错误
```

## 目标人群

- 传统 SEO 从业者
- 品牌市场部人员
- 跨境电商独立站从业者

## 注意事项

- 确保代理环境变量已设置（`proxyon`）
- 如果热点话题与 GEO/AEO 无关，选择知识库中的核心话题
- 与早间、晚间文章保持话题多样性
- 优先使用 NotebookLM 的研究报告，确保内容深度
