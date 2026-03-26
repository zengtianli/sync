# ============================================================================
# PATH 管理
# ============================================================================

# 显式列出需要加入 PATH 的脚本目录（避免 docs/launchd 等被误加入）
DEV_SCRIPTS="$HOME/Dev/scripts"
SCRIPT_PATHS=(
    "$DEV_SCRIPTS"
    "$DEV_SCRIPTS/system"
    "$DEV_SCRIPTS/system/services"
    "$DEV_SCRIPTS/execute"
    "$DEV_SCRIPTS/execute/tools"
    "$DEV_SCRIPTS/execute/raycast"
    "$DEV_SCRIPTS/execute/compare"
    "$DEV_SCRIPTS/execute/macro"
)
EXECUTE_PATHS=$(IFS=:; echo "${SCRIPT_PATHS[*]}")

# 构建 PATH（移除 PNPM_HOME，避免与 npm 冲突）
export PATH="/usr/local/opt/w3m/bin:/usr/local/go/bin:$GOPATH/bin:/usr/local/opt/php/bin:/usr/local/opt/php/sbin:/opt/homebrew/opt/openjdk/bin:$DEV_SCRIPTS:${EXECUTE_PATHS}:/Users/tianli/.codeium/windsurf/bin:/opt/homebrew/opt/ruby/bin:/Users/tianli/.orbstack/bin:$PATH"

# PNPM 路径放到最后（如果需要 pnpm，但不干扰 npm 全局包）
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) export PATH="$PATH:$PNPM_HOME" ;; esac
