# tools

## bundle-post-content-css.sh

`metadata-hook` loads a **single** `assets/css/post-content-bundle.css` (fewer runtime requests). After editing any of:

`markdown-extras.css`, `blockquote.css`, `table.css`, `inline-code.css`

run from repo root:

```bash
./tools/bundle-post-content-css.sh
```

## add_tags_to_posts.rb

批量为 `_posts` 下的文章添加或更新 **tags**  front matter，标签由每篇文章的 **categories** 和 **title**（及文件名）推导。

### 运行方式

在仓库根目录执行（不要进 `tools/` 再执行）：

```bash
# 只为尚未包含 tags 的文章添加 tags（新文章）
ruby tools/add_tags_to_posts.rb

# 强制为所有文章重新计算并覆盖 tags
ruby tools/add_tags_to_posts.rb --force
```

### 标签来源与规则

- **分类**：文章的 `categories`（单个或数组）会直接作为 tag。
- **标题**：
  - 匹配 “X in Action” / “X-in-action” 时，取主词 **X**（如 Prompt、Go、Bazel）。
  - 若标题含 “ - ”，只取前半段（如 “OpenClaw - Personal AI Assistant” → `OpenClaw`）。
  - 标题过长或含 “(…)” 时，只取括号前一段，避免整句当 tag。
- **文件名**：从 `YYYY-MM-DD-topic-in-action.markdown` 中抽出 `topic` 作为候选 tag（与标题去重后再加入）。
- **去重**：同一 tag 不重复；大小写不同视为同一 tag，只保留一个。
- **数量**：每篇最多保留 **6** 个 tags（在脚本里由 `MAX_TAGS` 控制）。

### 示例

| 文章 | categories | 生成的 tags 示例 |
|------|------------|------------------|
| Prompt in Action | ML | Prompt, ML |
| OpenClaw - Personal AI Assistant | ML | OpenClaw, ML |
| Go in Action | [GoLang] | Go, GoLang |
| 网游创业失败全攻略 (许怡然) | [Game] | 网游创业失败全攻略, Game |

### 说明

- 已有 `tags` 且未加 `--force` 时，该文章会被跳过。
- 使用 `--force` 会**覆盖**当前 front matter 中的 `tags`，按上述规则重新生成。
- 生成后可在站点 **Tags** 页或 `/tags/` 查看效果；单 tag 页面路径为 `/tags/<tag名>/`（依赖 `jekyll-archives`）。

## convert_highlight_to_fenced.rb

将文章中的 Jekyll **`{% highlight lang %}…{% endhighlight %}`** 批量替换为 **Markdown 围栏代码块**（与 [Chirpy — Writing a New Post](https://chirpy.cotes.page/posts/write-a-new-post/) 一致）。若块内含有 `{{` 或 `{%`，会自动外包一层 **`{% raw %}…{% endraw %}`**。

### 运行方式

在仓库根目录执行：

```bash
ruby tools/convert_highlight_to_fenced.rb _posts
# 或单文件
ruby tools/convert_highlight_to_fenced.rb _posts/YYYY-MM-DD-文章名.markdown
```

转换后原文件会被覆盖；建议先提交或备份。若某段在 `{% raw %}` 内被错误地写成 `highlight` + `` ``` `` 混用，脚本可能无法配对，需手工整理（见仓库历史中已修复的样例）。
