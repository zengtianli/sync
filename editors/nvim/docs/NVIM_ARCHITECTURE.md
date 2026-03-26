# Neovim 配置架构文档

## 🎯 项目概览

本 Neovim 配置采用**高度统一化的模块架构**，通过**功能聚合**和**扁平化设计**实现了高效的配置管理。经过重构优化和插件精简，从原来的 80+ 个分散文件精简为 21 个核心文件，并通过精选插件生态系统，大幅提升了维护效率和加载性能。

### 核心特性
- **统一化设计**: 按功能聚合的集中配置管理
- **扁平化架构**: 简化目录结构，消除过度嵌套
- **高性能加载**: 减少文件 I/O，优化启动时间
- **开发工具集成**: LSP、Git、AI 助手等完整工具链
- **多语言支持**: JavaScript/TypeScript, Python, Lua, Markdown, C/C++ 等语言支持
- **智能导航**: 文件搜索、符号跳转、项目管理
- **健康检查**: 完善的故障诊断和修复机制

## 🏗️ 核心架构

```
nvim/
├── init.lua                    # 主入口文件
├── lua/
│   ├── config/                 # 配置模块 (21个核心文件)
│   │   ├── core/
│   │   │   └── options.lua     # 核心选项配置（含 Python provider）
│   │   ├── defaults.lua        # 默认配置加载器
│   │   ├── keymaps.lua         # 统一键位映射
│   │   ├── plugins.lua         # 统一插件管理 (45个插件)
│   │   ├── lsp.lua             # 统一LSP配置
│   │   ├── autocomplete.lua    # 统一自动补全配置
│   │   ├── telescope.lua       # 统一搜索配置
│   │   ├── ftplugin.lua        # 统一文件类型配置
│   │   ├── code_runner.lua     # 代码运行器
│   │   ├── markdown_utils.lua  # Markdown工具
│   │   └── text_utils.lua      # 文本处理工具
│   └── plugin/                 # 自定义插件
│       ├── compile_run.lua     # 编译运行工具
│       ├── ctrlu.lua           # 控制工具
│       ├── swap_ternary.lua    # 三元运算符交换
│       └── vertical_cursor_movement.lua # 垂直光标移动
├── default_config/             # 默认配置模板
└── cursor_for_qwerty.vim       # 光标配置
```

### 架构优势
- **75% 文件减少**: 从 80+ 文件精简至 21 个核心文件
- **零功能损失**: 保持所有原有功能完全不变
- **集中管理**: 相关功能统一配置，便于维护
- **性能提升**: 减少文件加载次数，优化启动时间
- **健康监控**: 完整的健康检查和故障排除机制

### 加载顺序
1. **核心选项** → 2. **键位映射** → 3. **插件系统** → 4. **工具模块**

## 📁 文件结构详解

### 主入口文件

#### `init.lua`
- **功能**: Neovim 主配置入口，负责加载所有配置模块
- **内容**: 简洁的模块加载逻辑，调用统一的配置加载器

### 统一配置模块 (`lua/config/`)

#### `core/options.lua` ⭐
- **功能**: 核心选项配置，包含重要的系统修复
- **包含内容**:
  - Python provider 配置 (修复健康检查错误)
  - 基础 UI 设置 (行号、光标、滚动等)
  - 搜索和缩进配置
  - 文件处理和性能优化设置
  - 现代化的 Vim 选项配置

#### `defaults.lua`
- **功能**: 统一配置加载器和协调中心
- **职责**: 
  - 按正确顺序加载所有核心配置模块
  - 处理加载错误和依赖关系
  - 机器特定配置管理

#### `keymaps.lua`
- **功能**: 统一键位映射配置中心
- **包含映射**:
  - 核心编辑键位 (基础编辑、快速移动、跳转)
  - 窗口管理 (切换、分割、调整大小)
  - 标签页管理
  - 文本处理工具
  - LSP 和开发工具快捷键
  - Operator 模式映射

#### `plugins.lua` ⭐
- **功能**: 统一插件管理中心 (45 个精选插件)
- **架构**: 内联 lazy.nvim 配置 + 分类组织的插件列表
- **插件分类**:
  - **UI 界面** (9个): colorscheme, statusline, tabline, scrollbar, notify
  - **编辑增强** (8个): comment, surround, multi-cursor, autopairs, move
  - **开发工具** (10个): lspconfig, treesitter, git, copilot, mason
  - **导航搜索** (5个): telescope, yazi, commander
  - **语言支持** (4个): markdown, csv
  - **自动补全** (5个): nvim-cmp, 补全源
  - **工具依赖** (4个): lazy, plenary, wilder
