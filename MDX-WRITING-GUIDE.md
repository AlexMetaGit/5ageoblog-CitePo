# 5AGEOBlog MDX 写作指南

> 本文档记录了 CitePo 博客的 MDX 写作规范和常见问题，确保新增文章不会重复犯错。

**最后更新**：2026-03-17
**维护者**：WuKong

---

## 🔴 核心规则

### 1. 组件不需要 import

**❌ 错误写法**：
```mdx
import { Callout, Badge } from '@components';
import { Callout } from '@site/src/components/Callout';
import { Badge } from '@site/src/components/Badge';
```

**✅ 正确写法**：
```mdx
<!-- 直接使用，无需 import -->
<Callout type="info">
  这是提示框
</Callout>

<Badge color="blue">标签</Badge>
```

**原因**：CitePo 的组件是全局注册的，自动可用，不需要手动导入。

---

### 2. Badge 组件使用 `color` 属性

**❌ 错误写法**：
```mdx
<Badge variant="blue">标签</Badge>
<Badge type="tip">高优先级</Badge>
<Badge type="info">中期策略</Badge>
```

**✅ 正确写法**：
```mdx
<Badge color="blue">蓝色标签</Badge>
<Badge color="green">绿色标签</Badge>
<Badge color="red">红色标签</Badge>
<Badge color="purple">紫色标签</Badge>
<Badge color="yellow">黄色标签</Badge>
<Badge color="orange">橙色标签</Badge>
<Badge color="gray">灰色标签</Badge>
```

**支持的属性**：
- `color`：颜色（gray, blue, green, yellow, orange, red, purple）
- `size`：尺寸（sm, md, lg）
- `shape`：形状（rounded, pill）
- `stroke`：描边变体（布尔值）
- `icon`：图标名称

**示例**：
```mdx
<Badge icon="star" color="purple" size="lg" shape="rounded">
  高级版
</Badge>
```

---

### 3. Accordion 组件使用正确的嵌套结构

**❌ 错误写法**：
```mdx
<Accordion>
  <AccordionItem title="问题 1">
    答案 1
  </AccordionItem>
  <AccordionItem title="问题 2">
    答案 2
  </AccordionItem>
</Accordion>
```

**✅ 正确写法**：
```mdx
<AccordionGroup>
  <Accordion title="问题 1">
    答案 1
  </Accordion>
  <Accordion title="问题 2">
    答案 2
  </Accordion>
</AccordionGroup>
```

**结构规则**：
- 外层必须是 `<AccordionGroup>`
- 内层是 `<Accordion>`，不是 `<AccordionItem>`
- 每项的标题用 `title` 属性

---

## 📋 可用组件清单

### Callout（提示框）

**类型**：`info`, `tip`, `warning`, `error`

**示例**：
```mdx
<Callout type="info">
  这是信息提示
</Callout>

<Callout type="tip">
  这是小贴士
</Callout>

<Callout type="warning">
  这是警告
</Callout>

<Callout type="error">
  这是错误提示
</Callout>
```

---

### Badge（徽章）

**示例**：
```mdx
<Badge color="blue">蓝色</Badge>
<Badge color="green" size="lg">大号绿色</Badge>
<Badge color="red" stroke>描边红色</Badge>
<Badge icon="star" color="purple">带图标</Badge>
```

---

### Card 和 CardGroup（卡片）

**示例**：
```mdx
<CardGroup cols={2}>
  <Card title="卡片 1" href="https://example.com" icon="pencil">
    卡片内容 1
  </Card>
  <Card title="卡片 2" href="https://example.com" icon="zap">
    卡片内容 2
  </Card>
</CardGroup>
```

**属性**：
- `title`：卡片标题
- `href`：链接地址
- `icon`：图标名称
- `cols`：列数（CardGroup）

---

### Accordion（手风琴）

**示例**：
```mdx
<AccordionGroup>
  <Accordion title="问题 1">
    答案 1
  </Accordion>
  <Accordion title="问题 2">
    答案 2
  </Accordion>
</AccordionGroup>
```

---

### Steps（步骤）

**示例**：
```mdx
<Steps>

### 第一步

第一步的内容

### 第二步

第二步的内容

</Steps>
```

**注意**：
- 步骤标题必须是 `###` 三级标题
- 每个步骤会自动编号

---

## 🎨 样式规范

### Frontmatter 必填字段

```yaml
---
title: 文章标题
description: 简短描述（100-150 字符，用于 SEO）
date: 2026-03-17
tags: [标签1, 标签2, 标签3]
authors: [WuKong]
draft: false
---
```

### 推荐的文章结构

```mdx
---
title: 文章标题
description: 简短描述
date: 2026-03-17
tags: [标签1, 标签2]
authors: [WuKong]
draft: false
---

# 文章标题

<Callout type="info">
  <strong>导读</strong>：文章简介
</Callout>

## 第一部分

内容...

## 第二部分

内容...

## 总结

总结内容...

---

**参考来源**：
- [来源 1](链接)
- [来源 2](链接)

---

**标签**：`#标签1` `#标签2`
```

---

## 🐛 常见问题

### Q1: 页面报错 "Cannot find module '@components'"

**原因**：使用了 import 语句

**解决**：删除所有 import 语句，组件自动可用

---

### Q2: Badge 不显示或样式错误

**原因**：使用了错误的属性名

**解决**：使用 `color` 而不是 `variant` 或 `type`

---

### Q3: Accordion 不折叠

**原因**：嵌套结构错误

**解决**：使用 `<AccordionGroup>` 包裹 `<Accordion>`

---

## 📚 参考资源

- [CitePo 官方文档](https://citepo.com/docs)
- [示例文章](./content/zh/hello-world.mdx) - 包含所有组件示例
- [Astro MDX 文档](https://docs.astro.build/en/guides/markdown-content/)

---

## 📝 检查清单

发布新文章前，请检查：

- [ ] 没有使用 import 语句
- [ ] Badge 使用 `color` 属性
- [ ] Accordion 使用 `<AccordionGroup>` 结构
- [ ] Frontmatter 包含所有必填字段
- [ ] 本地预览无误：`npx citepo dev`
- [ ] 构建成功：`npx citepo build`

---

**维护说明**：
- 如果发现新的问题或规范，请更新此文档
- 定期检查 CitePo 更新，了解组件变化
- 保持文档简洁实用，避免过度详细

**更新记录**：
- 2026-03-17：创建文档，记录 Badge、Accordion、import 相关问题
