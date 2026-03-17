#!/bin/bash
# 5AGEOBlog 新增博客完整流程
# 使用：./new-blog.sh <文章文件名>
# 示例：./new-blog.sh 2026-03-18-new-article.mdx

set -e

BLOG_FILE="$1"
BLOG_DIR="$HOME/5ageoblog"
CONTENT_DIR="$BLOG_DIR/content/zh"

if [ -z "$BLOG_FILE" ]; then
    echo "❌ 用法：$0 <文章文件名>"
    echo "示例：$0 2026-03-18-new-article.mdx"
    exit 1
fi

FULL_PATH="$CONTENT_DIR/$BLOG_FILE"

if [ ! -f "$FULL_PATH" ]; then
    echo "❌ 文件不存在：$FULL_PATH"
    echo ""
    echo "📝 创建新文章步骤："
    echo "1. 复制模板：cp $CONTENT_DIR/.template.mdx $FULL_PATH"
    echo "2. 编辑文章：vim $FULL_PATH"
    echo "3. 运行检查：$0 $BLOG_FILE"
    exit 1
fi

echo "========================================"
echo "📝 5AGEOBlog 新增博客流程"
echo "========================================"
echo ""

# 步骤 1：检查文档规范
echo "🔍 步骤 1/5：检查文档规范..."
if ! "$BLOG_DIR/scripts/check-mdx.sh" "$FULL_PATH"; then
    echo ""
    echo "❌ 文档规范检查失败！"
    echo "请根据上述错误提示修改文章。"
    echo ""
    echo "📖 参考：$BLOG_DIR/MDX-WRITING-GUIDE.md"
    exit 1
fi
echo "✅ 文档规范检查通过"
echo ""

# 步骤 2：启动本地开发服务器
echo "🚀 步骤 2/5：启动本地开发服务器..."
if pgrep -f "citepo dev" > /dev/null; then
    echo "✅ 开发服务器已在运行"
else
    echo "正在启动开发服务器..."
    cd "$BLOG_DIR"
    npx citepo dev > /tmp/citepo-dev.log 2>&1 &
    sleep 5
    
    if ! pgrep -f "citepo dev" > /dev/null; then
        echo "❌ 开发服务器启动失败"
        cat /tmp/citepo-dev.log
        exit 1
    fi
    echo "✅ 开发服务器已启动"
fi
echo ""

# 步骤 3：提取文章 slug
echo "📄 步骤 3/5：提取文章信息..."
SLUG=$(basename "$BLOG_FILE" .mdx)
echo "文章 slug: $SLUG"
echo ""

# 步骤 4：测试本地访问
echo "🌐 步骤 4/5：测试本地访问..."
TEST_URL="http://localhost:4321/$SLUG"
echo "测试地址: $TEST_URL"
echo ""

# 等待服务器完全启动
sleep 2

# 测试访问
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$TEST_URL" 2>&1)

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ 本地访问测试成功（HTTP $HTTP_CODE）"
else
    echo "❌ 本地访问测试失败（HTTP $HTTP_CODE）"
    echo ""
    echo "🔍 检查错误详情..."
    
    # 获取错误页面内容
    ERROR_CONTENT=$(curl -s "$TEST_URL" 2>&1)
    
    if echo "$ERROR_CONTENT" | grep -q "404"; then
        echo "❌ 404 错误：页面未找到"
        echo "可能原因："
        echo "  - 文件名格式不正确（应为 YYYY-MM-DD-slug.mdx）"
        echo "  - frontmatter 格式错误"
    elif echo "$ERROR_CONTENT" | grep -q "Cannot find module"; then
        echo "❌ 模块错误：找不到组件"
        echo "可能原因："
        echo "  - 使用了 import 语句（应删除）"
        echo "  - 组件名称或属性错误"
        ERROR_MSG=$(echo "$ERROR_CONTENT" | grep "Cannot find module" | head -1)
        echo "错误详情：$ERROR_MSG"
    elif echo "$ERROR_CONTENT" | grep -q "Error:"; then
        echo "❌ 渲染错误"
        ERROR_MSG=$(echo "$ERROR_CONTENT" | grep "Error:" | head -1)
        echo "错误详情：$ERROR_MSG"
    else
        echo "❌ 未知错误"
        echo "请手动访问 $TEST_URL 查看详情"
    fi
    
    echo ""
    echo "🔧 修复建议："
    echo "1. 检查文章格式：$BLOG_DIR/MDX-WRITING-GUIDE.md"
    echo "2. 查看开发服务器日志：tail -f /tmp/citepo-dev.log"
    echo "3. 手动测试：open $TEST_URL"
    exit 1
fi
echo ""

# 步骤 5：确认并执行 Git 操作
echo "📦 步骤 5/5：Git 操作"
echo ""
echo "✅ 所有测试通过！可以执行 Git 操作。"
echo ""
echo "请选择操作："
echo "1) 提交并推送（推荐）"
echo "2) 仅提交到本地"
echo "3) 跳过 Git 操作"
echo ""
read -p "选择 [1-3]: " choice

case $choice in
    1)
        echo ""
        echo "📝 提交到 Git..."
        cd "$BLOG_DIR"
        git add "$FULL_PATH"
        
        # 提示输入提交信息
        read -p "请输入提交信息（留空使用默认）: " commit_msg
        if [ -z "$commit_msg" ]; then
            commit_msg="Add blog: $SLUG"
        fi
        
        git commit -m "$commit_msg"
        
        echo ""
        echo "🚀 推送到远端..."
        if git push origin main; then
            echo ""
            echo "✅ 推送成功！"
            echo ""
            echo "🌐 远端地址："
            echo "  https://5ageoblog.citepo.app/$SLUG"
        else
            echo ""
            echo "❌ 推送失败！"
            echo "可能原因："
            echo "  - 网络连接问题"
            echo "  - 需要设置代理：export https_proxy=http://127.0.0.1:1087"
            echo "  - 远端仓库权限问题"
            exit 1
        fi
        ;;
    2)
        echo ""
        echo "📝 提交到本地 Git..."
        cd "$BLOG_DIR"
        git add "$FULL_PATH"
        
        read -p "请输入提交信息（留空使用默认）: " commit_msg
        if [ -z "$commit_msg" ]; then
            commit_msg="Add blog: $SLUG"
        fi
        
        git commit -m "$commit_msg"
        echo "✅ 已提交到本地"
        echo "稍后可手动推送：git push origin main"
        ;;
    3)
        echo ""
        echo "⏭️ 跳过 Git 操作"
        echo "稍后可手动提交："
        echo "  cd $BLOG_DIR"
        echo "  git add $FULL_PATH"
        echo "  git commit -m 'Add blog: $SLUG'"
        echo "  git push origin main"
        ;;
    *)
        echo "❌ 无效选择"
        exit 1
        ;;
esac

echo ""
echo "========================================"
echo "✅ 流程完成！"
echo "========================================"
