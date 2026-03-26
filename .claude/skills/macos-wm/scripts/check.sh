#!/bin/bash
# macOS 窗口管理工具检查脚本

set -euo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok() { echo -e "${GREEN}[✓]${NC} $1"; }
fail() { echo -e "${RED}[✗]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

echo "=== macOS 窗口管理检查 ==="
echo ""

# Yabai
echo "--- Yabai ---"
if command -v yabai &>/dev/null; then
    if pgrep -x yabai &>/dev/null; then
        ok "Yabai 运行中"
    else
        warn "Yabai 已安装但未运行"
    fi
else
    fail "Yabai 未安装 - brew install koekeishiya/formulae/yabai"
fi

# skhd
if command -v skhd &>/dev/null; then
    if pgrep -x skhd &>/dev/null; then
        ok "skhd 运行中"
    else
        warn "skhd 已安装但未运行"
    fi
else
    fail "skhd 未安装 - brew install koekeishiya/formulae/skhd"
fi

echo ""
echo "--- Hammerspoon ---"
if [ -d "/Applications/Hammerspoon.app" ]; then
    if pgrep -x Hammerspoon &>/dev/null; then
        ok "Hammerspoon 运行中"
    else
        warn "Hammerspoon 已安装但未运行"
    fi
else
    fail "Hammerspoon 未安装 - brew install --cask hammerspoon"
fi

# 检查配置软链接
if [ -L ~/.hammerspoon ]; then
    ok "Hammerspoon 配置已链接"
else
    warn "~/.hammerspoon 不是软链接"
fi

echo ""
echo "--- Karabiner ---"
if [ -d "/Applications/Karabiner-Elements.app" ]; then
    if pgrep -x karabiner_grabber &>/dev/null; then
        ok "Karabiner 运行中"
    else
        warn "Karabiner 已安装但未运行"
    fi
else
    fail "Karabiner 未安装 - brew install --cask karabiner-elements"
fi

# 检查配置软链接
if [ -L ~/.config/karabiner ]; then
    ok "Karabiner 配置已链接"
else
    warn "~/.config/karabiner 不是软链接"
fi
