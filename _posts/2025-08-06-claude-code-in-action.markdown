---
layout: post
title:  "Claude Code in Action"
date:   2025-08-06 12:30:00 +0800
categories: ML
---

* Do not remove this line (it will not be displayed)
{:toc}


# Introduction

**Claude Code** is an **agentic coding tool** that lives in your **terminal**, understands your codebase, and helps you code faster by executing routine tasks, explaining complex code, and handling git workflows -- **all through natural language commands**. Use it in your **terminal**, **IDE**, or `tag @claude` on Github.

Learn more in the [official documentation](https://docs.anthropic.com/en/docs/claude-code/overview).


## What Claude Code does for you

* **Build features from descriptions**: Tell Claude what you want to build **in plain English**. It will make a plan, write the code, and ensure it works.

* **Debug and fix issues**: Describe a bug or paste an error message. Claude Code will analyze your codebase, identify the problem, and implement a fix.

* **Navigate any codebase**: Ask anything about your team’s codebase, and get a thoughtful answer back. Claude Code maintains awareness of your entire project structure, can find up-to-date information from the web, and with [MCP](https://docs.anthropic.com/en/docs/claude-code/mcp) can pull from external datasources like `Google Drive`, `Figma`, and `Slack`.

* **Automate tedious tasks**: Fix fiddly lint issues, resolve merge conflicts, and write release notes. Do all this in a single command from your developer machines, or automatically in CI.

## Why developers love Claude Code

* **Works in your terminal**: `Not another chat window. Not another IDE`. Claude Code meets you where you already work, with the tools you already love.

* **Takes action**: Claude Code can directly edit files, run commands, and create commits. Need more? **MCP** lets Claude read your design docs in Google Drive, update your tickets in Jira, or use your custom developer tooling.

* **Unix philosophy**: Claude Code is composable and scriptable.

`tail -f app.log | claude -p "Slack me if you see any anomalies appear in this log stream"` works.

Your CI can run `claude -p "If there are new text strings, translate them into French and raise a PR for @lang-fr-team to review"`.

* **Enterprise-ready**: Use Anthropic’s API, or host on `AWS` or `GCP`. Enterprise-grade security, privacy, and compliance is built-in.




# Prepare

## System requirements

* **Operating Systems**: macOS 10.15+, Ubuntu 20.04+/Debian 10+, or Windows 10+ (with WSL 1, WSL 2, or Git for Windows)
* **Hardware**: 4GB+ RAM
* **Software**: [Node.js 18+](https://nodejs.org/en/download)
* **Network**: Internet connection required for authentication and AI processing
* **Shell**: Works best in `Bash`, `Zsh` or `Fish`
* **Location**: [Anthropic supported countries](https://www.anthropic.com/supported-countries)





## Install nvm

refer: [Installing nodejs and npm on linux](https://stackoverflow.com/questions/39981828/installing-nodejs-and-npm-on-linux)

I really recommend you install node and npm using [nvm](https://github.com/creationix/nvm) (**Node Version Manager**). This is the fastest, cleanest and easiest way to do it.

To install or update **nvm**, you should run the [install script](https://github.com/nvm-sh/nvm/blob/v0.40.3/install.sh). To do that, you may either download and run the script manually, or use the following `cURL` or `Wget` command:

``` bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

Running either of the above commands downloads a script and runs it. The script clones the **nvm** repository to `~/.nvm`, and attempts to add the source lines from the snippet below to the correct profile file (`~/.bashrc`, `~/.bash_profile`, `~/.zshrc`, or `~/.profile`). If you find the install script is updating the wrong profile file, set the `$PROFILE` env var to the profile file’s path, and then rerun the installation script.

``` bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

最后执行 `. .bashrc` 使得 nvm 环境设置生效。

```
$ nvm -h

Node Version Manager (v0.40.3)

Note: <version> refers to any version-like string nvm understands. This includes:
  - full or partial version numbers, starting with an optional "v" (0.10, v0.1.2, v1)
  - default (built-in) aliases: node, stable, unstable, iojs, system
  - custom aliases you define with `nvm alias foo`

 Any options that produce colorized output should respect the `--no-colors` option.

Usage:
  nvm --help                                  Show this message

...
```

And you are now able to **install node typing**:

``` bash
nvm install <version>
```

For example

``` bash
nvm install 4.2.1
```

If you just want to install the latest node version, you can just type

``` bash
nvm install node
```

![nvm](/assets/images/202508/nvm.png)



## Install Claude Code

``` bash
# Install Claude Code
npm install -g @anthropic-ai/claude-code

# Navigate to your project
cd your-awesome-project

# Start coding with Claude
claude
```

> **Note**: **Do NOT** use `sudo npm install -g` as this can lead to **permission issues and security risks**. If you encounter permission errors, see [configure Claude Code](https://docs.anthropic.com/en/docs/claude-code/troubleshooting#linux-permission-issues) for recommended solutions.
>
> Some users may be automatically migrated to an improved installation method. Run `claude doctor` after installation to check your installation type.



Got specific setup needs or hit issues? See [advanced setup](https://docs.anthropic.com/en/docs/claude-code/setup) or [troubleshooting](https://docs.anthropic.com/en/docs/claude-code/troubleshooting).


![npm](/assets/images/202508/npm.png)

```
$ ls -l ~/.nvm/versions/node/v24.5.0/bin/claude
lrwxrwxrwx 1 gerryyang users 52 Aug  6 16:50 /data/home/gerryyang/.nvm/versions/node/v24.5.0/bin/claude -> ../lib/node_modules/@anthropic-ai/claude-code/cli.js
```


After the installation process completes, navigate to your project and start Claude Code:


``` bash
cd your-awesome-project
claude
```

Claude Code offers the following **authentication options**:

1. **Anthropic Console**: The default option. Connect through the Anthropic Console and complete the OAuth process. Requires active billing at [console.anthropic.com](https://console.anthropic.com/).

2. **Claude App (with Pro or Max plan)**: Subscribe to Claude’s [Pro or Max plan](https://www.anthropic.com/pricing) for a unified subscription that includes both Claude Code and the web interface. Get more value at the same price point while managing your account in one place. Log in with your Claude.ai account. During launch, choose the option that matches your subscription type.

3. **Enterprise platforms**: Configure Claude Code to use [Amazon Bedrock or Google Vertex AI](https://docs.anthropic.com/en/docs/claude-code/third-party-integrations) for enterprise deployments with your existing cloud infrastructure.

> Claude Code securely stores your credentials. See [Credential Management](https://docs.anthropic.com/en/docs/claude-code/iam#credential-management) for details.


# Get started

* https://docs.anthropic.com/en/docs/claude-code/quickstart
* [Continue with Quickstart (5 mins)](https://docs.anthropic.com/en/docs/claude-code/quickstart)


# Tips

``` bash
# Should show an alias to ~/.claude/local/claude
which claude

# Check installation health
claude doctor
```

# Update Claude Code

## Auto updates

Claude Code automatically keeps itself up to date to ensure you have the latest features and security fixes.

* Update checks: Performed on startup and periodically while running
* Update process: Downloads and installs automatically in the background
* Notifications: You’ll see a notification when updates are installed
* Applying updates: Updates take effect the next time you start Claude Code


## Disable auto-updates

``` bash
# Via configuration
claude config set autoUpdates false --global

# Or via environment variable
export DISABLE_AUTOUPDATER=1
```

## Update manually

``` bash
claude update
```





# Q&A

## 国家地区访问限制问题

Claude Code might not be available in your country. Check supported countries at https://anthropic.com/supported-countries

![claude1](/assets/images/202508/claude1.png)






# Refer

* https://www.anthropic.com/claude-code
* https://github.com/anthropics/claude-code
* https://docs.anthropic.com/en/docs/claude-code/overview