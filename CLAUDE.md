# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal dotfiles repository (`~/Documents/sync/`), serving as "配置部" in the "一人集团" structure. All configs are symlink-deployed from this repo to their system locations.

## Symlink Deployment

```bash
# Deploy all configs (with optional backup)
.claude/skills/dotfiles/scripts/deploy.sh [--backup]
```

Mapping:

### Shell 配置
| Source | Target |
|--------|--------|
| `shell/zshrc` | `~/.zshrc` |
| `shell/zshenv` | `~/.zshenv` |
| `shell/zprofile` | `~/.zprofile` |
| `shell/zimrc` | `~/.zimrc` |
| `shell/gitconfig` | `~/.gitconfig` |
| `shell/gitignore_global` | `~/.gitignore_global` |
| `shell/bashrc` | `~/.bashrc` |
| `shell/bash_profile` | `~/.bash_profile` |
| `shell/profile` | `~/.profile` |

### 编辑器配置
| Source | Target |
|--------|--------|
| `editors/nvim/` | `~/.config/nvim` |
| `editors/tmux/tmux.conf` | `~/.tmux.conf` |
| `editors/IDE/ideavimrc` | `~/.ideavimrc` |
| `editors/lazygit/` | `~/.config/lazygit` |
| `editors/cursor/` | `~/.config/cursor` |

### 终端工具
| Source | Target |
|--------|--------|
| `terminal/yazi/` | `~/.config/yazi` |
| `terminal/ghostty/` | `~/.config/ghostty` |
| `terminal/atuin/` | `~/.config/atuin` |
| `terminal/fish/` | `~/.config/fish` |
| `terminal/neofetch/` | `~/.config/neofetch` |
| `terminal/iterm2/` | `~/.config/iterm2` |
| `terminal/hyper.js` | `~/.hyper.js` |
| `terminal/starship.toml` | `~/.config/starship.toml` |

### 窗口管理
| Source | Target |
|--------|--------|
| `window-managers/yabai/config/` | `~/.config/yabai` |
| `window-managers/karabiner/` | `~/.config/karabiner` |
| `window-managers/hammerspoon/` | `~/.config/hammerspoon` |
| `window-managers/skhd/` | `~/.config/skhd` |

### 集成与工具
| Source | Target |
|--------|--------|
| `integrations/npmrc` | `~/.npmrc` |
| `integrations/yarnrc` | `~/.yarnrc` |
| `integrations/gh/` | `~/.config/gh` |
| `integrations/github-copilot/` | `~/.config/github-copilot` |

### 敏感配置
| Source | Target |
|--------|--------|
| `secrets/env` | `~/.env` |
| `secrets/streamlit/` | `~/.streamlit` |

### 杂项
| Source | Target |
|--------|--------|
| `misc/btop/` | `~/.config/btop` |
| `misc/fd/` | `~/.config/fd` |
| `misc/htop/` | `~/.config/htop` |
| `misc/git/` | `~/.config/git` |
| `misc/messauto/` | `~/.config/messauto` |
| `misc/menus/` | `~/.config/menus` |
| `misc/joshuto/` | `~/.config/joshuto` |
| `misc/configstore/` | `~/.config/configstore` |

**Note**: `~/.hammerspoon` → `~/.config/hammerspoon` (Hammerspoon uses this path)

## Repository Structure

| Directory | Purpose |
|-----------|---------|
| `shell/` | Shell 配置（zsh/bash/git/ssh） |
| `editors/` | 编辑器（nvim/tmux/IDE/lazygit/cursor） |
| `terminal/` | 终端工具（yazi/ghostty/atuin/fish/neofetch/hyper/iterm2/starship） |
| `window-managers/` | 窗口管理（yabai/hammerspoon/karabiner/skhd） |
| `integrations/` | 外部集成（npm/yarn/gh/github-copilot/MCP） |
| `secrets/` | 敏感配置（.env/streamlit/ssh pub） |
| `misc/` | 杂项工具（btop/fd/htop/git/messauto/menus/joshuto/configstore） |
| `network/` | 网络代理配置 |
| `docs/` | 文档和清单 |
| `.secrets/` | 旧版敏感数据（.gitignore） |

