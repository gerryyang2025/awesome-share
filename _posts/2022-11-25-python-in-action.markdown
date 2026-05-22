---
layout: post
title:  "Python in Action"
date:   2022-11-25 12:00:00 +0800
last_modified_at: 2026-05-22 11:13:20 +0800
categories: Python
tags:
  - Python
  - uv
  - 包管理
  - Typer
  - CLI

---

* Do not remove this line (it will not be displayed)
{:toc}


# Mac OS X 环境安装 Python 3

```bash
brew install python
```


https://pythonguidecn.readthedocs.io/zh/latest/starting/install3/osx.html


# Linux 环境安装 Python 3.8

```bash
#!/bin/bash

# Download Python
if ! wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz; then
  echo "Error: Failed to download Python"
  exit 1
fi

# Extract the archive
if ! tar xvf Python-3.8.12.tgz; then
  echo "Error: Failed to extract the tarball"
  exit 1
fi

# Enter the extracted directory
cd Python-3.8.12 || { echo "Error: Failed to enter the extracted directory"; exit 1; }

# Configure the build
if ! ./configure; then
  echo "Error: Failed to configure the build"
  exit 1
fi

# Get the number of CPU cores
num_cores=$(nproc)

# Build Python
if ! make -j"${num_cores}"; then
  echo "Error: Failed to build Python"
  exit 1
fi

# Check if the user has root privileges before installing
if [ "$(id -u)" != "0" ]; then
  echo "Error: Installation requires root privileges" 1>&2
  exit 1
fi

# Install Python
if ! make install; then
  echo "Error: Failed to install Python"
  exit 1
fi

# Create a soft link for Python
if ! ln -sf /usr/local/bin/python3.8 /bin/python; then
  echo "Error: Failed to create a soft link for Python"
  exit 1
fi

# Print the installed Python version
python --version
```



```text
$ python --version
Python 3.8.12
$ which python
/usr/bin/python
```


安装 pip

```bash
python -m pip install --upgrade pip
```


# uv：包与环境管理

