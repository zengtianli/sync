# Anthropic / Claude Code 配置
# 默认不 export 任何 ANTHROPIC_* 变量，保持环境干净
# Token 定义在 ~/.personal_env（_MMKG_BASE_URL, _ANTHROPIC_TOKEN_MAX, _ANTHROPIC_TOKEN_TRANSIT）

# Claude Code 别名
alias cla='claude --dangerously-skip-permissions'

# clap: 官方 Pro 直连（OAuth 登录态）
clap() {
  node --version >/dev/null 2>&1
  unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_API_KEY
  export ANTHROPIC_CURRENT_TOKEN="pro"
  echo "✓ 使用官方 Pro 账号（OAuth）启动 Claude Code"
  claude --dangerously-skip-permissions "$@"
}

# clam: 中转站 max token，不登录
clam() {
  node --version >/dev/null 2>&1
  export ANTHROPIC_BASE_URL="$_MMKG_BASE_URL"
  export ANTHROPIC_API_KEY="$_ANTHROPIC_TOKEN_MAX"
  unset ANTHROPIC_AUTH_TOKEN
  export ANTHROPIC_CURRENT_TOKEN="max"
  echo "✓ 使用 max token（中转站）启动 Claude Code"
  claude --dangerously-skip-permissions "$@"
}

# clat: 中转站 transit token，不登录
clat() {
  node --version >/dev/null 2>&1
  export ANTHROPIC_BASE_URL="$_MMKG_BASE_URL"
  export ANTHROPIC_API_KEY="$_ANTHROPIC_TOKEN_TRANSIT"
  unset ANTHROPIC_AUTH_TOKEN
  export ANTHROPIC_CURRENT_TOKEN="transit"
  echo "✓ 使用 transit token（中转站）启动 Claude Code"
  claude --dangerously-skip-permissions "$@"
}

# 默认 export MMKG_* 供脚本使用（不影响 Claude Code，CC 只认 ANTHROPIC_*）
export MMKG_BASE_URL="$_MMKG_BASE_URL"
export MMKG_AUTH_TOKEN="$_ANTHROPIC_TOKEN_MAX"
