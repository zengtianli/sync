# Neovim 配置完全指南

#配置 #编辑器 #开发 #现代化

> ⚙️ **Neovim配置** 是现代化 Neovim 的核心，通过合理配置可以打造出强大的开发环境。

## 🔄 从 Vim 迁移

### 兼容性说明
Neovim 完全兼容 Vim 配置，你可以：
- 继续使用 `.vimrc`（Neovim 会自动加载）
- 使用 `init.vim`（推荐，更清晰的配置分离）
- 使用 `init.lua`（最推荐，完整利用 Neovim 现代特性）

### 配置文件位置
```bash
# Vim 配置文件
~/.vimrc                    # Unix-like 系统
%USERPROFILE%\_vimrc       # Windows

# Neovim 配置文件
~/.config/nvim/init.vim    # 传统 Vim 语法
~/.config/nvim/init.lua    # 现代 Lua 配置（推荐）
```

## 🌟 配置结构

### 基础目录结构
```
~/.config/nvim/
├── init.lua                 # 主配置文件
├── lua/
│   ├── config/              # 核心配置
│   │   ├── core/
│   │   │   └── options.lua  # 基础选项（含 Python provider）
│   │   ├── defaults.lua     # 配置加载器
│   │   ├── keymaps.lua      # 键位映射
│   │   ├── plugins.lua      # 插件管理（51个插件）
│   │   ├── lsp.lua          # LSP配置
│   │   ├── autocomplete.lua # 自动补全
│   │   ├── telescope.lua    # 模糊搜索
│   │   └── ftplugin.lua     # 文件类型配置
│   └── plugin/              # 自定义插件
│       ├── compile_run.lua  # 编译运行
│       ├── swap_ternary.lua # 三元运算符交换
│       └── ...
```

### 主配置文件
```lua
-- ~/.config/nvim/init.lua

-- 加载核心配置
require("config.defaults")

-- 加载键位映射
require("config.keymaps")

-- 加载插件配置
require("config.plugins")
```

## ⚙️ 核心配置

### 基础选项配置
```lua
-- ~/.config/nvim/lua/config/core/options.lua

-- Python provider 配置（解决健康检查问题）
vim.g.python3_host_prog = vim.fn.exepath('python3') or '/Users/tianli/miniforge3/bin/python3'

-- 基础设置
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.sidescroll = 5
vim.opt.listchars = { tab = '→ ', trail = '·', nbsp = '␣' }

-- 搜索设置
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- 缩进设置
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 文件处理
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.local/share/nvim/undo')

-- UI 设置
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 性能设置
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.lazyredraw = true

-- 折叠设置
vim.opt.foldmethod = 'manual'
vim.opt.foldlevel = 99

-- 其他设置
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
```

### 键位映射配置
```lua
-- ~/.config/nvim/lua/config/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 基础编辑
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- 窗口管理
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("n", "<leader>l", "<C-w>l", opts)

-- 分割窗口
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>se", "<C-w>=", opts)
keymap("n", "<leader>sx", ":close<CR>", opts)

-- 标签页管理
keymap("n", "<leader>to", ":tabnew<CR>", opts)
keymap("n", "<leader>tx", ":tabclose<CR>", opts)
keymap("n", "<leader>tn", ":tabn<CR>", opts)
keymap("n", "<leader>tp", ":tabp<CR>", opts)

-- 缓冲区导航
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- 文本编辑
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- 搜索和替换
keymap("n", "<leader>nh", ":nohl<CR>", opts)
keymap("n", "<leader>rs", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", opts)

-- 快速跳转
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
```

## 🔌 插件管理