- **特性**: 延迟加载、条件加载、依赖管理、健康检查集成

#### `lsp.lua` ⭐
- **功能**: 统一 LSP 配置中心
- **支持语言**: Lua, JavaScript/TypeScript, HTML, JSON, C/C++, Python, Go, Rust 等
- **包含功能**:
  - Mason 包管理器配置
  - 各语言服务器配置 (lua_ls, ts_ls, clangd, pyright 等)
  - 文档和签名帮助功能
  - 格式化保存配置 (多种文件类型)
  - LSP 键位映射和诊断配置
  - 健康检查集成

#### `autocomplete.lua` ⭐
- **功能**: 统一自动补全配置
- **核心特性**:
  - nvim-cmp 配置
  - 语言特定补全排序 (Python)
  - 补全源配置 (LSP, buffer, path, nvim_lua)
  - 智能补全键位映射
  - 简化的补全项格式化 (移除 lspkind 依赖)

#### `telescope.lua` ⭐
- **功能**: 统一搜索和导航配置
- **包含组件**:
  - Telescope 核心配置和扩展
  - Commander.nvim 命令面板集成
  - FZF 集成和性能优化
  - 搜索键位映射和快捷操作
  - 项目文件和符号搜索

#### `ftplugin.lua` ⭐
- **功能**: 统一文件类型配置 (替换整个 ftplugin 目录)
- **支持语言**: C, C#, GraphML, Java, Markdown, Prisma, Racket, Swift, Text
- **配置方式**: 基于 autocmd 的统一管理
- **功能包含**:
  - 语言特定的缩进和制表符设置
  - 专用键位映射 (如 Markdown 的表格和格式化快捷键)
  - 编译和运行命令
  - 语法高亮和折叠配置

### 工具模块

#### `code_runner.lua`
- **功能**: 多语言代码运行和智能退出工具
- **支持语言**: Python, JavaScript, C++, Java, Rust 等
- **特性**: 智能编译检测、错误处理、后台运行
- **更新**: 移除 VimTeX 依赖，改用 pdflatex 处理 LaTeX

#### `markdown_utils.lua`
- **功能**: Markdown 文档处理和增强工具
- **特性**: 文档格式化、表格处理、TOC 生成
- **集成**: 与 markdown-preview.nvim 协同工作

#### `text_utils.lua`
- **功能**: 文本处理和编辑增强工具
- **包含**: 行号处理、空白清理、文本替换、格式化

### 自定义插件 (`lua/plugin/`)

#### `compile_run.lua`
- **功能**: 编译运行系统
- **特性**: 智能语言检测、编译链管理
- **更新**: LaTeX 支持改为使用 pdflatex

#### `swap_ternary.lua`
- **功能**: 三元运算符条件交换工具
- **快捷键**: `<leader>st`

#### `vertical_cursor_movement.lua`
- **功能**: 智能垂直光标移动
- **特性**: 上下文感知的垂直导航

#### `ctrlu.lua`
- **功能**: 控制和管理工具
- **特性**: 系统级操作快捷方式

## ⌨️ 快捷键大全

### Leader 键
- **Leader**: `<Space>` (空格键)

### 基础编辑

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `U` | N | 重做 | 替代 `<C-r>` |
| `S` | N | 保存文件 | 快速保存 |
| `Q` | N | 退出 | 快速退出 |
| `<M-j>` | N,V | 连接行 | 替代 `J` |
| `;` | N,V | 命令模式 | 替代 `:` |
| `Y` | V | 复制到系统剪贴板 | 系统剪贴板操作 |
| `` ` `` | N,V | 切换大小写 | 替代 `~` |

### 快速移动

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `K` | N,V | 向上快速移动 | 15 行向上 |
| `J` | N,V | 向下快速移动 | 15 行向下 |
| `W` | N,V | 向前快速移动单词 | 5 个单词向前 |
| `B` | N,V | 向后快速移动单词 | 5 个单词向后 |
| `H` | N,V,O | 行首 | 替代 `0` |
| `L` | N,V,O | 行尾 | 替代 `$` |

### 跳转和导航

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<C-i>` | N,V | 后退跳转 | 跳转历史后退 |
| `<C-o>` | N,V | 前进跳转 | 跳转历史前进 |
| `,.` | N,V | 匹配括号 | 替代 `%` |

