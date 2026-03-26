# Neovim 配置

> 模块化 Neovim 配置，提供现代 IDE 开发体验

## 快速开始

```bash
# 首次启动会自动安装插件
nvim

# 安装语言服务器
:Mason
```

## 目录结构

```
nvim/
├── init.lua                    # 入口
├── KEYMAPS.md                  # 快捷键手册
├── lua/config/
│   ├── plugins.lua             # 插件配置
│   ├── lsp.lua                 # LSP 配置
│   ├── keymaps.lua             # 快捷键
│   ├── autocomplete.lua        # 补全配置
│   ├── telescope.lua           # 搜索配置
│   └── ...
└── lua/plugin/                 # 自定义插件
    ├── compile_run.lua         # 编译运行
    └── vertical_cursor_movement.lua
```

## 核心快捷键

> Leader 键: `<Space>`
> 完整手册: [KEYMAPS.md](KEYMAPS.md)

| 快捷键 | 功能 | 快捷键 | 功能 |
|--------|------|--------|------|
| `S` | 保存 | `Q` | 退出 |
| `<C-p>` | 文件搜索 | `<C-f>` | 文本搜索 |
| `<C-g>` | LazyGit | `R` | 文件管理器 |
| `gd` | 跳转定义 | `gr` | 查找引用 |
| `<leader>v` | **代码大纲** | `<leader>h` | 悬停文档 |

---

## 插件功能

### 代码大纲 (aerial.nvim)

在右侧显示文档结构，支持快速跳转。

| 快捷键 | 功能 |
|--------|------|
| `<leader>v` | 打开/关闭大纲 |
| `{` | 跳转到上一个符号 |
| `}` | 跳转到下一个符号 |

支持：
- Markdown 标题 (`# ## ###`)
- 代码函数/类/方法
- LSP 符号

---

### UI 界面

| 插件 | 功能 |
|------|------|
| **nvim-deus** | 主题 |
| **lualine.nvim** | 状态栏 |
| **bufferline.nvim** | 标签栏 |
| **nvim-notify** | 通知系统 |
| **nvim-scrollbar** | 滚动条 (显示 Git/搜索标记) |
| **hlchunk.nvim** | 代码块高亮 |
| **nvim-hlslens** | 搜索结果计数 |

---

### 编辑增强

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| **Comment.nvim** | 注释 | `<leader>cn` |
| **nvim-surround** | 包围编辑 | `ys`, `cs`, `ds` |
| **vim-visual-multi** | 多光标 | `<C-n>` |
| **substitute.nvim** | 替换 | `ss`, `s{motion}` |
| **nvim-autopairs** | 自动配对 | 自动 |
| **vim-illuminate** | 相同符号高亮 | 自动 |

---

### 搜索导航

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| **telescope.nvim** | 模糊搜索 | `<C-p>` 文件, `:` 命令 |
| **fzf-lua** | 文本搜索 | `<C-f>` |
| **yazi.nvim** | 文件管理器 | `R` |
| **commander.nvim** | 命令面板 | `<C-q>` |

---

### LSP 开发

| 插件 | 功能 |
|------|------|
| **lsp-zero.nvim** | LSP 零配置 |
| **mason.nvim** | LSP 安装器 |
| **nvim-cmp** | 补全引擎 |
| **copilot.vim** | AI 代码助手 |
| **nvim-treesitter** | 语法高亮 |
| **treesitter-context** | 上下文显示 |
| **fidget.nvim** | LSP 进度 |

**支持语言**: Lua, TypeScript/JavaScript, Python, Go, C/C++, HTML/CSS, JSON, YAML, Terraform, Prisma

---

### Git 集成

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| **lazygit.nvim** | Git TUI | `<C-g>` |
| **gitsigns.nvim** | Git 标记 | `<leader>gb` blame |

---

### Markdown 支持

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| **aerial.nvim** | 标题大纲 | `<leader>v` |
| **markdown-preview.nvim** | 浏览器预览 | `:MarkdownPreview` |
| **markdown-toc.nvim** | 目录生成 | `<leader>mi` |
| **vim-table-mode** | 表格编辑 | `<leader>tm` |
| **marp-nvim** | 幻灯片预览 | `<leader>mp` |

---

### AI 助手 (Copilot)

| 快捷键 | 功能 |
|--------|------|
| `<C-c>` | 接受建议 |
| `<C-l>` | 下一个建议 |
| `<C-h>` | 上一个建议 |
| `<leader>go` | 打开 Copilot |

---

### 其他工具

| 插件 | 功能 |
|------|------|
| **wilder.nvim** | 命令行补全 |
| **rainbow_csv.nvim** | CSV 高亮 |

---

## 自定义插件

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| **compile_run** | 编译运行 | `r` |
| **vertical_cursor_movement** | 垂直移动 | - |
| **markdown_utils** | MD 工具命令 | `:NumberHeadings` 等 |

---

## 常用命令

```vim
:Lazy              " 插件管理
:Mason             " LSP 安装
:checkhealth       " 健康检查
:Mtoc insert       " 插入 Markdown 目录
:MarkdownPreview   " 预览 Markdown
:AerialToggle      " 代码大纲
```

---

## 配置文件

| 文件 | 用途 |
|------|------|
| `lua/config/plugins.lua` | 添加/修改插件 |
| `lua/config/lsp.lua` | LSP 配置 |
| `lua/config/keymaps.lua` | 快捷键 |
| `lua/config/core/options.lua` | 编辑器选项 |
