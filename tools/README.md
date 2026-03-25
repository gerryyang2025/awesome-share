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

## check_liquid_posts.rb

对 `_posts` 下每篇文章**去掉 YAML front matter 后的正文**执行 **`Liquid::Template.parse`**，与 Jekyll 在生成页面前的 Liquid 阶段一致，用于提前发现：

- 多余的 `{% endraw %}`、未闭合的 `{% raw %}`（`--verbose` 下会做简单的 raw/endraw 计数提示）
- 非法的 `{{ … }}`、未知 Liquid 标签等

**不**等同于完整 `jekyll build`（不跑插件、不渲染 Markdown），但足以捕获多数正文里的 Liquid 语法错误。

脚本会**按字节读入并 scrub 非法 UTF-8** 再解析；**去掉 front matter 时使用字符切片**（避免误用 `byteslice` 截断多字节字符）。站点仍建议全部 post 保存为 **UTF-8（无 BOM）**。

**进一步定位编码问题**：加 **`--encoding-report`**，对**未 scrub 的原始文件**报告首个非法 UTF-8 区域的**字节偏移**、**约略行号**、**周围 hex**（便于在十六进制编辑器或 `xxd` 里对照）。

**Jekyll 专有标签**：正文里的 **`{% post_url … %}`** 在纯 Liquid 中不存在；检查脚本已注册**空实现的 stub**，与 `jekyll build` 行为对齐以便解析通过。若还有其它自定义标签报错，需在脚本中同样 stub 或改为完整 `jekyll build` 检查。

### 运行方式

在仓库根目录、已 `bundle install` 的前提下（Ruby 须为 3.1+，与 Jekyll 一致）：

```bash
bundle exec ruby tools/check_liquid_posts.rb
bundle exec ruby tools/check_liquid_posts.rb _posts/2023-09-09-etcd-in-action.markdown
bundle exec ruby tools/check_liquid_posts.rb --verbose
# 仅定位「磁盘上非 UTF-8」：字节偏移与约略行号、周围 hex
bundle exec ruby tools/check_liquid_posts.rb --encoding-report
```

也可在仓库根目录使用 **`optools`**（会先加载 rbenv，与 `start` / `check` 一致）：

```bash
./optools liquid-check
./optools liquid-check --verbose
./optools liquid-check --encoding-report
```

若交互式 shell 仍指向系统自带 Ruby，还可使用 **`./optools run -- bundle exec ruby tools/check_liquid_posts.rb`**，或 **`./optools shell-init`** 后 **`source ~/.bashrc`** 再 **`bundle exec …`**。

退出码：全部通过为 `0`，任一文件解析失败为 `1`；缺少 `liquid`  gem 时为 `2`。

### 常见错误

**`can't find gem bundler … Gem::GemNotFoundException`**

说明当前用来执行 `bundle` 的 Ruby 环境里**没有安装 bundler**（或 `PATH` 指向了别的 Ruby 的 `bundle` 可执行文件）。

1. 使用与本站 **Jekyll 相同的 Ruby**（`Gemfile` / Chirpy 要求 **Ruby ≥ 3.1**，**不要用系统自带的 2.5** 跑 `bundle`）。
2. 为该 Ruby 安装 Bundler 并安装依赖，例如：
   ```bash
   gem install bundler
   bundle install
   bundle exec ruby tools/check_liquid_posts.rb
   ```
3. 若已用 **rbenv / rvm / asdf**，先 `rbenv shell 3.x`（或等价命令）再执行上述命令，确保 `which ruby` 与 `which bundle` 一致。

**`cannot load the `liquid` gem`（脚本以退出码 2 退出）**

在未进入 Bundler 的环境下直接 `ruby tools/check_liquid_posts.rb` 时，若当前 Ruby 未安装 `liquid`，会提示此错误。请改用 **`bundle exec ruby …`**，或仅用于临时排查时执行 **`gem install liquid`**（版本宜与 Jekyll 4 依赖接近，如 4.x）。

### 写作提示（与 Liquid 相关）

- Ansible / Helm / Jinja2 示例里若同一行出现多条 `{% … %}`（如 `{% for %}…{% if %}…{% endif %}{% endfor %}`），有时会导致 Liquid 对 `{% raw %}` 块的切分异常；可拆成**多个**连续的 `{% raw %}…{% endraw %}` 代码块，或改为不出现字面量 `{%` 的文字说明。
- 正文里若需提到 `{%` / `%}`，避免在 `{% raw %}` 外直接写未配对的 `{%`；可用文字描述（如 “brace-percent 标签”）或确保整段包在成对的 `raw` 内且内部不再出现会提前结束 raw 的片段。

## 注意事项（文章写作）

- **`_posts` 正文中不要使用 emoji 符号**（含标题、列表、代码块注释、提示块等）。统一用纯文字与标点表达语气或强调，避免字体回退不一致、无障碍与复制粘贴异常、以及部分终端或 RSS 阅读器显示问题。