### 选择和编辑

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `\v` | N | 选择到行尾 | 不包含换行符 |
| `,v` | N | 选择匹配括号内容 | 智能选择 |
| `<C-y>` | I | 插入大括号块 | 快速插入代码块 |
| `<C-a>` | I | 跳到行尾退出插入 | 快速定位 |

### 窗口管理

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<leader>w` | N | 切换窗口 | 窗口间切换 |
| `<leader>sk` | N | 切换到上方窗口 | 向上窗口 |
| `<leader>sj` | N | 切换到下方窗口 | 向下窗口 |
| `<leader>sh` | N | 切换到左侧窗口 | 向左窗口 |
| `<leader>sl` | N | 切换到右侧窗口 | 向右窗口 |
| `qf` | N | 关闭其他窗口 | 只保留当前 |

### 窗口分割

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `sk` | N | 上方分割 | 水平分割向上 |
| `sj` | N | 下方分割 | 水平分割向下 |
| `sh` | N | 左侧分割 | 垂直分割向左 |
| `sl` | N | 右侧分割 | 垂直分割向右 |

### 窗口大小调整

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<Up>` | N | 增加窗口高度 | +5 行 |
| `<Down>` | N | 减少窗口高度 | -5 行 |
| `<Left>` | N | 减少窗口宽度 | -5 列 |
| `<Right>` | N | 增加窗口宽度 | +5 列 |

### 标签页管理

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `tj` | N | 新建标签页 | 空白标签页 |
| `tJ` | N | 在新标签页打开当前缓冲区 | 复制到新标签 |
| `th` | N | 前一个标签页 | 向左切换 |
| `tl` | N | 后一个标签页 | 向右切换 |
| `tmh` | N | 标签页左移 | 移动标签页 |
| `tml` | N | 标签页右移 | 移动标签页 |

### 搜索和导航工具

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<C-p>` | N | 文件搜索 | Telescope 文件查找 |
| `<C-f>` | N,V | FZF 搜索 | 当前缓冲区搜索 |
| `<C-w>` | N | 缓冲区切换 | 打开的缓冲区 |
| `<C-h>` | N | 最近文件 | 历史文件 |
| `<C-q>` | N | 命令面板 | Commander |
| `<leader>rs` | N | 恢复上次搜索 | Telescope resume |
| `R` | N | 文件管理器 | Yazi |

### LSP 和代码导航

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<leader>h` | N | 显示文档 | Hover 文档 |
| `gd` | N | 跳转到定义 | 当前窗口 |
| `gD` | N | 在新标签页跳转到定义 | 新标签页 |
| `gi` | N | 跳转到实现 | 接口实现 |
| `go` | N | 跳转到类型定义 | 类型定义 |
| `gr` | N | 查找引用 | 所有引用 |
| `<leader>rn` | N | 重命名符号 | LSP 重命名 |
| `<leader>aw` | N | 代码动作 | Code Actions |
| `<leader>,` | N | 快速代码动作 | 快速修复 |

### 诊断和错误

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<leader>t` | N | 诊断面板 | Trouble |
| `<leader>-` | N | 上一个诊断 | 诊断导航 |
| `<leader>=` | N | 下一个诊断 | 诊断导航 |

### Git 版本控制

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<C-g>` | N | LazyGit | Git 界面 |
| `<leader>g-` | N | 上一个变更 | Git hunk 导航 |
| `<leader>g=` | N | 下一个变更 | Git hunk 导航 |
| `<leader>gb` | N | 显示 blame | Git blame |
| `<leader>gr` | N | 重置变更 | 重置 hunk |
| `<leader>l` | N | 预览变更 | 预览 hunk |
| `<leader>gi` | N | Git 状态 | Git status |

