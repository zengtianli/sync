# Dotfiles 整理方案

## 目标
将根目录散落的配置文件统一收入 `~/Documents/sync/`，symlink 回原位，GitHub push 后 Augment 可索引。

## 安全策略

| 文件 | 风险 | 处理方式 |
|------|------|----------|
| `.env`（含 DEEPSEEK/OPENAI key） | 高 | 纳入仓库，`.gitignore` 排除，本地保留 symlink |
| `.ssh/id_ed25519`（私钥） | 极高 | 纳入仓库，`.gitignore` 排除私钥，仅管理 config/pub |
| `.aws/` | 中 | 仅管理目录结构，排除凭证文件 |
| `.streamlit/credentials.toml` | 低 | 直接管理 |

> **核心原则**：配置结构进 git，密钥文件 `.gitignore` 排除。Augment 能索引到配置结构（知道有什么 key），但不暴露实际值。

## 不纳入管理的（排除清单）

以下是运行时目录或超大缓存，丢了可以重建，不值得 git 管理：

| 目录 | 原因 |
|------|------|
| `.cargo/`, `.rustup/` | Rust 工具链运行时 |
| `.nvm/`, `.npm/` | Node 版本管理 + 缓存 |
| `.pyenv/`, `.conda/` | Python 环境 |
| `.ollama/` | 模型文件（GB 级） |
| `.docker/` | Docker 运行时 |
| `.config/nvm/`（214M） | nvm 运行时 |
| `.config/raycast/`（548M） | Raycast 缓存 |
| `.config/yarn/`（199M） | yarn 缓存 |
| `.config/clash/`（5.8M） | 代理规则（独立管理） |
| `.claude.json` | CC 自动生成的统计数据（621次启动记录），无需人工管理 |
| `.viminfo`, `.zsh_history`, `.bash_history` | 历史记录 |

## 操作清单

### 1. shell/ — 扩展 Bash 配置

```
mv ~/.bashrc          → sync/shell/bashrc
mv ~/.bash_profile    → sync/shell/bash_profile
mv ~/.profile         → sync/shell/profile
mv ~/.gitignore_global → sync/shell/gitignore_global
```

Symlink 回：
```
~/.bashrc          → sync/shell/bashrc
~/.bash_profile    → sync/shell/bash_profile
~/.profile         → sync/shell/profile
~/.gitignore_global → sync/shell/gitignore_global
```

### 2. terminal/ — 扩展终端配置

```
mv ~/.hyper.js              → sync/terminal/hyper.js
mv ~/.config/ghostty/       → sync/terminal/ghostty/
mv ~/.config/atuin/         → sync/terminal/atuin/
mv ~/.config/iterm2/        → sync/terminal/iterm2/
mv ~/.config/fish/          → sync/terminal/fish/
mv ~/.config/neofetch/      → sync/terminal/neofetch/
```

Symlink 回原位。

### 3. editors/ — 扩展编辑器配置

已有：nvim, tmux, IDE

```
mv ~/.config/lazygit/       → sync/editors/lazygit/
mv ~/.config/cursor/        → sync/editors/cursor/
```

### 4. window-managers/ — 补 symlink

karabiner 已在 sync 里但 `.config/karabiner` 没有 symlink：
```
# 确认 sync/window-managers/karabiner 和 .config/karabiner 内容一致后
rm -rf ~/.config/karabiner
ln -s ~/Documents/sync/window-managers/karabiner ~/.config/karabiner

# skhd 同理
mv ~/.config/skhd/          → sync/window-managers/skhd/
```

### 5. integrations/ — 扩展 Node/AI 配置

```
mv ~/.npmrc                 → sync/integrations/npmrc
mv ~/.yarnrc                → sync/integrations/yarnrc
mv ~/.config/gh/            → sync/integrations/gh/
mv ~/.config/github-copilot/ → sync/integrations/github-copilot/
```

