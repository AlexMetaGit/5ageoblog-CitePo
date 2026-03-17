#!/bin/bash
# CitePo MDX 文章规范检查脚本
# 使用：./check-mdx.sh content/zh/new-article.mdx

set -e

ARTICLE="$1"

if [ -z "$ARTICLE" ]; then
    echo "❌ 用法：$0 <文章路径>"
    echo "示例：$0 content/zh/2026-03-17-new-article.mdx"
    exit 1
fi

if [ ! -f "$ARTICLE" ]; then
    echo "❌ 文件不存在：$ARTICLE"
    exit 1
fi

ERRORS=0

echo "🔍 检查文章：$ARTICLE"
echo ""

# 1. 检查 import 语句
if grep -q "^import.*from.*components" "$ARTICLE"; then
    echo "❌ 错误：发现 import 语句（CitePo 组件不需要 import）"
    grep -n "^import.*from.*components" "$ARTICLE"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ 无 import 语句"
fi

# 2. 检查 Badge 的错误属性
if grep -q "<Badge.*variant=" "$ARTICLE"; then
    echo "❌ 错误：Badge 使用了 variant 属性（应使用 color）"
    grep -n "<Badge.*variant=" "$ARTICLE"
    ERRORS=$((ERRORS + 1))
fi

if grep -q "<Badge.*type=" "$ARTICLE"; then
    echo "❌ 错误：Badge 使用了 type 属性（应使用 color）"
    grep -n "<Badge.*type=" "$ARTICLE"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -eq 0 ]; then
    echo "✅ Badge 属性正确"
fi

# 3. 检查 AccordionItem
if grep -q "<AccordionItem" "$ARTICLE"; then
    echo "❌ 错误：使用了 AccordionItem（应使用 Accordion）"
    grep -n "<AccordionItem" "$ARTICLE"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ Accordion 结构正确"
fi

# 4. 检查必需的 frontmatter 字段
REQUIRED_FIELDS=("title" "description" "date")
for field in "${REQUIRED_FIELDS[@]}"; do
    if ! grep -q "^$field:" "$ARTICLE"; then
        echo "❌ 缺少必需字段：$field"
        ERRORS=$((ERRORS + 1))
    fi
done

if [ $ERRORS -eq 0 ]; then
    echo "✅ Frontmatter 完整"
fi

echo ""
echo "================================"

if [ $ERRORS -eq 0 ]; then
    echo "✅ 检查通过！文章符合规范"
    exit 0
else
    echo "❌ 发现 $ERRORS 个问题"
    echo ""
    echo "📖 参考：~/5ageoblog/MDX-WRITING-GUIDE.md"
    echo "📝 模板：~/5ageoblog/content/zh/.template.mdx"
    exit 1
fi