### AI 助手 (Copilot)

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<leader>go` | N | 打开 Copilot | Copilot 面板 |
| `<leader>ge` | N | 启用 Copilot | 启用建议 |
| `<leader>gd` | N | 禁用 Copilot | 禁用建议 |
| `<C-p>` | I | 获取建议 | 触发建议 |
| `<C-l>` | I | 下一个建议 | 切换建议 |
| `<C-h>` | I | 上一个建议 | 切换建议 |

### 代码编辑增强

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<C-j>` | N | 向下移动行 | 行移动 |
| `<C-k>` | N,I | 向上移动行/删除到行首 | 多功能键 |
| `<C-j>` | V | 向下移动块 | 块移动 |
| `<C-k>` | V | 向上移动块 | 块移动 |
| `s` | N | 替换操作 | Substitute |
| `sh` | N | 替换到词尾 | 快速替换 |
| `ss` | N | 替换整行 | 行替换 |
| `sI` | N | 替换到行尾 | 行尾替换 |

### 文本处理工具

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<leader>sw` | N | 切换自动换行 | Toggle wrap |
| `<leader><CR>` | N | 清除搜索高亮 | No highlight |
| `<leader>rv` | N | 删除无效行 | 清理文本 |
| `<leader>rb` | N | 删除空白行 | 清理空行 |
| `<leader>rl` | N | 删除行尾空格 | 清理空格 |
| `<leader>ro` | N | 删除注释行 | 清理注释 |
| `<leader>rk` | N,V | 删除多余空格 | 压缩空格 |
| `<leader>rq` | N,V | 删除引用标记 | 清理标记 |

### 实用工具

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<leader>v` | N | 代码大纲 | Vista |
| `<leader>o` | N | 切换折叠 | 折叠控制 |
| `<leader>pl` | N | 插件管理 | Lazy 界面 |
| `<leader>st` | N | 交换三元运算符 | 代码重构 |
| `r` | N | 编译运行 | 运行代码 |
| `<leader>ra` | N | 运行代码 | 执行文件 |
| `<leader>q` | N | 智能退出 | 智能关闭 |