### 6. secrets/ — 新建敏感配置区（.gitignore 排除值）

```
mv ~/.env                   → sync/secrets/env
mv ~/.ssh/config            → sync/secrets/ssh/config        (如果有)
mv ~/.ssh/id_ed25519.pub    → sync/secrets/ssh/id_ed25519.pub
mv ~/.streamlit/            → sync/secrets/streamlit/
```

`.gitignore` 追加：
```
secrets/env
secrets/ssh/id_ed25519
secrets/ssh/known_hosts*
```

> 注意：`.ssh/id_ed25519`（私钥）保留在原位不动，只管理 pub 和 config。

### 7. misc/ — 杂项小配置

```
mv ~/.config/btop/          → sync/misc/btop/
mv ~/.config/fd/            → sync/misc/fd/
mv ~/.config/htop/          → sync/misc/htop/
mv ~/.config/git/           → sync/misc/git/
mv ~/.config/messauto/      → sync/misc/messauto/
mv ~/.config/menus/         → sync/misc/menus/
mv ~/.config/joshuto/       → sync/misc/joshuto/
mv ~/.config/configstore/   → sync/misc/configstore/
```

### 8. yazi/ — 文件管理器（已在 terminal 类别下）

```
mv ~/.config/yazi/          → sync/terminal/yazi/
mv ~/.config/yazi-source-backup/ → sync/terminal/yazi-source-backup/
```

## Symlink 总映射表

| 原位置 | → sync 路径 |
|--------|-------------|
| `~/.bashrc` | `shell/bashrc` |
| `~/.bash_profile` | `shell/bash_profile` |
| `~/.profile` | `shell/profile` |
| `~/.gitignore_global` | `shell/gitignore_global` |
| `~/.hyper.js` | `terminal/hyper.js` |
| `~/.npmrc` | `integrations/npmrc` |
| `~/.yarnrc` | `integrations/yarnrc` |
| `~/.env` | `secrets/env` |
| `~/.streamlit/` | `secrets/streamlit/` |
| `~/.config/ghostty` | `terminal/ghostty` |
| `~/.config/atuin` | `terminal/atuin` |
| `~/.config/iterm2` | `terminal/iterm2` |
| `~/.config/fish` | `terminal/fish` |
| `~/.config/neofetch` | `terminal/neofetch` |
| `~/.config/yazi` | `terminal/yazi` |
| `~/.config/lazygit` | `editors/lazygit` |
| `~/.config/cursor` | `editors/cursor` |
| `~/.config/karabiner` | `window-managers/karabiner` |
| `~/.config/skhd` | `window-managers/skhd` |
| `~/.config/gh` | `integrations/gh` |
| `~/.config/github-copilot` | `integrations/github-copilot` |
| `~/.config/btop` | `misc/btop` |
| `~/.config/fd` | `misc/fd` |
| `~/.config/htop` | `misc/htop` |
| `~/.config/git` | `misc/git` |
| `~/.config/messauto` | `misc/messauto` |
| `~/.config/menus` | `misc/menus` |
| `~/.config/joshuto` | `misc/joshuto` |
| `~/.config/configstore` | `misc/configstore` |

## .gitignore 追加

```gitignore
# 敏感文件
secrets/env
secrets/ssh/id_ed25519
secrets/ssh/known_hosts*

# 运行时/缓存（如果不小心放进来）
*.swp
*.swo
```

## 执行顺序

1. 先备份：`cp -r ~/Documents/sync ~/Documents/sync.bak`
2. 创建新目录结构
3. 移动文件
4. 创建 symlink
5. 验证所有 symlink 正常
6. 更新 `.gitignore`
7. git commit + push
8. 更新 Augment 索引

## 风险点

- karabiner：需确认 sync 里的和 .config 里的是否一致，避免覆盖
- `.ssh/`：私钥绝不进 git，只管 pub + config
- 部分应用重启后可能不认 symlink（极少见，遇到再处理）
