# Unified Conda Configuration - 统一Conda配置
# 支持eager和lazy两种加载模式
# 通过环境变量 ZSH_CONDA_MODE 控制加载方式

# 默认模式为lazy（延迟加载）- 优化启动速度
ZSH_CONDA_MODE="${ZSH_CONDA_MODE:-lazy}"

case "$ZSH_CONDA_MODE" in
  "eager")
    # Eager Loading - 即时加载模式
    # 在shell启动时立即初始化Conda和Mamba，激活base环境
    
    __conda_setup="$('/Users/tianli/miniforge3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/tianli/miniforge3/etc/profile.d/conda.sh" ]; then
            . "/Users/tianli/miniforge3/etc/profile.d/conda.sh"
        fi
        export PATH="/Users/tianli/miniforge3/bin:$PATH"
    fi
    unset __conda_setup

    # Initialize Mamba as well
    if [ -f "/Users/tianli/miniforge3/etc/profile.d/mamba.sh" ]; then
        . "/Users/tianli/miniforge3/etc/profile.d/mamba.sh"
    fi
    ;;
    
  "lazy")
    # Lazy Loading - 延迟加载模式
    # 只有在第一次调用conda命令时才进行初始化，优化shell启动速度
    
    conda() {
        # Remove this placeholder function to avoid recursive calls
        unfunction conda

        # Perform the actual Conda/Mamba initialization
        __conda_setup="$('/Users/tianli/miniforge3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/Users/tianli/miniforge3/etc/profile.d/conda.sh" ]; then
                . "/Users/tianli/miniforge3/etc/profile.d/conda.sh"
            fi
            export PATH="/Users/tianli/miniforge3/bin:$PATH"
        fi
        unset __conda_setup

        # Initialize Mamba as well
        if [ -f "/Users/tianli/miniforge3/etc/profile.d/mamba.sh" ]; then
            . "/Users/tianli/miniforge3/etc/profile.d/mamba.sh"
        fi

        # Execute the original command with all its arguments
        conda "$@"
    }
    ;;
    
  *)
    echo "⚠️  未知的Conda模式: $ZSH_CONDA_MODE"
    echo "💡 支持的模式: eager, lazy"
    echo "💡 当前使用默认eager模式"
    ZSH_CONDA_MODE="eager"
    # 递归调用以使用eager模式
    source "${(%):-%x}"
    ;;
esac

# 提供模式切换函数
toggle_conda_mode() {
  if [[ "$ZSH_CONDA_MODE" == "eager" ]]; then
    export ZSH_CONDA_MODE="lazy"
    echo "🔄 Conda模式已切换为: lazy (延迟加载)"
    echo "💡 重新加载配置生效: rl"
  else
    export ZSH_CONDA_MODE="eager"
    echo "🔄 Conda模式已切换为: eager (即时加载)"  
    echo "💡 重新加载配置生效: rl"
  fi
}

# 显示当前Conda配置状态
conda_status() {
  echo "🐍 Conda配置状态:"
  echo "==================="
  echo "📋 加载模式: $ZSH_CONDA_MODE"
  
  if command -v conda &> /dev/null; then
    echo "✅ Conda已加载"
    echo "📍 Conda版本: $(conda --version)"
    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
      echo "🌍 当前环境: $CONDA_DEFAULT_ENV"
    else
      echo "🌍 当前环境: 无激活环境"
    fi
  else
    echo "⏳ Conda未加载 (lazy模式将在首次使用时加载)"
  fi
  
  if command -v mamba &> /dev/null; then
    echo "⚡ Mamba已可用: $(mamba --version | head -1)"
  else
    echo "❌ Mamba不可用"
  fi
  
  echo ""
  echo "💡 切换模式: toggle_conda_mode"
} 