## Architecture Details

### Neovim (`editors/nvim/`)

Three-layer loading: `init.lua` → `lua/config/` → plugins.

```
init.lua                    # Entry: loads defaults → keymaps → plugins
lua/config/
├── defaults.lua            # Editor settings
├── keymaps.lua             # Key mappings
├── plugins.lua             # lazy.nvim bootstrap + plugin specs
├── lsp.lua                 # LSP configuration
├── telescope.lua           # Fuzzy finder setup
├── machine_specific.lua    # Per-machine overrides
└── utils/                  # Shared utilities
```

### Zsh (`shell/zsh/`)

`zshrc` loads Zim framework first, then sources config modules by category:

```
zshrc                       # Entry: Zim init → source configs → nvm lazy-load
zimrc                       # Zim module declarations
config/
├── core/                   # 核心配置
│   ├── env.zsh             # 基础环境变量
│   ├── path.zsh            # PATH 管理
│   └── compiler.zsh        # LLVM 编译器配置
├── tools/                  # 工具配置
│   ├── modern-cli.zsh      # Modern CLI aliases (eza, bat, fd, dust)
│   ├── fzf.zsh             # FZF core config
│   ├── fzf/                # FZF tool scripts
│   ├── conda.zsh           # Conda environment
│   └── proxy.zsh           # Proxy settings
└── integrations/           # 外部集成
    ├── anthropic.zsh       # Claude API token switching
    ├── workspace.zsh       # Workspace shortcuts
    └── mappings.zsh        # Terminal keybindings
functions/                  # Autoloaded zsh functions
```

Key pattern: modern tools are conditionally aliased with `command -v` checks in `modern-cli.zsh`.

### Yabai (`window-managers/yabai/`)

Config and scripts are separated:

```
config/
├── yabairc                 # Main config (loads other .conf files)
├── spaces.conf             # Space/desktop rules
├── apps.conf               # Per-app window rules
├── indicator.conf          # Window indicator settings
└── skhd/                   # Hotkey daemon config
scripts/
├── service/                # toggle.sh start|stop|restart|toggle|status
├── window/                 # Window manipulation (resize, move, float)
├── space/                  # Space/desktop operations
└── lib/                    # Shared script utilities
```

## Common Commands

```bash
# Reload zsh config
rl

# Deploy symlinks
.claude/skills/dotfiles/scripts/deploy.sh [--backup]

# Yabai service control
./window-managers/yabai/scripts/service/toggle.sh start|stop|restart|toggle|status

# Neovim plugin management
:Lazy                       # Plugin manager UI
:Mason                      # LSP installer

# Anthropic token switching
au                          # Show current token
au max                      # Switch to max token
au transit                  # Switch to transit token
clam                        # Quick switch to max (官方 token)
clat                        # Quick switch to transit
```

## Constraints

- **DO NOT** develop scripts (that's for 开发部)
- **DO NOT** configure LaunchAgent (that's for 总控)
- **DO NOT** modify `~/.xxx` directly — always edit in this repo and deploy via symlink
- **DO** backup before modifying existing configs
- **DO** provide: config file + usage docs + activation instructions

## Commit Message Format

```
<type>(<scope>): <description>

# type: feat, fix, refactor, docs, chore
# scope: nvim, zsh, yabai, karabiner, hammerspoon, yazi, tmux, etc.
# description: 中文描述
```

## 路径规范（跨仓库引用）

| 内容 | 路径 |
|------|------|
| 全局 Skills | `~/.claude/skills/` |
| 脚本库 | `~/Dev/scripts/` |
| 水利公司 | `~/Work/zdwp/` |
| 论文部 | `~/Personal/essays/` |
| 个人网站 | `~/Personal/website/` |
| 求职管理 | `~/Personal/resume/` |
| 工作报告 | `~/Work/reports/` |
| 学习笔记 | `~/Learn/` |
| OA 项目 | `~/Dev/oa-project/` |
| Python | `/Users/tianli/miniforge3/bin/python3` |
