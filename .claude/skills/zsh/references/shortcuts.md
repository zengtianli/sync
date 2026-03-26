# Zsh 快捷键参考

## 全局快捷键

| 快捷键 | 功能 | 实现位置 |
|--------|------|----------|
| `Ctrl+G` | LazyGit | mappings.zsh |
| `Ctrl+O` | 打开 Finder | mappings.zsh |
| `Ctrl+P` | FZF 文件搜索 | fzf.zsh |
| `Ctrl+F` | FZF 内容搜索 | fzf.zsh |
| `Ctrl+T` | FZF 目录切换 | fzf.zsh |
| `Ctrl+R` | FZF 历史搜索 | fzf.zsh |

## 常用别名

| 别名 | 命令 | 功能 |
|------|------|------|
| `rl` | `source ~/.zshrc` | 重载配置 |
| `lg` | `lazygit` | Git 界面 |
| `ra` | `yazi` | 文件管理器 |
| `ex` | `export all_proxy=...` | 设置代理 |
| `of` | `open -a Finder ./` | 打开 Finder |

## 现代工具

| 传统命令 | 现代替代 | 安装 |
|----------|----------|------|
| `ls` | `eza` | `brew install eza` |
| `cat` | `bat` | `brew install bat` |
| `find` | `fd` | `brew install fd` |
| `du` | `dust` | `brew install dust` |
| `top` | `btop` | `brew install btop` |
| `diff` | `delta` | `brew install git-delta` |

## 同步命令

| 命令 | 功能 |
|------|------|
| `sync-status` | 查看同步状态 |
| `sync-all` | 同步所有配置 |
| `sync-watch` | 监控配置变化 |
| `sync-list` | 列出同步配置 |