### Lazy.nvim 配置
```lua
-- ~/.config/nvim/lua/config/plugins.lua

-- 自动安装 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 插件规范（51个精选插件）
require("lazy").setup({
  -- 颜色主题
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },

  -- 文件浏览器
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "R", "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
    },
    opts = {
      open_for_directories = false,
    },
  },

  -- 模糊搜索
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.telescope")
    end,
  },

  -- LSP 配置
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("config.lsp")
    end,
  },

  -- 自动完成
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("config.autocomplete")
    end,
  },

  -- 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Git 集成
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end,
  },

  -- 注释插件
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require('Comment').setup({
        padding = true,
        sticky = true,
        ignore = '^$',
        toggler = {
          line = 'gcc',
          block = 'gbc'
        },
        opleader = {
          line = 'gc',
          block = 'gb'
        },
        mappings = {
          basic = true,
          extra = true
        }
      })
      -- 保持原有快捷键
      vim.keymap.set('n', '<leader>cn', 'gcc', { remap = true })
      vim.keymap.set('v', '<leader>cn', 'gc', { remap = true })
      vim.keymap.set('n', '<leader>cu', 'gcc', { remap = true })
      vim.keymap.set('v', '<leader>cu', 'gc', { remap = true })
    end
  },

  -- Markdown 预览
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {}
      }
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_port = ''
      vim.g.mkdp_page_title = '「${name}」'
    end
  },

  -- 括号自动配对
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- 缩进线
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },
})
```

## 🔍 LSP 配置

### Language Server 设置
```lua
-- ~/.config/nvim/lua/config/lsp.lua

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Mason 设置
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Mason LSP 配置
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "rust_analyzer",
    "gopls",
    "clangd",
    "html",
    "cssls",
    "jsonls",
  },
  automatic_installation = true,
})

-- LSP 能力配置
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 通用 LSP 设置
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  
  -- LSP 快捷键
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

-- 自动配置 LSP 服务器
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,

  -- Lua 特殊配置
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
  end,
})
```

## 🔭 Telescope 配置

### 模糊搜索设置
```lua
-- ~/.config/nvim/lua/config/telescope.lua

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "❯ ",
    path_display = { "truncate" },
    file_ignore_patterns = {
      "node_modules",
      ".git/",
      "dist/",
      "build/",
      "*.pyc",
    },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      previewer = false,
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
      previewer = false,
    },
  },
})

-- Telescope 快捷键
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fc", ":Telescope commands<CR>", opts)
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
```

## 🎨 主题和外观

### 主题配置
```lua
-- 在 plugins.lua 中配置 Catppuccin 主题
{
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
      },
    })
    vim.cmd.colorscheme "catppuccin"
  end,
},
```

## 🔗 工具集成

### Git 集成
```lua
-- Git 相关配置
require("gitsigns").setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
    ignore_whitespace = false,
  },
})
```

## 🚀 高级配置

### 自动命令
```lua
-- ~/.config/nvim/lua/config/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 高亮选中文本
augroup("HighlightYank", {})
autocmd("TextYankPost", {
  group = "HighlightYank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- 自动保存和恢复折叠
augroup("AutoSaveLoad", {})
autocmd({ "BufWinLeave" }, {
  group = "AutoSaveLoad",
  pattern = "*.*",
  desc = "save view (folds), when closing file",
  command = "mkview",
})
autocmd({ "BufWinEnter" }, {
  group = "AutoSaveLoad",
  pattern = "*.*",
  desc = "load view (folds), when opening file",
  command = "silent! loadview"
})

-- 去除行尾空格
augroup("TrimWhitespace", {})
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- 自动调整窗口大小
augroup("AutoResize", {})
autocmd("VimResized", {
  group = "AutoResize",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
```

### 性能优化
```lua
-- ~/.config/nvim/lua/config/core/performance.lua

-- 减少重绘
vim.opt.lazyredraw = true

-- 优化搜索
vim.opt.regexpengine = 1

-- 限制语法高亮
vim.opt.synmaxcol = 240

-- 禁用不需要的插件
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
```

## 🩺 健康检查和故障排除

### 运行健康检查
```bash
# 在 Neovim 中运行
:checkhealth

# 检查特定组件
:checkhealth vim.lsp
:checkhealth mason
:checkhealth telescope
```

