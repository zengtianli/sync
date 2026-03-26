# ============================================================================
# 核心环境变量配置
# ============================================================================

# Shell 历史
export HISTSIZE=1000
export SAVEHIST=1000

# Zim 框架
export ZIM_HOME="${ZDOTDIR:-${HOME}}/.zim"

# XDG 规范
export XDG_CONFIG_HOME="$HOME/.config"

# 编辑器
export EDITOR=nvim
export VISUAL=nvim

# 工具配置（NVM_DIR 在 zshrc 中设置，避免重复）
export GOPATH="$HOME/go"
export PNPM_HOME="/Users/tianli/Library/pnpm"
export SWIFT_TOOL="$HOME/swift"

# Claude Code 实验性功能
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
