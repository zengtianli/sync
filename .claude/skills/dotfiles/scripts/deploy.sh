#!/bin/bash
# 配置部一键部署脚本
# 用法: ./deploy.sh [--backup]

set -euo pipefail

SYNC_DIR="$HOME/Documents/sync"
BACKUP_DIR="$HOME/.config-backup/$(date +%Y%m%d_%H%M%S)"

# 颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

# 备份函数
backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
        warn "已备份: $target → $BACKUP_DIR/"
    fi
}

# 创建软链接
link_config() {
    local src="$1"
    local dest="$2"

    if [ "$BACKUP" = true ]; then
        backup_if_exists "$dest"
    fi

    rm -rf "$dest" 2>/dev/null || true
    ln -sf "$src" "$dest"
    log "链接: $src → $dest"
}

# 参数解析
BACKUP=false
[ "${1:-}" = "--backup" ] && BACKUP=true

# 确保目录存在
mkdir -p ~/.config

# 部署配置
link_config "$SYNC_DIR/nvim" ~/.config/nvim
link_config "$SYNC_DIR/zsh/zshrc" ~/.zshrc
link_config "$SYNC_DIR/zsh/zimrc" ~/.zimrc
link_config "$SYNC_DIR/yabai/config" ~/.config/yabai
link_config "$SYNC_DIR/karabiner" ~/.config/karabiner
link_config "$SYNC_DIR/yazi" ~/.config/yazi
link_config "$SYNC_DIR/hammerspoon" ~/.hammerspoon

echo ""
log "部署完成！"
[ "$BACKUP" = true ] && [ -d "$BACKUP_DIR" ] && log "备份目录: $BACKUP_DIR"