### 常见问题和解决方案

#### 1. Python Provider 错误
**问题**: `ERROR Failed to run healthcheck for "vim.provider" plugin`

**解决方案**:
```lua
-- 在 lua/config/core/options.lua 中配置
vim.g.python3_host_prog = vim.fn.exepath('python3') or '/Users/tianli/miniforge3/bin/python3'
```

#### 2. Lua 版本警告
**问题**: `WARNING lua version 5.1 needed, but found Lua 5.4.8`

**解决方案**: 可以安全忽略，Neovim 使用内置 LuaJIT，功能完全正常。

#### 3. 插件安装错误
**问题**: 插件更新时出现 Git 冲突

**解决方案**:
```bash
# 清理插件缓存
rm -rf ~/.local/share/nvim/lazy/problematic-plugin
rm -rf ~/.cache/nvim/lazy

# 重新同步
:Lazy sync
```

#### 4. LSP 服务器不工作
**问题**: 语言服务器无法启动

**解决方案**:
```bash
# 检查 Mason 安装状态
:Mason

# 重新安装语言服务器
:MasonInstall lua-language-server

# 检查 LSP 状态
:LspInfo
```

#### 5. 缺少 init.vim 警告
**解决方案**: 创建兼容性文件
```bash
mkdir -p ~/.config/nvim
echo '" This file is for compatibility - actual config is in init.lua' > ~/.config/nvim/init.vim
```

### 性能优化建议

#### 启动时间优化
```bash
# 分析启动时间
nvim --startuptime startup.log +qa

# 查看最耗时的操作
cat startup.log | sort -k2 -n | tail -10
```

#### 插件管理优化
- 使用延迟加载 (`event`, `cmd`, `ft`)
- 定期清理不需要的插件 (`:Lazy clean`)
- 更新插件到最新版本 (`:Lazy sync`)

## 📚 相关资源

### 学习指南
- [Neovim 官方文档](https://neovim.io/doc/)
- [Lua 语言学习](https://www.lua.org/manual/5.1/)
- [LSP 配置指南](https://github.com/neovim/nvim-lspconfig)

### 相关配置
- [Lazy.nvim 插件管理器](https://github.com/folke/lazy.nvim)
- [Mason.nvim LSP 管理](https://github.com/williamboman/mason.nvim)
- [Telescope 搜索工具](https://github.com/nvim-telescope/telescope.nvim)

### 故障排除
- 使用 `:checkhealth` 诊断问题
- 查看 `:messages` 了解错误信息
- 使用 `:Lazy health` 检查插件状态

---

## 📝 从 Vim 迁移建议

### 循序渐进的迁移
1. **保持 Vim 配置**：先使用 `init.vim` 加载现有的 `.vimrc`
2. **逐步迁移到 Lua**：
   - 从简单的选项设置开始
   - 然后是键位映射
   - 最后是插件配置
3. **使用现代替代品**：
   - vim-plug → Lazy.nvim
   - NERDTree → yazi.nvim
   - fzf.vim → Telescope
   - coc.nvim → 内置 LSP
   - vimscript 插件 → Lua 插件

### 配置转换示例
```lua
-- Vim 配置
" set number
" set relativenumber
" set tabstop=4

-- Neovim Lua 配置
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4

-- Vim 映射
" nnoremap <leader>w :w<CR>
" vnoremap < <gv

-- Neovim Lua 映射
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('v', '<', '<gv')
```

### 注意事项
- 使用 Lua 配置可以获得更好的性能
- 内置 LSP 比 coc.nvim 更轻量和集成
- Telescope 提供比 fzf.vim 更现代的体验
- 模块化配置更容易维护
- 保留一些有用的 Vim 兼容性设置

---

*🚀 **提示**：Neovim 不仅仅是 Vim 的升级版，它提供了更现代的编辑体验。充分利用其 Lua 生态系统和内置 LSP 可以打造出专业的 IDE 级开发环境。* 