### 终端模式

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<C-N>` | T | 退出终端模式 | 回到普通模式 |
| `<C-O>` | T | 临时退出终端 | 执行一个命令 |

### 其他快捷键

| 快捷键 | 模式 | 功能 | 描述 |
|--------|------|------|------|
| `<F10>` | N | 语法高亮信息 | Treesitter 信息 |
| `z=` | N | 拼写建议 | 拼写检查 |
| `:` | N | 命令搜索 | Telescope 命令 |
| `<leader>pr` | N | 性能分析 | 启动 profiling |

## 🔌 插件管理

### 插件管理架构: 统一化配置
- **主配置文件**: `lua/config/plugins.lua` (45 个插件的统一管理)
- **管理器**: 内联 lazy.nvim 配置，无需额外文件
- **加载策略**: 延迟加载、条件加载、自动依赖管理
- **界面**: `<leader>pl` 打开 Lazy 管理界面

### 插件分类体系
配置按功能分类为 7 大类，在单个文件中集中管理：

#### 🎨 UI 界面插件 (9个)
- **colorscheme**: 主题系统 (nvim-deus 等)
- **statusline**: lualine.nvim 状态栏
- **tabline**: bufferline.nvim 标签栏  
- **scrollbar**: 智能滚动条
- **notify**: nvim-notify 通知系统

#### ✏️ 编辑增强插件 (8个)
- **comment**: Comment.nvim 智能注释 (替代 tcomment_vim)
- **surround**: nvim-surround 环绕操作
- **multi-cursor**: vim-visual-multi 多光标
- **editor**: 多种编辑增强工具
- **autopairs**: 自动配对插件
- **move**: 代码块移动插件

#### 🛠️ 开发工具插件 (10个)
- **LSP**: nvim-lspconfig + mason.nvim LSP 管理
- **treesitter**: nvim-treesitter 语法高亮和解析
- **git**: gitsigns.nvim 版本控制
- **copilot**: copilot.vim AI 代码助手
- **mason**: LSP/Linter 包管理器

#### 🧭 导航搜索插件 (5个)
- **telescope**: telescope.nvim 模糊搜索核心
- **yazi**: yazi.nvim 文件管理器 (替代 nvim-tree)
- **commander**: commander.nvim 命令面板

#### 🌐 语言支持插件 (4个)
- **markdown**: markdown-preview.nvim 预览支持 (替代 vim-instant-markdown)
- **csv**: CSV 文件处理

#### 🔧 自动补全插件 (5个)
- **nvim-cmp**: 补全引擎和补全源

#### ⚙️ 工具依赖插件 (4个)
- **lazy**: lazy.nvim 插件管理器
- **plenary**: 工具库
- **wilder**: wilder.nvim 命令行增强

### 插件配置特性
- **延迟加载**: 基于事件、命令、文件类型的智能加载
- **条件加载**: 根据环境和需求动态加载
- **依赖管理**: 自动处理插件间依赖关系
- **性能优化**: 最小化启动时间，按需加载功能
- **集中配置**: 所有插件配置集中在单一文件中
- **健康检查**: 集成的插件状态监控

### 添加新插件
1. 在 `lua/config/plugins.lua` 中的对应分类部分添加插件配置
2. 配置插件的加载条件、依赖关系和设置
3. 重启 Neovim 或运行 `:Lazy sync` 自动安装

### 插件管理快捷键
- `<leader>pl`: 打开 Lazy 插件管理界面
- `:Lazy sync`: 同步插件 (安装/更新/删除)
- `:Lazy clean`: 清理未使用的插件
- `:Lazy health`: 检查插件健康状态

## 🩺 健康检查和故障排除

### 内置健康检查系统
- **命令**: `:checkhealth` 全面检查
- **组件检查**: `:checkhealth vim.lsp`, `:checkhealth mason`, `:checkhealth telescope`
- **状态监控**: 实时插件和配置状态检查

### 已修复的问题

#### ✅ Python Provider 错误
- **问题**: `ERROR Failed to run healthcheck for "vim.provider" plugin`
- **修复**: 在 `lua/config/core/options.lua` 中配置正确的 Python 路径
- **解决方案**: `vim.g.python3_host_prog = vim.fn.exepath('python3')`

#### ✅ 缺少 init.vim 警告
- **问题**: `WARNING Missing user config file: /Users/tianli/.config/nvim/init.vim`
- **修复**: 创建兼容性 init.vim 文件
- **解决方案**: 自动创建指向 init.lua 的兼容文件

#### ✅ Mason 构建命令错误
- **问题**: `Vim:E471: Argument required: MasonInstall`
- **修复**: 更新 mason.nvim 构建命令为 `:MasonUpdate`

#### ✅ 插件 Git 冲突
- **问题**: 多个插件出现 Git 冲突和未跟踪文件
- **修复**: 实现自动清理脚本和手动修复流程

### 可以安全忽略的警告
- **Lua 版本警告**: Neovim 使用内置 LuaJIT，功能完全正常
- **Julia 缺失**: 除非进行 Julia 开发
- **tree-sitter CLI**: 除非需要自定义语法解析器
- **Perl provider**: 现代 Neovim 配置很少需要

### 性能监控
- **启动时间**: 通过 `nvim --startuptime` 监控
- **插件加载**: Lazy.nvim 提供详细的加载时间分析
- **内存使用**: 优化的插件配置和延迟加载策略

## 🛠️ 自定义功能

### 核心自定义工具

#### 代码运行器 (`lua/config/code_runner.lua`)
- **功能**: 智能多语言代码执行系统
- **支持语言**: 
  - **脚本语言**: Python, JavaScript, TypeScript, Lua
  - **编译语言**: C++, Java, Rust, C
  - **Web技术**: HTML, CSS
  - **文档**: LaTeX (使用 pdflatex)
- **特性**: 
  - 智能编译检测和链式执行
  - 错误处理和输出管理
  - 后台运行支持
- **快捷键**: `r` (编译运行), `<leader>ra` (直接运行), `<leader>q` (智能退出)

#### 文本处理工具 (`lua/config/text_utils.lua`)
- **功能**: 强大的文本编辑和清理工具集
- **工具列表**:
  - `<leader>rv`: 删除无效行 (空行和纯空白行)
  - `<leader>rb`: 删除空白行
  - `<leader>rl`: 删除行尾空格和制表符
  - `<leader>ro`: 删除注释行
  - `<leader>rk`: 压缩多余空格为单个空格
  - `<leader>rq`: 删除引用标记 (>, >>, >>>, 等)
- **应用场景**: 代码清理、文档整理、格式标准化

#### Markdown 工具 (`lua/config/markdown_utils.lua`)
- **功能**: Markdown 文档处理和增强工具
- **特性**: 
  - 文档格式化和结构优化
  - 表格处理和对齐
  - TOC (目录) 生成
  - 链接管理和验证
- **集成**: 与 markdown-preview.nvim 协同工作

#### 文件类型配置 (`lua/config/ftplugin.lua`)
- **功能**: 统一的文件类型特定配置 (替换传统 ftplugin 目录)
- **支持语言**: C, C#, GraphML, Java, Markdown, Prisma, Racket, Swift, Text
- **配置内容**:
  - 语言特定的缩进和制表符设置
  - 专用键位映射和快捷操作
  - 编译运行命令配置
  - 语法高亮和折叠设置
- **Markdown 特殊功能**:
  - `<C-l>`: 插入链接格式
  - `<C-b>`: 插入粗体格式
  - `<C-s>`: 插入删除线
  - `<C-i>`: 插入斜体
  - `<C-d>`: 插入代码块

### 自定义插件系统 (`lua/plugin/`)

#### 编译运行插件 (`compile_run.lua`)
- **功能**: 高级编译运行系统
- **特性**: 
  - 多语言支持和智能检测
  - 编译链管理 (预处理 → 编译 → 链接)
  - 错误捕获和诊断
  - 自定义运行参数
- **更新**: LaTeX 支持改用 pdflatex

#### 三元运算符交换 (`swap_ternary.lua`)
- **功能**: 快速交换三元运算符的条件分支
- **使用**: `<leader>st` 在三元运算符上执行交换
- **示例**: `a ? b : c` ↔ `a ? c : b`
- **应用**: 代码重构和逻辑调整

#### 垂直光标移动 (`vertical_cursor_movement.lua`)
- **功能**: 智能垂直光标导航系统
- **特性**: 
  - 上下文感知的垂直移动
  - 跨空行智能跳跃
  - 代码块边界识别
- **优势**: 提高代码导航效率

#### 控制工具 (`ctrlu.lua`)
- **功能**: 系统级操作和控制快捷方式
- **特性**: 
  - 快速系统操作
  - 环境切换和管理
  - 开发工具链集成

### LSP 集成配置 (`lua/config/lsp.lua`)
- **Mason 集成**: 自动LSP服务器管理
- **多语言支持**: Lua, JavaScript/TypeScript, HTML, JSON, C/C++, Python, Go, Rust 等
- **增强功能**:
  - 悬停文档显示 (`<leader>h`)
  - 签名帮助自动触发
  - 格式化保存 (多种文件类型)
  - 实时诊断和错误提示
- **健康检查**: 集成的 LSP 状态监控

### 搜索和导航系统 (`lua/config/telescope.lua`)
- **Telescope 集成**: 统一搜索界面
- **Commander 集成**: 命令面板和快速操作
- **特色功能**:
  - 项目文件搜索 (`<C-p>`)
  - 符号和引用查找
  - 最近文件历史 (`<C-h>`)
  - 缓冲区快速切换 (`<C-w>`)

## 📝 配置扩展

### 添加新功能
- **键位映射**: 在 `lua/config/keymaps.lua` 中添加新的键位定义
- **自动命令**: 在相应的配置文件中添加 autocmd 定义
- **插件配置**: 在 `lua/config/plugins.lua` 对应分类中添加插件
- **LSP 支持**: 在 `lua/config/lsp.lua` 中添加新的语言服务器配置

### 个人配置定制
- **机器特定配置**: 编辑 `default_config/_machine_specific_default.lua` 模板
- **个人设置**: 配置会自动生成个人配置文件并应用
- **主题定制**: 在 plugins.lua 的 UI 部分修改 colorscheme 配置
- **快捷键调整**: 在 keymaps.lua 中修改或添加个人快捷键

### 性能优化配置
- **延迟加载**: 所有插件都配置了合适的加载触发条件
- **按需加载**: 基于文件类型和使用场景的智能加载
- **启动优化**: 最小化启动时的插件加载数量
- **内存管理**: 智能的插件卸载和资源管理
- **健康监控**: 定期检查和优化配置性能

---

本文档详细描述了重构后的 Neovim 配置架构。新架构通过**统一化设计**实现了 **75% 的文件减少**，同时**保持了所有功能的完整性**。配置更加**易于维护和扩展**，为用户提供了现代化、高效的编辑体验，并包含完善的健康检查和故障排除机制。 
