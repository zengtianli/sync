# ZSH 配置功能全面汇总

这是一份详细的 ZSH 配置功能汇总，涵盖了所有快捷键、别名、自定义命令和高级功能。

## 📋 目录

- [快捷键绑定](#快捷键绑定)
- [命令别名](#命令别名)
- [🆕 现代化工具](#现代化工具)
- [FZF 模糊搜索功能](#fzf-模糊搜索功能)
- [自定义函数](#自定义函数)
- [环境变量配置](#环境变量配置)
- [Conda 环境管理](#conda-环境管理)
- [Git 配置](#git-配置)
- [同步脚本别名](#同步脚本别名)

---

## 🔐 快捷键绑定

### 全局快捷键

| 快捷键 | 功能描述 | 实现位置 |
|:-------|:---------|:---------|
| `Ctrl+G` | 打开 LazyGit | mappings.zsh |
| `Ctrl+O` | 在当前目录打开 Finder | mappings.zsh |
| `Ctrl+P` | FZF 文件查找并用 nvim 打开 | fzf.zsh |
| `Ctrl+F` | 文件内容搜索并用 nvim 打开 | fzf.zsh |
| `Ctrl+T` | FZF 目录切换 | fzf.zsh |
| `Ctrl+R` | FZF 历史命令搜索 | fzf.zsh |

### Vim 模式键绑定

- 使用 `bindkey -v` 启用 Vim 模式导航
- 支持历史搜索键绑定

---

## 📝 命令别名

### 代理与网络

| 别名 | 命令 | 功能描述 |
|:-----|:-----|:---------|
| `ex` | `export all_proxy=127.0.0.1:6152` | 设置全局代理 |

### 常用工具

| 别名 | 命令 | 功能描述 |
|:-----|:-----|:---------|
| `lg` | `lazygit` | Git 可视化界面 |
| `ra` | `yazi` | 终端文件管理器 |
| `vim` | `smart_vim` | 智能 Vim 启动函数 |

### Python 环境

| 别名 | 命令 | 功能描述 |
|:-----|:-----|:---------|
| `python` | `python3` | 默认使用 Python3 |
| `pip` | `pip3` | 默认使用 pip3 |
| `python3` | `/Users/tianli/miniforge3/bin/python3` | 指定 Python3 路径 |

### 文件操作

| 别名 | 命令 | 功能描述 |
|:-----|:-----|:---------|
| `rl` | `source ~/.zshrc` | 重新加载 zshrc |
| `vc` | `nvim /Users/tianli/bendownloads/temp/copylist.txt` | 编辑复制列表 |
| `of` | `open -a Finder ./` | 在当前目录打开 Finder |

### 通用文件同步别名

| 别名 | 命令 | 功能描述 |
|:-----|:-----|:---------|
| `sync-status` | `/Users/tianli/obs/universal-sync.sh status` | 查看所有同步状态 |
| `sync-all` | `/Users/tianli/obs/universal-sync.sh sync --all` | 同步所有配置 |
| `sync-watch` | `/Users/tianli/obs/universal-sync.sh watch --all` | 监控所有配置变化 |
| `sync-list` | `/Users/tianli/obs/universal-sync.sh list` | 列出所有同步配置 |

---

## 🆕 现代化工具 (2024年8月重构升级)

### 📋 重构亮点

#### 🗑️ 清理冗余工具
- **删除了4个低价值工具**: `ffind`, `cani`, `fps`, `ffunctions`
- **合并functions目录**: 将`functions/modern_tools.zsh`的所有函数合并到`config/modern-tools.zsh`
- **文件结构精简**: 减少50%的FZF工具文件，提升维护效率

#### 🔄 升级现有工具
- **bip/bup/bcp**: 集成现代工具推荐和安全检查
- **kp**: 集成modern-proc，提供现代化进程管理
- **util**: 更新为重构后的工具总览

#### ✨ 新增高级函数
- **智能文件操作**: `view()`, `lsmart()`, `ff()`
- **系统诊断**: `sysinfo()`, `perf()`
- **开发工具**: `project_init()`, `serve()`, `config()`, `backup()`
- **网络工具**: `netcheck()`, `portscan()`
- **数据处理**: `jf()`, `csv()`

### 工具控制

| 命令 | 功能描述 |
|:-----|:---------|
| `check_modern_tools` | 检查现代工具安装状态 |
| `install_modern_tools` | 一键安装推荐的现代工具 |
| `toggle_modern_tools` | 切换现代/传统工具模式 |

### 文件系统操作 (现代化替代)

| 传统工具 | 现代替代 | 别名/函数 | 功能增强 |
|:---------|:---------|:-----|:---------|
| `ls` | `eza` | `ll`, `la`, `lt`, `lg`, `lsmart()` | 彩色图标、Git状态、树形显示、智能检测 |
| `cat` | `bat` | `cat`, `view()` | 语法高亮、行号、智能文件查看 |
| `find` | `fd` | `fdf()`, `ff()` | 直观语法、交互式文件操作 |
| `du` | `dust` | `du`, `modern-disk` | 可视化目录占用、交互式分析 |
| `df` | `duf` | `df` | 彩色表格磁盘信息 |

### 系统监控 (现代化替代)

| 传统工具 | 现代替代 | 别名/函数 | 功能增强 |
|:---------|:---------|:-----|:---------|
| `ps` | `procs` | `ps`, `modern-proc` | 彩色高亮、交互式进程管理 |
| `top` | `btop` | `top`, `sysinfo()`, `perf()` | 现代TUI、系统诊断函数 |

### 网络工具 (现代化替代)

| 传统工具 | 现代替代 | 别名/函数 | 功能增强 |
|:---------|:---------|:-----|:---------|
| `dig` | `dog` | `dig`, `netcheck()` | 友好输出、智能网络诊断 |
| `ping` | `gping` | `ping` | 图形化延迟曲线 |
| `curl` | `httpie` | `httpc`, `jf()` | 人类友好语法、JSON处理 |
| `nmap` | `nmap` | `portscan()` | 端口扫描封装函数 |

### 文本处理 (现代化替代)

| 传统工具 | 现代替代 | 别名/函数 | 功能增强 |
|:---------|:---------|:-----|:---------|
| `sed` | `sd` | `sdr()` | 现代语法、更安全 |
| `diff` | `delta` | `diff` | 语法高亮、Git友好 |

### 数据处理工具

| 工具 | 别名/函数 | 功能描述 |
|:-----|:---------|:---------|
| `jq` | `jf()` | JSON格式化查询（支持URL和文件） |
| `yq` | `yaml2json()`, `json2yaml()` | YAML/JSON互转 |
| `jc` | `psj()`, `dfj()`, `lsj()` | 命令输出转JSON |
| `miller` | `csv()` | CSV/TSV数据处理和查看 |

### 开发工具

| 工具 | 别名 | 功能描述 |
|:-----|:-----|:---------|
| `just` | `j`, `jl` | 任务运行器 |
| `hyperfine` | `bench` | 基准测试工具 |
| `delta` | - | Git差异高亮显示 |

### 安全和传输工具

| 工具 | 别名/函数 | 功能描述 |
|:-----|:---------|:---------|
| `croc` | `send`, `receive` | 点对点文件传输 |
| `age` | `encrypt`, `decrypt` | 现代文件加密 |

### 🎯 实际别名使用指南

#### ✅ 直接替换别名（语法兼容）
```bash
# 文件列表 (eza)
ll                    # eza -l --icons --group-directories-first
la                    # eza -la --icons --group-directories-first  
lt                    # eza -T -L 2 --icons (树形显示2层)
lg                    # eza -l --git --icons (显示Git状态)

# 文件查看 (bat)
cat file.txt          # bat file.txt (语法高亮)

# 系统监控 (procs/btop)
ps                    # procs (彩色进程列表)
top                   # btop (现代TUI界面)

# 磁盘信息 (dust/duf)
du                    # dust (可视化目录占用)
df                    # duf (彩色磁盘信息)

# 网络工具 (dog/gping)
dig example.com       # dog example.com (友好DNS查询)
ping example.com      # gping example.com (图形化延迟)

# Git差异 (delta)
diff file1 file2      # delta file1 file2 (语法高亮差异)
```

#### 🔧 专用函数（语法差异）
```bash
# 文件查找 (fd)
fdf "config"          # fd "config" (现代文件查找)
fdf -t f -e json      # 查找.json文件
fdf -t d              # 只查找目录
oldfind . -name "*.txt"  # 使用原始find

# 文本替换 (sd)
sdr "old" "new"       # sd "old" "new" . (当前目录所有文件)
sdr "old" "new" file.txt  # 指定文件替换
oldsed 's/old/new/g' file.txt  # 使用原始sed

# HTTP客户端 (httpie)
httpc GET api.example.com        # http GET api.example.com
httpc POST api.example.com key=value  # POST with data
oldcurl -X GET api.example.com   # 使用原始curl
```

#### 📋 保留原始工具访问
```bash
# 所有现代工具都保留了原始版本的访问方式
oldls       # 原始ls
oldcat      # 原始cat
oldfind     # 原始find
oldsed      # 原始sed
oldcurl     # 原始curl
oldps       # 原始ps
oldtop      # 原始top
olddu       # 原始du
olddf       # 原始df
olddig      # 原始dig
oldping     # 原始ping
olddiff     # 原始diff
```

---

## 🔍 FZF 模糊搜索功能

### 基本配置

- **默认选项**: 支持预览窗口、语法高亮、快捷键导航
- **默认命令**: 使用 `fd` 作为文件查找工具
- **完成触发器**: 使用 `\` 触发补全
- **TMUX 集成**: 支持在 TMUX 中使用，高度为 80%

### FZF 核心功能

| 功能 | 快捷键 | 描述 |
|:-----|:-------|:-----|
| 文件查找并编辑 | `Ctrl+P` | 使用 fd 查找文件，选择后用 nvim 打开 |
| 目录切换 | `Ctrl+T` | 查找目录并切换到选中目录 |
| 历史命令搜索 | `Ctrl+R` | 搜索历史命令并执行 |
| 文件内容搜索 | `Ctrl+F` | 在当前目录搜索文件内容，选择后用 nvim 打开 |

### FZF 专用命令

| 命令 | 功能描述 | 状态 |
|:-----|:---------|:-----|
| `fif <搜索词>` | 在文件内容中搜索，显示匹配文件并用 nvim 打开 | ✅ 活跃 |
| `fhistory` | 命令历史模糊搜索 | ✅ 活跃 |
| `fp` | 查找 PATH 中的可执行文件 | ✅ 活跃 |
| `kp` | 现代化进程终止器(集成procs) | 🔄 已升级 |
| `ks` | TCP 连接管理 | ✅ 活跃 |
| `bcp` | 智能Homebrew包清理(带安全检查) | 🔄 已升级 |
| `bip` | 增强Homebrew包安装(推荐现代工具) | 🔄 已升级 |
| `bup` | 智能Homebrew包更新(状态检查) | 🔄 已升级 |
| `util` | 显示所有实用命令和别名 | 🔄 已更新 |
| ~~`fps`~~ | ~~进程查找和管理~~ | ❌ 已删除 |
| ~~`cani`~~ | ~~CanIUse 功能查询~~ | ❌ 已删除 |
| ~~`ffind`~~ | ~~文件查找工具~~ | ❌ 已删除 |
| ~~`ffunctions`~~ | ~~函数列表~~ | ❌ 已删除 |

### 🆕 新增FZF工具

| 命令 | 功能描述 |
|:-----|:---------|
| `modern-disk` | 现代磁盘使用分析工具 |
| `modern-proc` | 现代进程管理工具 |
| `modern-git` | Git工具箱（集成delta、lazygit） |

---

## ⚙️ 自定义函数

### 核心函数

#### `smart_vim()`
```zsh
smart_vim() { mkdir -p "$(dirname "$1")"; nvim "$1" }
```
- **功能**: 智能启动 nvim，自动创建目标文件的父目录

#### `zle_eval()`
```zsh
zle_eval() { echo -en "\e[2K\r"; eval "$@"; zle redisplay }
```
- **功能**: 清除当前行并执行命令，刷新显示

#### `openlazygit()`
```zsh
openlazygit() { zle_eval lazygit }
```
- **功能**: 在终端中打开 LazyGit

#### `openfinder()`
```zsh
openfinder() { zle_eval "open -a Finder ./" }
```
- **功能**: 在当前目录打开 Finder

#### `gr()`
```zsh
function gr() {
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ $? -eq 0 && -d $git_root ]]; then
        cd "$git_root"
    else
        echo "Not in a git repository or could not find the git root."
    fi
}
```
- **功能**: 快速切换到 Git 仓库根目录

### 🆕 现代工具增强函数

#### 文件和目录操作

| 函数 | 功能描述 |
|:-----|:---------|
| `view()` | 智能文件查看（自动选择bat/jq/yq） |
| `lsmart()` | 智能目录列表（Git仓库显示状态） |
| `ff()` | 交互式文件查找和操作 |

#### 系统监控和诊断

| 函数 | 功能描述 |
|:-----|:---------|
| `sysinfo()` | 综合系统状态检查 |
| `perf()` | 快速性能诊断 |
| `netcheck()` | 智能网络连接诊断 |
| `portscan()` | 端口扫描工具 |

#### 开发工具

| 函数 | 功能描述 |
|:-----|:---------|
| `project_init()` | 智能项目初始化（支持多种类型） |
| `serve()` | 快速HTTP服务器 |
| `config()` | 快速编辑配置文件 |
| `backup()` | 快速备份重要文件 |

#### 数据处理

| 函数 | 功能描述 |
|:-----|:---------|
| `jf()` | JSON格式化和查询（支持URL） |
| `csv()` | CSV查看和处理 |

---

## 🌍 环境变量配置

### 系统核心变量

| 变量名 | 值 | 功能描述 |
|:-------|:---|:---------|
| `EDITOR` | `nvim` | 默认编辑器 |
| `VISUAL` | `nvim` | 可视化编辑器 |
| `HISTSIZE` | `1000` | 内存中历史命令数量 |
| `SAVEHIST` | `1000` | 保存到文件的历史命令数量 |

### 🆕 现代工具环境变量

| 变量名 | 值 | 功能描述 |
|:-------|:---|:---------|
| `ZSH_USE_MODERN_TOOLS` | `true/false` | 控制是否启用现代工具 |
| `PAGER` | `bat` | 默认分页器（启用现代工具时） |
| `MANPAGER` | `bat` | man页面查看器 |

### 开发环境变量

| 变量名 | 值 | 功能描述 |
|:-------|:---|:---------|
| `GOPATH` | `$HOME/go` | Go 语言工作空间 |
| `NVM_DIR` | `$HOME/.config/nvm` | Node.js 版本管理器目录 |
| `PNPM_HOME` | `/Users/tianli/Library/pnpm` | PNPM 包管理器路径 |
| `XDG_CONFIG_HOME` | `$HOME/.config` | XDG 配置目录 |

### LLVM 编译环境

| 变量名 | 值 | 功能描述 |
|:-------|:---|:---------|
| `CC` | `/opt/homebrew/opt/llvm/bin/clang` | C 编译器 |
| `CXX` | `/opt/homebrew/opt/llvm/bin/clang++` | C++ 编译器 |
| `LDFLAGS` | `-L/opt/homebrew/opt/llvm/lib` | 链接器标志 |
| `CPPFLAGS` | `-I/opt/homebrew/opt/llvm/include` | C++ 预处理器标志 |

### API 密钥

| 变量名 | 功能描述 |
|:-------|:---------|
| `GROQ_API_KEY` | Groq AI API 密钥 |
| `OPENAI_API_KEY` | OpenAI API 密钥 |

### 代理设置

| 变量名 | 值 | 功能描述 |
|:-------|:---|:---------|
| `all_proxy` | `127.0.0.1:6152` | 全局代理设置 |

---

## 🐍 Conda 环境管理

### 可切换的加载模式

通过 `zshrc` 文件顶部的 `ZSH_CONDA_MODE` 变量，您可以轻松切换 Conda 的加载模式：

- **`ZSH_CONDA_MODE="lazy"` (默认)**
  - **配置文件**: `config/conda_lazy.zsh`
  - **功能**: Zsh 启动时不激活 Conda，只有在首次调用 `conda` 命令时才加载其环境，启动速度快。

- **`ZSH_CONDA_MODE="eager"`**
  - **配置文件**: `config/conda_eager.zsh`
  - **功能**: Zsh 启动时立即加载并激活 Conda 的 `base` 环境，方便直接进入开发。

---

## 🔧 Git 配置

### Git 别名前缀

- 使用 `g` 作为 Git 命令别名前缀
- 配置: `zstyle ':zim:git' aliases-prefix 'g'`

### 🆕 现代Git工具集成

| 工具 | 配置说明 |
|:-----|:---------|
| `delta` | 自动配置为Git的core.pager，提供语法高亮差异显示 |
| `lazygit` | 通过modern-git脚本快速启动 |

### 终端标题

- 显示当前目录名: `zstyle ':zim:termtitle:precmd' format '%1~'`

---

## 🔄 同步脚本别名

### 通用文件同步

| 别名 | 功能 | 描述 |
|:-----|:-----|:-----|
| `sync-status` | 查看状态 | 显示所有配置的同步状态 |
| `sync-all` | 同步所有 | 同步所有配置文件 |
| `sync-watch` | 监控所有 | 监控所有配置文件变化 |
| `sync-list` | 列出配置 | 列出所有可同步的配置 |

---

## 🚀 ZIM 框架集成

### 加载的模块

| 模块名 | 功能描述 |
|:-------|:---------|
| `environment` | 环境变量管理 |
| `git` | Git 增强功能 |
| `input` | 输入配置 |
| `utility` | 实用工具 |
| `git-info` | Git 状态信息 |
| `prompt-pwd` | 提示符路径显示 |
| `magicmace` | 提示符主题 |
| `zsh-users/zsh-completions` | 自动补全增强 |
| `zsh-users/zsh-autosuggestions` | 命令建议 |
| `zsh-users/zsh-history-substring-search` | 历史子字符串搜索 |
| `zdharma-continuum/fast-syntax-highlighting` | 语法高亮 |
| `hlissner/zsh-autopair` | 自动配对 |
| `supercrabtree/k` | 目录列表增强 |
| `agkozak/zsh-z` | 智能目录跳转 |
| `Aloxaf/fzf-tab` | FZF 标签补全 |

---

## 🔍 第三方工具集成

### 已集成工具

| 工具 | 功能 | 配置位置 |
|:-----|:-----|:---------|
| **LazyGit** | Git 可视化界面 | `config/mappings.zsh` |
| **Yazi** | 终端文件管理器 | `config/aliases.zsh` |
| **Todoist** | 任务管理 | `config/aliases.zsh` + 专用函数 |
| **FZF** | 模糊搜索 | `config/fzf.zsh` + `fzf/*` |
| **Zoxide** | 智能目录跳转 | `zshrc` |
| **NVM** | Node.js 版本管理 | `config/env.zsh` |
| **Amazon Q** | AI 助手 | `zshrc` 钩子 |

### 🆕 新集成的现代工具

| 工具 | 功能 | 安装命令 |
|:-----|:-----|:---------|
| **eza** | 现代ls替代 | `brew install eza` |
| **bat** | 现代cat替代 | `brew install bat` |
| **fd** | 现代find替代 | `brew install fd` |
| **dust** | 现代du替代 | `brew install dust` |
| **duf** | 现代df替代 | `brew install duf` |
| **procs** | 现代ps替代 | `brew install procs` |
| **btop** | 现代top替代 | `brew install btop` |
| **sd** | 现代sed替代 | `brew install sd` |
| **delta** | Git差异高亮 | `brew install git-delta` |
| **dog** | 现代dig替代 | `brew install dog` |
| **gping** | 图形化ping | `brew install gping` |
| **httpie** | 现代curl替代 | `brew install httpie` |
| **yq** | YAML处理 | `brew install yq` |
| **jc** | 命令输出转JSON | `brew install jc` |
| **just** | 任务运行器 | `brew install just` |
| **hyperfine** | 基准测试 | `brew install hyperfine` |
| **croc** | 文件传输 | `brew install croc` |
| **age** | 文件加密 | `brew install age` |

---

## 📊 性能优化

### 启动优化

1. **Conda 延迟加载**: 首次使用时才初始化
2. **补全缓存**: 使用 zcompdump 缓存加速补全
3. **条件加载**: 仅在文件存在时才加载配置
4. **🆕 现代工具条件检查**: 只有工具存在时才创建别名

### 内存优化

1. **历史记录限制**: HISTSIZE=1000，SAVEHIST=1000
2. **模块选择性加载**: 仅加载必要的 ZIM 模块
3. **路径去重**: 智能处理 PATH 变量
4. **🆕 智能工具选择**: 根据可用性自动选择最佳工具

---

## 🎯 使用建议

### 新手入门

1. 先熟悉基本快捷键：`Ctrl+G`（LazyGit）、`Ctrl+P`（文件搜索）
2. 使用 `util` 命令查看所有可用功能
3. 通过 `rl` 快速重载配置
4. **🆕 运行 `check_modern_tools` 检查工具安装状态**

### 现代工具使用

1. **工具检查**: 使用 `check_modern_tools` 查看安装状态
2. **一键安装**: 使用 `install_modern_tools` 安装推荐工具
3. **模式切换**: 使用 `toggle_modern_tools` 在新旧工具间切换
4. **智能函数**: 尝试 `view`, `lsmart`, `ff` 等增强函数

### 高级用法

1. 使用 `tagsearch` 进行基于标签的文件搜索
2. 利用 FZF 的各种专用命令提高效率
3. 配置同步脚本保持多环境一致性
4. **🆕 使用 `modern-git` 获得增强的Git体验**
5. **🆕 使用 `project_init` 快速创建标准化项目**

### 自定义扩展

1. 在 `config/aliases.zsh` 中添加个人别名
2. 在 `functions/` 目录下添加自定义函数
3. 修改 `config/modern-tools.zsh` 调整现代工具配置
4. **🆕 设置 `ZSH_USE_MODERN_TOOLS` 环境变量控制工具行为**

---

## 📁 文件结构

```
zsh/
├── zshrc                    # 主配置文件,负责加载所有模块
├── zimrc                    # ZIM 框架模块配置
├── config/                  # 存放所有模块化配置
│   ├── aliases.zsh          # 命令别名
│   ├── modern-tools.zsh     # 🆕 现代工具配置
│   ├── conda_eager.zsh      # Conda 即时加载
│   ├── conda_lazy.zsh       # Conda 延迟加载
│   ├── fzf.zsh              # FZF 核心配置
│   └── mappings.zsh         # 键盘映射和快捷键
├── functions/               # 自定义函数目录
│   ├── cd_git_root.zsh      # Git 根目录切换
│   └── modern_tools.zsh     # 🆕 现代工具实用函数
└── fzf/                     # FZF 专用功能脚本
    ├── util                 # 工具总览（已更新）
    ├── fhistory             # 历史搜索
    ├── modern-disk          # 🆕 现代磁盘管理
    ├── modern-proc          # 🆕 现代进程管理
    ├── modern-git           # 🆕 Git工具箱
    └── ...                  # 其他 FZF 工具
```

---

## 🔧 维护和更新

### 配置重载

- 使用 `rl` 别名快速重载配置
- 修改配置后立即生效

### 🆕 现代工具管理

- 使用 `check_modern_tools` 检查工具状态
- 使用 `install_modern_tools` 批量安装工具
- 使用 `toggle_modern_tools` 切换工具模式

### 同步管理

- 使用 `sync-*` 系列命令管理通用配置同步

### 故障排除

1. 检查环境变量：`env | grep -E "(PATH|EDITOR|HOME)"`
2. 验证 FZF 功能：`which fzf`
3. 测试快捷键绑定：`bindkey | grep -E "(ctrl|^)"`
4. **🆕 检查现代工具**: `check_modern_tools`

---

## 🎉 更新亮点

### 新增功能

✅ **现代工具集成**: 支持18种现代命令行工具  
✅ **渐进式升级**: 保持向后兼容的同时引入现代功能  
✅ **智能工具选择**: 根据安装情况自动选择最佳工具  
✅ **增强FZF集成**: 新增3个专用现代工具FZF脚本  
✅ **实用函数扩展**: 新增20+个增强函数  
✅ **一键安装**: 支持批量安装推荐工具  
✅ **灵活控制**: 通过环境变量控制现代工具启用/禁用  

这个配置集合现在提供了一个高效、现代化的 ZSH 终端环境，既保持了原有功能的稳定性，又引入了最新的命令行工具生态，适合开发者日常使用和持续改进。 