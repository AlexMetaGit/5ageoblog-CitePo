# 5AGEOBlog 新增博客完整流程

**最后更新**：2026-03-17
**维护者**： WuKong

---

## 📋 流程概述

**目标**：确保新增博客内容符合 CitePo 规范，并在本地测试通过后才能提交到 Git 仓库。

**核心原则**：
1. **测试优先**： 必须通过本地测试，才能 Git 操作
2. **规范检查**： 使用自动化脚本检查文档规范
3. **失败修复**： 根据错误提示自动修复直至成功

---

## 🚀 完整流程

### 步骤 1：创建新文章

```bash
# 方法 1: 使用模板
cp ~/5ageoblog/content/zh/.template.mdx ~/5ageoblog/content/zh/YYYY-MM-DD-article-name.mdx

# 方法 2: 手动创建
vim ~/5ageoblog/content/zh/YYYY-MM-DD-article-name.mdx
```

**模板位置**： `~/5ageoblog/content/zh/.template.mdx`

### 步骤 2：编写内容
按照 `MDX-WRITING-GUIDE.md` 规范编写文章内容。

### 步骤 3：文档规范检查

```bash
# 运行检查脚本
~/5ageoblog/scripts/check-mdx.sh content/zh/YYYY-MM-DD-article-name.mdx
```
**检查项**：
- ❌ import 语句（不允许）
- ❌ Badge 的 variant/type 属性（必须用 color）
- ❌ AccordionItem（必须用 AccordionGroup + Accordion）
- ✅ Frontmatter 必填字段

**如果检查失败**：
1. 查看错误信息
2. 根据提示修改文章
3. 重新运行检查脚本
4. 重复直到通过

### 步骤 4: 启动本地开发服务器
```bash
# 如果服务器未运行，启动它
cd ~/5ageoblog && npx citepo dev
```
**等待启动完成**（约 5-10 秒）
**服务器地址**： http://localhost:4321/

### 步骤 5: 本地测试访问
```bash
# 方法 1: 使用 curl 测试
curl -s http://localhost:4321/YYYY-MM-DD-article-name | head -10

# 方法 2: 浏览器访问
# 打开浏览器，访问 http://localhost:4321/YYYY-MM-DD-article-name
```
**测试要求**：
- ✅ 页面返回 200 OK
- ✅ 页面标题正确
- ✅ 无错误信息

**如果测试失败**：
1. 查看浏览器控制台错误
2. 检查服务器日志： `tail -f /tmp/citepo-dev.log`
3. 根据错误修改文章
4. 重新测试直到成功
5. **常见错误修复**：
   - `Cannot find module '@components'` → 删除 import 语句
   - `Badge variant 不支持` → 改用 `Badge color`
   - `AccordionItem not识别` → 改用 `AccordionGroup + Accordion`

### 步骤 6: Git 提交
```bash
# 揻代理（如果需要）
export https_proxy="http://127.0.0.1:1087"

# 添加文件
cd ~/5ageoblog && git add content/zh/YYYY-MM-DD-article-name.mdx

# 提交更改
git commit -m "Add blog: 文章标题"
# 推送到远端
git push origin main
```

**如果 push 夽败**：
1. 检查错误信息
2. 设置代理: `export https_proxy="http://127.0.0.1:1087"`
3. 重试 git push
4. 如果仍然失败，等待网络恢复后重试

5. 记录错误日志以供后续分析

### 步骤 7: 验证远端部署
```bash
# 讣问远端博客地址
curl -s https://5ageoblog.citepo.app/YYYY-MM-DD-article-name | head -10
```
**验证通过标准**：
- ✅ 页面正常访问
- ✅ 内容正确显示
- ✅ 无错误信息

---

## 🛠️ 自动化脚本

### 宣布脚本（new-blog.sh）
**位置**： `~/5ageoblog/scripts/new-blog.sh`
**功能**：
- 自动执行完整流程
- 规范检查
- 本地测试
- Git 提交
- 夯败自动修复
**使用**：
```bash
~/5ageoblog/scripts/new-blog.sh content/zh/YYYY-MM-DD-article-name.mdx
```

### 检查脚本（check-mdx.sh）
**位置**： `~/5ageoblog/scripts/check-mdx.sh`
**功能**： 检查 MDX 文档规范
**使用**：
```bash
~/5ageoblog/scripts/check-mdx.sh content/zh/YYYY-MM-DD-article-name.mdx
```

---

## 📝 检查清单
发布新文章前，请检查：
- [ ] 文章文件已创建
- [ ] 文章内容已编写
- [ ] 文档规范检查通过
- [ ] 本地开发服务器已启动
- [ ] 本地测试访问成功
- [ ] Git 揥交完成
- [ ] 远端验证通过

- [ ] 更新 MEMORY.md 记录

---

## ⚠️ 注意事项
1. **必须通过本地测试**： 不允许跳过本地测试直接 Git 提交
2. **失败必须修复**： 测试失败后必须修复，不能强制提交
3. **使用代理**： Git push 可能需要代理才能成功
4. **保留日志**： 记录所有错误日志供后续分析
5. **定期更新**： 定期检查 CitePo 更新，了解组件变化
6. **遵循规范**： 严格按照 MDX-WRITING-GUIDE.md 规范

7. **自动化优先**： 使用 new-blog.sh 脚本自动化流程
8. **手动备份**： 如果自动脚本失败，手动执行每个步骤
9. **错误恢复**： 讯问错误后按步骤重试，不要直接放弃
10. **长期维护**： 定期检查文档和流程的有效性
