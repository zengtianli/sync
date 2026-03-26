#!/bin/bash
# Neovim 健康检查脚本

set -euo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok() { echo -e "${GREEN}[✓]${NC} $1"; }
fail() { echo -e "${RED}[✗]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

echo "=== Neovim 配置检查 ==="
echo ""

# 检查 Neovim
if command -v nvim &>/dev/null; then
    version=$(nvim --version | head -1)
    ok "Neovim: $version"
else
    fail "Neovim 未安装"
    exit 1
fi

# 检查软链接
if [ -L ~/.config/nvim ]; then
    target=$(readlink ~/.config/nvim)
    ok "配置软链接: $target"
else
    warn "~/.config/nvim 不是软链接"
fi

# 检查依赖
echo ""
echo "=== 依赖检查 ==="

deps=(
    "rg:ripgrep (Telescope)"
    "fd:fd (Telescope)"
    "lazygit:LazyGit"
    "node:Node.js (LSP)"
    "npm:npm (LSP)"
)

for item in "${deps[@]}"; do
    cmd="${item%%:*}"
    desc="${item#*:}"
    if command -v "$cmd" &>/dev/null; then
        ok "$cmd - $desc"
    else
        fail "$cmd - $desc"
    fi
done

# 检查 lazy.nvim
echo ""
echo "=== 插件检查 ==="

if [ -d ~/.local/share/nvim/lazy ]; then
    count=$(ls ~/.local/share/nvim/lazy | wc -l | tr -d ' ')
    ok "lazy.nvim 插件目录: $count 个插件"
else
    warn "lazy.nvim 插件目录不存在"
fi

echo ""
echo "运行 :checkhealth 获取详细诊断"
