# 配置部部署指南

## 软链接部署

### 一键部署脚本

```bash
#!/bin/bash
SYNC_DIR="$HOME/Documents/sync"

# Neovim
ln -sf "$SYNC_DIR/nvim" ~/.config/nvim

# Zsh
ln -sf "$SYNC_DIR/zsh/zshrc" ~/.zshrc
ln -sf "$SYNC_DIR/zsh/zimrc" ~/.zimrc

# Yabai
ln -sf "$SYNC_DIR/yabai/config" ~/.config/yabai

# Karabiner
ln -sf "$SYNC_DIR/karabiner" ~/.config/karabiner

# Yazi
ln -sf "$SYNC_DIR/yazi" ~/.config/yazi

# Hammerspoon
ln -sf "$SYNC_DIR/hammerspoon" ~/.hammerspoon
```

### 验证部署

```bash
# 检查软链接
ls -la ~/.config/nvim
ls -la ~/.zshrc
ls -la ~/.config/yabai
ls -la ~/.config/karabiner
ls -la ~/.config/yazi
ls -la ~/.hammerspoon
```

## 备份现有配置

```bash
# 备份目录
BACKUP_DIR="$HOME/.config-backup/$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"

# 备份现有配置
[ -e ~/.config/nvim ] && mv ~/.config/nvim "$BACKUP_DIR/"
[ -e ~/.zshrc ] && mv ~/.zshrc "$BACKUP_DIR/"
[ -e ~/.config/yabai ] && mv ~/.config/yabai "$BACKUP_DIR/"
```

## 依赖安装

```bash
# Homebrew 工具
brew install neovim lazygit yazi
brew install eza bat fd dust btop git-delta
brew install fzf ripgrep

# Yabai + skhd
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

# Karabiner
brew install --cask karabiner-elements

# Hammerspoon
brew install --cask hammerspoon
```
