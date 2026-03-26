# Modern Tools Configuration - 现代命令行工具配置
# 控制是否启用现代工具（默认启用）
ZSH_USE_MODERN_TOOLS="${ZSH_USE_MODERN_TOOLS:-true}"

if [[ "$ZSH_USE_MODERN_TOOLS" == "true" ]]; then
  # ============================================================================
  # Phase 1: 核心工具替换 (保持向后兼容)
  # ============================================================================
  
  # 文件系统操作工具
  if command -v eza &> /dev/null; then
    alias ll="eza -l --icons --group-directories-first"
    alias la="eza -la --icons --group-directories-first"
    alias lt="eza -T -L 2 --icons"  # 树形显示2层
    alias lsg="eza -l --git --icons"  # 显示Git状态
    # 保留原始ls别名
    alias oldls="ls"
  fi

  if command -v bat &> /dev/null; then
    # alias cat="bat"
    alias oldcat="/bin/cat"
    # 配置bat作为默认pager
    export PAGER="bat"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  fi

  if command -v fd &> /dev/null; then
    # fd 有不同的语法，不直接替代find
    alias oldfind="/usr/bin/find"
    # 提供fd的便捷使用方式，但不替代find
    fdf() { 
      # 如果第一个参数包含通配符，自动添加-g选项
      if [[ "$1" == *"*"* ]] || [[ "$1" == *"?"* ]]; then
        fd -g "$@"
      else
        fd "$@"
      fi
    }
  fi

  if command -v dust &> /dev/null; then
    alias du="dust"
    alias olddu="/usr/bin/du"
  fi

  if command -v duf &> /dev/null; then
    alias df="duf"
    alias olddf="/bin/df"
  fi

  # 系统监控工具
  if command -v procs &> /dev/null; then
    alias ps="procs"
    alias oldps="/bin/ps"
  fi

  if command -v btop &> /dev/null; then
    alias top="btop"
    alias oldtop="/usr/bin/top"
  fi

  # 文本处理工具
  if command -v sd &> /dev/null; then
    # sd 有不同的语法，不直接替代sed
    alias oldsed="/usr/bin/sed"
    # 提供sd的便捷使用方式
    sdr() { sd "$1" "$2" "${3:-.}"; }  # sd replace function
  fi

  # ============================================================================
  # Phase 2: 增强功能工具
  # ============================================================================
  
  # Git差异显示
  if command -v delta &> /dev/null; then
    # 配置delta作为git的pager
    alias diff="delta"
    alias olddiff="/usr/bin/diff"
    # Git配置将在git config中设置
  fi

  # HTTP客户端
  if command -v http &> /dev/null; then
    # httpie 有不同的语法，不直接替代curl
    alias oldcurl="/usr/bin/curl"
    # 提供httpie的便捷别名
    alias httpc="http"  # httpie client
  fi

  # DNS查询
  if command -v dog &> /dev/null; then
    alias dig="dog"
    alias olddig="/usr/bin/dig"
  fi

  # JSON/YAML处理 (jq已存在，添加yq)
  if command -v yq &> /dev/null; then
    # yq已安装，添加便捷函数
    yaml2json() { yq -o=json '.' "$1"; }
    json2yaml() { yq -P '.' "$1"; }
  fi

  # 命令输出转JSON
  if command -v jc &> /dev/null; then
    # 添加常用的jc组合
    psj() { ps aux | jc --ps; }
    dfj() { df -h | jc --df; }
    lsj() { ls -la | jc --ls; }
  fi

  # ============================================================================
  # 经典别名配置 (从aliases.zsh合并)
  # ============================================================================
  
  # 代理设置已移至 proxy.zsh
  
  # smart_vim 函数：智能创建目录并打开文件
  smart_vim() { mkdir -p "$(dirname "$1")"; nvim "$1" }

  # 常用工具别名
  alias lg=lazygit
  alias ra=yazi
  alias python=python3
  alias pip=pip3
  alias vim=smart_vim
  alias zzd='"/Applications/Wine Stable.app/Contents/Resources/wine/bin/wine" "/Users/tianli/.wine/drive_c/Program Files (x86)/DingTalkGov/main/current/DingTalkGov.exe"'  # 浙政钉
  
  # 文件操作相关
  alias rl="source ~/.zshrc"
  alias of='open -a Finder ./'
  
  # 指定路径的命令
  alias python3="/Users/tianli/miniforge3/bin/python3"

  # ============================================================================
  # Phase 3: 高级功能增强
  # ============================================================================
  
  # 任务运行器
  if command -v just &> /dev/null; then
    alias j="just"
    alias jl="just --list"
  fi

  # 基准测试
  if command -v hyperfine &> /dev/null; then
    alias bench="hyperfine"
  fi

  # 点对点文件传输
  if command -v croc &> /dev/null; then
    alias send="croc send"
    alias receive="croc"
  fi

  # 现代文件加密
  if command -v age &> /dev/null; then
    encrypt() { age -r "$1" -o "$2.age" "$2"; }
    decrypt() { age -d -i ~/.config/age/key.txt -o "${1%.age}" "$1"; }
  fi

  # ============================================================================
  # 现代工具函数
  # ============================================================================
  
  # 快速查看文件内容（带高亮）
  preview() {
    if command -v bat &> /dev/null; then
      bat --style=numbers --color=always "$1"
    else
      cat "$1"
    fi
  }

  # 目录占用分析
  disk_usage() {
    if command -v dust &> /dev/null; then
      dust -d 1 "${1:-.}"
    elif command -v ncdu &> /dev/null; then
      ncdu "${1:-.}"
    else
      du -sh "${1:-.}"/* | sort -hr
    fi
  }

  # 进程管理增强
  kill_process() {
    if command -v procs &> /dev/null && command -v fzf &> /dev/null; then
      local pid=$(procs | fzf | awk 'NR>1 {print $1}')
      if [[ -n "$pid" ]]; then
        kill -${1:-15} "$pid"
      fi
    else
      echo "需要安装 procs 和 fzf"
    fi
  }

  # ============================================================================
  # 文件和目录操作增强函数
  # ============================================================================

  # 智能文件查看 - 自动选择最佳查看工具
  view() {
    local file="$1"
    if [[ -z "$file" ]]; then
      echo "用法: view <文件名>"
      return 1
    fi
    
    if [[ ! -f "$file" ]]; then
      echo "文件不存在: $file"
      return 1
    fi
    
    # 根据文件类型选择查看工具
    case "${file##*.}" in
      json)
        if command -v jq &> /dev/null; then
          jq '.' "$file" | bat -l json
        elif command -v bat &> /dev/null; then
          bat -l json "$file"
        else
          cat "$file"
        fi
        ;;
      yml|yaml)
        if command -v yq &> /dev/null; then
          yq '.' "$file" | bat -l yaml
        elif command -v bat &> /dev/null; then
          bat -l yaml "$file"
        else
          cat "$file"
        fi
        ;;
      *)
        if command -v bat &> /dev/null; then
          bat "$file"
        else
          cat "$file"
        fi
        ;;
    esac
  }

  # 智能目录列表 - 根据内容选择最佳显示方式
  lsmart() {
    local dir="${1:-.}"
    
    if command -v eza &> /dev/null; then
      # 如果目录包含Git仓库，显示Git状态
      if [[ -d "$dir/.git" ]] || git -C "$dir" rev-parse --git-dir &>/dev/null; then
        eza -la --git --icons --group-directories-first "$dir"
      else
        eza -la --icons --group-directories-first "$dir"
      fi
    else
      ls -la "$dir"
    fi
  }

  # 交互式文件查找和操作
  ff() {
    local action="${1:-view}"
    
    if ! command -v fd &> /dev/null || ! command -v fzf &> /dev/null; then
      echo "需要安装 fd 和 fzf: brew install fd fzf"
      return 1
    fi
    
    local file=$(fd --type f | fzf --preview 'bat --style=numbers --color=always {}' --header="[📁 选择文件进行 $action 操作]")
    
    if [[ -n "$file" ]]; then
      case $action in
        edit|e)
          nvim "$file"
          ;;
        view|v)
          view "$file"
          ;;
        copy|cp)
          if command -v pbcopy &> /dev/null; then
            cat "$file" | pbcopy
            echo "✅ 文件内容已复制到剪贴板: $file"
          else
            echo "❌ macOS剪贴板命令不可用"
          fi
          ;;
        delete|rm)
          echo -n "❓ 确认删除文件 '$file'? [y/N]: "
          read -r confirm
          if [[ "$confirm" =~ ^[Yy]$ ]]; then
            rm "$file"
            echo "✅ 已删除: $file"
          fi
          ;;
        *)
          echo "❌ 未知操作: $action"
          echo "支持的操作: edit, view, copy, delete"
          ;;
      esac
    fi
  }

  # ============================================================================
  # 系统监控和诊断函数
  # ============================================================================

  # 综合系统状态检查
  sysinfo() {
    echo "🖥️  系统信息概览"
    echo "===================="
    
    # 基本系统信息
    echo "📊 系统基本信息:"
    uname -a
    echo
    
    # CPU和内存使用情况
    echo "⚡ CPU和内存使用:"
    if command -v btop &> /dev/null; then
      echo "💡 运行 'btop' 查看详细的系统监控"
    else
      top -l 1 | head -10
    fi
    echo
    
    # 磁盘使用情况
    echo "💾 磁盘使用情况:"
    if command -v duf &> /dev/null; then
      duf
    else
      df -h
    fi
    echo
    
    # 网络连接
    echo "🌐 网络连接:"
    netstat -an | grep ESTABLISHED | wc -l | awk '{print "活跃连接数: " $1}'
    echo
    
    # 运行时间和负载
    echo "⏰ 系统运行时间:"
    uptime
  }

  # 快速性能诊断
  perf() {
    echo "🔍 快速性能诊断"
    echo "=================="
    
    # 高CPU进程
    echo "🔥 CPU使用率最高的5个进程:"
    if command -v procs &> /dev/null; then
      procs --sortd cpu | head -6
    else
      ps aux | sort -nrk 3,3 | head -6
    fi
    echo
    
    # 高内存进程
    echo "🧠 内存使用率最高的5个进程:"
    if command -v procs &> /dev/null; then
      procs --sortd memory | head -6
    else
      ps aux | sort -nrk 4,4 | head -6
    fi
    echo
    
    # 磁盘IO
    echo "💾 磁盘IO活动:"
    iostat -d 1 1 2>/dev/null || echo "iostat 不可用，请安装或检查磁盘活动"
  }

  # ============================================================================
  # 开发工具增强函数
  # ============================================================================

  # 智能项目初始化
  project_init() {
    local project_name="$1"
    local project_type="${2:-general}"
    
    if [[ -z "$project_name" ]]; then
      echo "用法: project_init <项目名> [类型]"
      echo "支持的类型: node, python, rust, go, general"
      return 1
    fi
    
    echo "🚀 初始化项目: $project_name (类型: $project_type)"
    
    # 创建项目目录
    mkdir -p "$project_name"
    cd "$project_name"
    
    # 初始化Git
    git init
    echo "# $project_name" > README.md
    
    # 根据项目类型创建基础文件
    case $project_type in
      node)
        npm init -y
        echo "node_modules/\n.env\n*.log" > .gitignore
        if command -v just &> /dev/null; then
          cat > justfile <<'EOF'
# 安装依赖
install:
    npm install

# 开发模式
dev:
    npm run dev

# 构建
build:
    npm run build

# 测试
test:
    npm test

# 清理
clean:
    rm -rf node_modules dist
EOF
        fi
        ;;
      python)
        echo "*.pyc\n__pycache__/\n.env\nvenv/\n.venv/" > .gitignore
        echo "# -*- coding: utf-8 -*-\n\ndef main():\n    print('Hello, $project_name!')\n\nif __name__ == '__main__':\n    main()" > main.py
        if command -v just &> /dev/null; then
          cat > justfile <<'EOF'
# 创建虚拟环境
venv:
    python3 -m venv venv
    source venv/bin/activate && pip install --upgrade pip

# 安装依赖
install:
    pip install -r requirements.txt

# 运行
run:
    python main.py

# 测试
test:
    pytest

# 清理
clean:
    rm -rf __pycache__ .pytest_cache *.pyc
EOF
        fi
        touch requirements.txt
        ;;
      *)
        echo "*.tmp\n*.log\n.env" > .gitignore
        ;;
    esac
    
    # 提交初始版本
    git add .
    git commit -m "Initial commit"
    
    echo "✅ 项目 '$project_name' 初始化完成!"
    echo "📁 位置: $(pwd)"
    lsmart
  }

  # 快速HTTP服务器
  serve() {
    local port="${1:-8000}"
    local dir="${2:-.}"
    
    echo "🌐 启动HTTP服务器..."
    echo "📁 目录: $(realpath $dir)"
    echo "🔗 地址: http://localhost:$port"
    echo "⏹️  按 Ctrl+C 停止服务器"
    echo
    
    if command -v python3 &> /dev/null; then
      cd "$dir" && python3 -m http.server "$port"
    elif command -v python &> /dev/null; then
      cd "$dir" && python -m SimpleHTTPServer "$port"
    else
      echo "❌ 需要Python来运行HTTP服务器"
      return 1
    fi
  }

  # ============================================================================
  # 网络和连接工具
  # ============================================================================

  # 智能网络诊断
  netcheck() {
    local target="${1:-google.com}"
    
    echo "🌐 网络连接诊断: $target"
    echo "========================="
    
    # DNS解析
    echo "🔍 DNS解析:"
    if command -v dog &> /dev/null; then
      dog "$target" A
    else
      nslookup "$target"
    fi
    echo
    
    # Ping测试
    echo "📡 连通性测试:"
    if command -v gping &> /dev/null; then
      echo "💡 运行 'gping $target' 查看图形化延迟"
      ping -c 4 "$target"
    else
      ping -c 4 "$target"
    fi
    echo
    
    # 路由追踪
    echo "🛣️  路由追踪:"
    traceroute "$target" 2>/dev/null || echo "traceroute 不可用"
  }

  # 端口扫描
  portscan() {
    local host="${1:-localhost}"
    local port_range="${2:-1-1000}"
    
    echo "🔍 端口扫描: $host (端口范围: $port_range)"
    
    if command -v nmap &> /dev/null; then
      nmap -p "$port_range" "$host"
    else
      echo "❌ 需要安装 nmap: brew install nmap"
      echo "💡 或使用简单的端口检查:"
      echo "nc -z $host 22 80 443 8080"
    fi
  }

  # ============================================================================
  # 数据处理和转换函数
  # ============================================================================

  # JSON格式化和查询
  jf() {
    local file="$1"
    local query="$2"
    
    if [[ -z "$file" ]]; then
      echo "用法: jf <文件或URL> [jq查询]"
      echo "示例: jf data.json '.users[] | select(.active)'"
      return 1
    fi
    
    if ! command -v jq &> /dev/null; then
      echo "❌ 需要安装 jq: brew install jq"
      return 1
    fi
    
    # 支持URL和文件
    if [[ "$file" =~ ^https?:// ]]; then
      if command -v http &> /dev/null; then
        if [[ -n "$query" ]]; then
          http "$file" | jq "$query"
        else
          http "$file" | jq '.'
        fi
      else
        curl -s "$file" | jq "${query:-.}"
      fi
    else
      if [[ -n "$query" ]]; then
        jq "$query" "$file"
      else
        jq '.' "$file"
      fi
    fi | bat -l json
  }

  # CSV查看和处理
  csv() {
    local file="$1"
    local action="${2:-view}"
    
    if [[ -z "$file" ]]; then
      echo "用法: csv <文件> [action]"
      echo "Actions: view, head, stats, query"
      return 1
    fi
    
    case $action in
      view)
        if command -v visidata &> /dev/null; then
          visidata "$file"
        elif command -v mlr &> /dev/null; then
          mlr --csv cat "$file" | head -20
        else
          head -20 "$file" | column -t -s ','
        fi
        ;;
      head)
        head -10 "$file"
        ;;
      stats)
        if command -v mlr &> /dev/null; then
          mlr --csv stats1 -a count,mean,min,max -f all "$file"
        else
          echo "❌ 需要安装 miller: brew install miller"
        fi
        ;;
      query)
        echo "请输入Miller查询表达式:"
        read -r query
        mlr --csv "$query" "$file"
        ;;
    esac
  }

  # ============================================================================
  # 便捷别名函数
  # ============================================================================

  # 快速编辑配置文件
  config() {
    local config_type="$1"
    
    case $config_type in
      zsh|zshrc)
        nvim ~/.zshrc
        ;;
      vim|nvim)
        nvim ~/.config/nvim/init.lua 2>/dev/null || nvim ~/.vimrc
        ;;
      git)
        nvim ~/.gitconfig
        ;;
      ssh)
        nvim ~/.ssh/config
        ;;
      modern|tools)
        nvim ~/Documents/sync/shell/config/tools/modern-cli.zsh
        ;;
      *)
        echo "可用配置:"
        echo "  zsh     - ZSH配置"
        echo "  vim     - Vim/Neovim配置"
        echo "  git     - Git配置"
        echo "  ssh     - SSH配置"
        echo "  modern  - 现代工具配置"
        ;;
    esac
  }

  # 快速备份重要文件 - 已迁移到 backup.sh
  # 使用: bash ~/Dev/scripts/system/backup/backup.sh
  # 或创建别名: alias backup='bash ~/Dev/scripts/system/backup/backup.sh'

  # ============================================================================
  # 重复文件检测工具 (czkawka_cli)
  # ============================================================================

  # 主命令: dup - 重复文件检测
  dup() {
    if ! command -v czkawka_cli &> /dev/null; then
      echo "❌ 需要安装 czkawka"
      echo "💡 安装: brew install czkawka"
      return 1
    fi

    local action="${1:-help}"
    shift 2>/dev/null
    local dir="${1:-.}"
    
    case $action in
      find|f)
        echo "🔍 查找重复文件: $dir"
        czkawka_cli dup -d "$dir"
        ;;
      rm|delete)
        echo "🗑️  删除重复文件 (保留最新): $dir"
        czkawka_cli dup -d "$dir" --delete-method AEN
        ;;
      size)
        echo "📊 查找大于1M的重复文件: $dir"
        czkawka_cli dup -d "$dir" -x 1048576
        ;;
      link)
        echo "🔗 用硬链接替换重复文件: $dir"
        czkawka_cli dup -d "$dir" --delete-method Hardlink
        ;;
      help|h|*)
        echo "🔍 dup - 重复文件检测 (czkawka_cli)"
        echo "===================================="
        echo ""
        echo "用法: dup <命令> [目录]"
        echo ""
        echo "命令:"
        echo "  find, f     查找重复文件"
        echo "  rm, delete  删除重复 (保留最新)"
        echo "  size        只找大于1M的重复"
        echo "  link        用硬链接替换重复"
        echo "  help, h     显示帮助"
        echo ""
        echo "示例:"
        echo "  dup f ~/Downloads"
        echo "  dup size ~/Pictures"
        echo "  dup rm ~/Downloads"
        echo ""
        echo "其他命令:"
        echo "  dupimg  查找相似图片"
        echo "  dupvid  查找相似视频"
        echo "  dupe    查找空文件/文件夹"
        echo "  dupbad  查找损坏文件/无效链接"
        ;;
    esac
  }

  # dupimg - 查找相似图片
  dupimg() {
    if ! command -v czkawka_cli &> /dev/null; then
      echo "❌ 需要安装 czkawka"; echo "💡 brew install czkawka"; return 1
    fi
    echo "🖼️  查找相似图片: ${1:-.}"
    czkawka_cli similar-images -d "${1:-.}"
  }

  # dupvid - 查找相似视频
  dupvid() {
    if ! command -v czkawka_cli &> /dev/null; then
      echo "❌ 需要安装 czkawka"; echo "💡 brew install czkawka"; return 1
    fi
    echo "🎬 查找相似视频: ${1:-.}"
    czkawka_cli similar-videos -d "${1:-.}"
  }

  # dupe - 查找空文件/空文件夹
  dupe() {
    if ! command -v czkawka_cli &> /dev/null; then
      echo "❌ 需要安装 czkawka"; echo "💡 brew install czkawka"; return 1
    fi
    local dir="${1:-.}"
    echo "📁 空文件夹:"
    czkawka_cli empty-folders -d "$dir"
    echo ""
    echo "📄 空文件:"
    czkawka_cli empty-files -d "$dir"
  }

  # dupbad - 查找损坏文件和无效链接
  dupbad() {
    if ! command -v czkawka_cli &> /dev/null; then
      echo "❌ 需要安装 czkawka"; echo "💡 brew install czkawka"; return 1
    fi
    local dir="${1:-.}"
    echo "🔗 查找无效符号链接:"
    czkawka_cli invalid-symlinks -d "$dir"
    echo ""
    echo "🗑️  查找损坏文件:"
    czkawka_cli broken-files -d "$dir"
  }

  # ============================================================================
  # 工具状态检查
  # ============================================================================
  
  # 检查现代工具安装状态
  check_modern_tools() {
    echo "🔍 现代工具安装状态检查:"
    echo "===================="
    
    local tools=(
      "eza:文件列表"
      "bat:文件查看"
      "fd:文件查找" 
      "dust:磁盘使用"
      "duf:磁盘信息"
      "procs:进程列表"
      "btop:系统监控"
      "sd:文本替换"
      "delta:差异显示"
      "dog:DNS查询"
      "gping:网络延迟"
      "httpie:HTTP客户端"
      "yq:YAML处理"
      "jc:JSON转换"
      "just:任务运行"
      "hyperfine:基准测试"
      "croc:文件传输"
      "age:文件加密"
      "czkawka_cli:重复文件检测"
    )
    
    for tool_info in "${tools[@]}"; do
      local tool="${tool_info%%:*}"
      local desc="${tool_info##*:}"
      if command -v "$tool" &> /dev/null; then
        echo "✅ $tool - $desc"
      else
        echo "❌ $tool - $desc (未安装)"
      fi
    done
    
    echo "===================="
    echo "💡 安装缺失工具: brew install <tool_name>"
  }

  # 安装推荐的现代工具
  install_modern_tools() {
    echo "🚀 安装推荐的现代工具..."
    local core_tools="eza bat fd dust duf procs btop sd git-delta dog gping httpie yq jc just hyperfine croc age czkawka"
    echo "执行: brew install $core_tools"
    brew install $core_tools
  }

  # Streamlit
  alias streamlit="/Users/tianli/miniforge3/bin/streamlit"

fi

# 提供快速切换功能
toggle_modern_tools() {
  if [[ "$ZSH_USE_MODERN_TOOLS" == "true" ]]; then
    export ZSH_USE_MODERN_TOOLS="false"
    echo "🔄 已切换到传统工具模式，请重新加载配置: rl"
  else
    export ZSH_USE_MODERN_TOOLS="true"
    echo "🔄 已切换到现代工具模式，请重新加载配置: rl"
  fi
}
