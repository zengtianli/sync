#!/bin/bash
# Zsh 配置检查脚本
# 检查现代工具是否安装、配置是否正确

set -euo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok() { echo -e "${GREEN}[✓]${NC} $1"; }
fail() { echo -e "${RED}[✗]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

echo "=== Zsh 配置检查 ==="
echo ""

# 检查 Zsh
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/local/bin/zsh" ]; then
    ok "默认 Shell: Zsh"
else
    warn "默认 Shell 不是 Zsh: $SHELL"
fi

# 检查软链接
if [ -L ~/.zshrc ]; then
    ok "~/.zshrc 是软链接"
else
    warn "~/.zshrc 不是软链接"
fi

echo ""
echo "=== 现代工具检查 ==="

tools=(
    "eza:ls 替代"
    "bat:cat 替代"
    "fd:find 替代"
    "dust:du 替代"
    "btop:top 替代"
    "delta:diff 替代"
    "fzf:模糊搜索"
    "rg:ripgrep 搜索"
    "lazygit:Git 界面"
    "yazi:文件管理器"
)

for item in "${tools[@]}"; do
    cmd="${item%%:*}"
    desc="${item#*:}"
    if command -v "$cmd" &>/dev/null; then
        ok "$cmd ($desc)"
    else
        fail "$cmd ($desc) - brew install $cmd"
    fi
done

echo ""
echo "=== FZF 配置检查 ==="

if [ -f ~/.fzf.zsh ]; then
    ok "FZF Zsh 集成已安装"
else
    warn "FZF Zsh 集成未安装 - 运行 $(brew --prefix)/opt/fzf/install"
fi