[uv](https://docs.astral.sh/uv/) 由 [Astral](https://astral.sh/)（与 [Ruff](https://docs.astral.sh/ruff/) 同一团队）开发，用 Rust 实现，定位为**一体化的 Python 包与环境管理工具**。它把 `pip`、`virtualenv`、`pyenv`、部分 `pipx` / Poetry 工作流收敛到一条命令链里，官方宣称在解析与安装依赖时比传统 **pip + venv** 快一个数量级以上，适合日常脚本、运维工具和正式项目。

## 是什么

一句话：**面向现代 Python 项目的「快版 pip + venv + 锁文件」一体化 CLI。**

* **pip**：负责**装包**——把某个（或某几个）包装进当前解释器/虚拟环境；一般不单独承担「整个项目环境 + 统一锁文件 + 一键对齐」这一套。常见组合是 `venv` 建环境、`pip install -r requirements.txt` 装依赖，再用 `pip freeze` 或 pip-tools 自己维护可复现清单。
* **uv**：在 pip 能做的事之外，还把**环境、依赖解析、锁文件、安装**串成一条链；项目模式下执行 **`uv sync`**，即可按 `pyproject.toml` + `uv.lock` 把整个项目的虚拟环境与依赖版本对齐，CI 与同事机器更容易一致。

因此二者不是简单「谁取代谁」：**pip 仍是 Python 生态里最基础的包安装器**；uv 在保留 `uv pip install` 等兼容能力的同时，更适合需要**快、省事、可锁定**的现代项目工作流。与上文「源码编译 Python + `pip install`」并不冲突——老环境继续用 pip 即可，新机器或新项目可优先 uv。

能力上可以拆成四层（后两层是 pip 通常不「自带」的）：

* **装解释器**：`uv python install`（类似 pyenv）
* **建虚拟环境**：`uv venv`（类似 `python -m venv`）
* **装包**：`uv pip install`（走 uv 解析器与缓存，习惯接近 pip）
* **管项目**：`uv init` / `uv add` / `uv sync` / `uv run` + `uv.lock`（环境 + 锁文件 + 安装一次对齐）

## 安装 uv

**macOS / Linux**（官方独立安装脚本，不依赖已有 Python）：

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

也可用 Homebrew：

```bash
brew install uv
```

安装后验证：

```bash
uv --version
```

文档：[Installing uv](https://docs.astral.sh/uv/getting-started/installation/)

## uv 与 pip 的简单对比

| | **pip** | **uv** |
|---|---------|--------|
| **核心职责** | 装包 | 管环境 + 解析依赖 + 锁文件 + 安装 |
| **项目级对齐** | 需自行组合 venv、requirements、freeze / pip-tools | `uv sync` 一条命令对齐整个项目 |
| **锁文件** | 非内置；常靠 `requirements.txt` 或第三方工具 | 内置 `uv.lock`，与 `pyproject.toml` 配套 |
| **速度** | 基准 | 解析与安装通常明显更快（Rust 实现） |

**怎么选：**

* 临时给当前环境加一个包、脚本里随手 `pip install xxx` → **pip** 足够。
* 要固定 Python 版本、`.venv`、依赖树和锁文件，并希望 CI / 同事 `sync` 后环境一致 → 用 **uv 项目模式**（`uv init` / `uv add` / `uv sync`）。
* 已有 `requirements.txt`、只想加速安装 → **`uv pip install -r requirements.txt`**，不必立刻改项目结构。

### 与 pip + venv 的常见命令对照

| 场景 | pip + venv（传统） | uv |
|------|-------------------|-----|
| 安装某个 Python 版本 | pyenv / 源码编译 / 系统包管理器 | `uv python install 3.12` |
| 创建虚拟环境 | `python3 -m venv .venv` | `uv venv` |
| 只装几个包 | `pip install requests` | `uv pip install requests` |
| 整项目依赖对齐 | `pip install -r requirements.txt`（无统一锁文件时需自备 freeze） | `uv sync`（读 `uv.lock`） |
| 运行脚本 | 先 `source .venv/bin/activate` 再 `python main.py` | `uv run python main.py` |

> `uv pip` 在逐步对齐 pip 行为，但**并非与 pip 完全等价**；极冷门 wheel 或特殊私有索引场景，仍可能要回退 pip，或查阅 [pip compatibility](https://docs.astral.sh/uv/pip/compatibility/)。
{: .prompt-info }

## 常用用法

### 安装与管理 Python 版本

无需事先用 brew 或源码装好某个小版本，可直接让 uv 拉取官方构建：

```bash
# 安装指定版本
uv python install 3.12

# 列出已安装与可安装版本
uv python list
```

项目根目录若有 `.python-version`，`uv` 在该目录下会优先使用文件中声明的版本。

### 虚拟环境与安装包（替代 pip + venv）

在任意目录快速建环境并装包：

```bash
# 当前目录创建 .venv（默认）
uv venv

# 指定 Python 版本创建环境
uv venv --python 3.12

# 在 .venv 中安装包（无需手动 source activate）
uv pip install requests xxhash

# 从 requirements.txt 安装
uv pip install -r requirements.txt

# 查看环境中已装包
uv pip list
```

若习惯「先激活再 pip」，仍可 `source .venv/bin/activate` 后照常使用；`uv pip` 也支持 `--python .venv` 显式指定环境。

### 项目管理（pyproject.toml + 锁文件）

适合从零新建或逐步迁移到现代项目布局：

```bash
# 新建项目（生成 pyproject.toml、.python-version、入口脚本等）
uv init my-app
cd my-app

# 添加运行时依赖（写入 pyproject.toml 并更新 uv.lock）
uv add requests

# 添加开发依赖
uv add --dev pytest

# 按锁文件同步 .venv（装齐依赖）
uv sync

# 在项目环境中执行命令（自动用项目解释器与依赖）
uv run python main.py
uv run pytest
```

`uv.lock` 应纳入版本控制，保证 CI 与同事机器装到同一组包版本；改依赖后执行 `uv lock` 或 `uv add` / `uv remove` 会自动维护锁文件。

### 临时运行单文件脚本

未建完整项目时，可用 `uv run` 自动解析 shebang 或内联依赖（[scripts 指南](https://docs.astral.sh/uv/guides/scripts/)）：

```bash
uv run examples/hello.py
```

### 安装 CLI 工具（类似 pipx）

```bash
uv tool install ruff
uv tool run ruff check .
```

## 实践建议

* **新项目**：优先 `uv init` + `uv add` + `uv sync`，少手写 `requirements.txt`；若团队仍要求 `requirements.txt`，可用 `uv export` 导出。
* **老项目**：保留现有 `requirements.txt`，用 `uv venv` + `uv pip install -r requirements.txt` 即可渐进迁移，不必一次改完。
* **CI**：在流水线里安装 uv 后执行 `uv sync --frozen`（或 `uv pip install` + hash 校验），比反复 `pip install` 更省时。
* **与系统 Python 并存**：uv 管理的解释器通常在用户目录下，不会覆盖 `/usr/bin/python`；生产机若禁止随意下载二进制，需按内网镜像文档配置 [index](https://docs.astral.sh/uv/configuration/indexes/)。

## 参考资源

* [uv 官方文档](https://docs.astral.sh/uv/)
* [Getting started](https://docs.astral.sh/uv/getting-started/)
* [Working on projects](https://docs.astral.sh/uv/guides/projects/)
* [GitHub: astral-sh/uv](https://github.com/astral-sh/uv)


# Typer：写命令行工具（CLI）

[Typer](https://typer.tiangolo.com/) 是一个用 Python 编写**命令行工具（CLI）**的库，作者是 [FastAPI](https://fastapi.tiangolo.com/) 的同一个人 [Sebastián Ramírez](https://github.com/tiangolo)。核心思路是：**用类型注解和函数参数描述命令、子命令、选项**，由 Typer 自动生成 `--help`、参数解析和错误提示，少写样板代码。

底层基于 [Click](https://click.palletsprojects.com/)，因此既保留 Click 的成熟度，又能在代码里获得接近「写普通函数」的体验；若用过 FastAPI 的「类型注解驱动 API」，上手 Typer 会很自然。

## 安装

```bash
pip install typer

# 或配合上文 uv
uv add typer
```

带「可编辑安装」的 CLI 项目通常还会加 `typer[all]`（含 shell 补全等可选能力），按官方文档选用即可。

## 最小示例

**单命令**：函数参数即 CLI 参数，类型注解决定解析方式。

```python
import typer


def main(name: str, formal: bool = False):
    if formal:
        print(f"Good day, {name}.")
    else:
        print(f"Hello {name}")


if __name__ == "__main__":
    typer.run(main)
```

运行：

```bash
python hello.py World
python hello.py --help
python hello.py Camila --formal
```

`name: str` 成为位置参数；`formal: bool = False` 成为 `--formal` / `--no-formal` 类选项（布尔开关由 Typer 按约定生成）。

## 多命令与子命令

用 `typer.Typer()` 注册多个子命令，适合 `git` 式 `app cmd` 结构：

```python
import typer

app = typer.Typer(help="示例 CLI")
users_app = typer.Typer(help="用户相关")
app.add_typer(users_app, name="users")


@users_app.command("create")
def create_user(name: str, email: str = typer.Option(..., help="邮箱")):
    typer.echo(f"创建用户: {name} <{email}>")


@app.command()
def version():
    typer.echo("1.0.0")


if __name__ == "__main__":
    app()
```

```bash
python cli.py users create Alice --email alice@example.com
python cli.py version
python cli.py --help
python cli.py users --help
```

## 参数与选项的常见写法

| 写法 | CLI 含义 | 示例 |
|------|----------|------|
| `name: str` | 位置参数 | `cli.py Alice` |
| `count: int = 1` | 带默认值的选项 | `--count 3` |
| `verbose: bool = False` | 布尔开关 | `--verbose` / `--no-verbose` |
| `typer.Option(...)` | 具名选项、必填、帮助文案 | `--email TEXT` |
| `typer.Argument(...)` | 位置参数进阶（帮助、校验） | 第一个参数 `NAME` |
| `Optional[str] = None` | 可选字符串选项 | 省略则不传 |

必填选项常用 `typer.Option(..., help="说明")`（`...` 表示无默认值、必须提供）：

```python
def deploy(
    env: str = typer.Option("dev", "--env", "-e", help="环境名"),
    dry_run: bool = typer.Option(False, help="只打印不执行"),
):
    typer.echo(f"deploy to {env}, dry_run={dry_run}")
```

## 与 argparse 的简单对比

| | **argparse**（标准库） | **Typer** |
|---|------------------------|-----------|
| 定义方式 | `add_argument()` 等命令式 API | 函数签名 + 类型注解 |
| `--help` | 需手写 `help=` | 多数由注解与参数名自动生成 |
| 学习成本 | 内置、无依赖 | 需安装，语法更贴近现代 Python |
| 适用场景 | 脚本简单、不想引第三方 | 子命令多、选项多、希望和 FastAPI 风格一致 |

标准库 `argparse` 仍适合极简脚本；选项多、要子命令、希望和类型检查/IDE 提示一致时，Typer 更省事。

## 发布为可执行命令

在 `pyproject.toml` 里声明入口点（配合 uv / pip 安装后可直接在 PATH 里调用）：

```toml
[project.scripts]
my-cli = "my_package.cli:app"
```

`my_package/cli.py` 中导出 `app = typer.Typer()` 并在模块末尾调用 `app()`，或使用 Click 兼容的入口。安装项目后：

```bash
my-cli --help
```

开发阶段也可 `uv run my-cli` 或 `python -m my_package.cli`。

## 实践建议

* **类型注解要准确**：Typer 靠注解推断 CLI 类型；`bool`、`int`、`Optional[...]`、`list[str]` 等会直接影响解析行为。
* **用户可见文案**：用 `typer.Option(..., help="...")` / `typer.Argument(..., help="...")` 和 `typer.Typer(help="...")` 补全 `--help`，避免「只有参数名、没有说明」。
* **输出与退出**：用 `typer.echo()` 打印；错误用 `raise typer.Exit(code=1)` 或 `raise typer.BadParameter("原因")` 给出友好提示。
* **测试**：子命令函数保持纯逻辑，便于单元测试；CLI 层只做参数映射。

## 参考资源

* [Typer 官方文档](https://typer.tiangolo.com/)
* [Tutorial - User Guide](https://typer.tiangolo.com/tutorial/)
* [GitHub: fastapi/typer](https://github.com/fastapi/typer)


# module 依赖

## xxhash

```bash
/usr/local/bin/pip install xxhash

# or
python3 -m pip install xxhash

# 若已用 uv 管理环境（见上文「uv」一节）
uv pip install xxhash
```





# Tips

## 指定使用的 Python 版本 (shebang)

在 Python 脚本中指定使用的 Python 版本，可以通过在脚本文件的开头添加 shebang 行来实现。shebang 行是一个以 `#!` 开头的特殊注释行，用于指定脚本文件的解释器。

例如，如果我们想要在 Python 3 中运行脚本，可以在脚本文件的开头添加以下 shebang 行：

```python
#!/usr/bin/env python3
```


这行代码告诉操作系统，使用 `/usr/bin/env` 命令来查找 Python 3 的解释器，并将该解释器用于执行脚本文件。如果系统中安装了多个 Python 版本，这种方式可以自动选择最新的 Python 3 版本。

如果我们想要在 Python 2 中运行脚本，可以使用以下 shebang 行：

```python
#!/usr/bin/env python2
```


需要注意的是，不同的操作系统可能支持的 shebang 行格式不同。在 Linux 和 macOS 等类 Unix 系统中，shebang 行的格式为 `#!interpreter [optional-arg]`，其中 `interpreter` 是解释器的路径，`optional-arg` 是传递给解释器的可选参数。在 Windows 系统中，shebang 行的格式为 `#!python`，其中 `python` 是解释器的名称。因此，在编写跨平台的 Python 脚本时，需要注意 shebang 行的格式。





# 错误定位


## `python -m py_compile test.py`

* `-m py_compile`: 以模块方式运行 `py_compile` 模块
* `-m ast`: 使用 ast 模块检查语法

作用：

1. 语法检查：验证代码语法是否正确
2. 编译为字节码：将 `.py` 编译为 `.pyc`（如果语法正确）
3. 快速验证：不执行代码，只检查语法

```bash
# 语法正确的文件 - 无输出，静默成功
$ python3 -m py_compile succ_file.py
$ echo $?
0

# 语法错误的文件 - 显示错误信息
$ python3 -m py_compile bad_file.py
  File "bad_file.py", line 3
    print("hello"
                ^
SyntaxError: unexpected EOF while parsing
```


## How to catch and print the full exception traceback

参考：[How to catch and print the full exception traceback without halting/exiting the program?](https://stackoverflow.com/questions/3702675/how-to-catch-and-print-the-full-exception-traceback-without-halting-exiting-the)

`traceback.format_exc()` or `sys.exc_info()` will yield more info if that's what you want.


```python
import traceback
import sys

try:
    do_stuff()
except Exception:
    print(traceback.format_exc())
    # or
    print(sys.exc_info()[2])
```


# Q&A

## [Use isinstance to test for Unicode string](https://stackoverflow.com/questions/24514891/use-isinstance-to-test-for-unicode-string)

Test for `str`:

```python
isinstance(unicode_or_bytestring, str)
```


or, if you must handle bytestrings, test for `bytes` separately:

```python
isinstance(unicode_or_bytestring, bytes)
```


## [Error: 'dict' object has no attribute 'iteritems'](https://stackoverflow.com/questions/30418481/error-dict-object-has-no-attribute-iteritems)

Take a look at Python 3.0 Wiki [Built-in Changes](https://wiki.python.org/moin/Python3.0#Built-In_Changes) section, where it is stated:

> Removed dict.iteritems(), dict.iterkeys(), and dict.itervalues().
>
> Instead: use dict.items(), dict.keys(), and dict.values() respectively.



# Refer

* [uv 官方文档](https://docs.astral.sh/uv/)
* [Typer 官方文档](https://typer.tiangolo.com/)
* [how to succesfully compile python 3.x](https://stackoverflow.com/questions/58048079/how-to-succesfully-compile-python-3-x)















