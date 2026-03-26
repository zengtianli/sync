-- ==========================================
-- Neovim 选项配置
-- ==========================================

local M = {}

function M.setup()
    -- 颜色和显示
    vim.o.termguicolors = true
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
    vim.o.ttyfast = true
    
    -- 工作目录和安全
    vim.o.autochdir = true
    vim.o.exrc = true
    vim.o.secure = false
    
    -- 行号和光标
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.cursorline = true
    
    -- 缩进和制表符
    vim.o.expandtab = false
    vim.o.tabstop = 2
    vim.o.smarttab = true
    vim.o.shiftwidth = 2
    vim.o.softtabstop = 2
    vim.o.autoindent = true
    
    -- 显示设置
    vim.o.list = true
    vim.o.listchars = 'tab:|\\ ,trail:▫'
    vim.o.scrolloff = 4
    vim.o.colorcolumn = '100'
    
    -- 时间和超时
    vim.o.ttimeoutlen = 0
    vim.o.timeout = false
    vim.o.updatetime = 100
    
    -- 视图和会话
    vim.o.viewoptions = 'cursor,folds,slash,unix'
    
    -- 文本换行和宽度
    vim.o.wrap = true
    vim.o.textwidth = 0
    vim.o.indentexpr = ''
    
    -- 折叠设置
    vim.o.foldmethod = 'indent'
    vim.o.foldlevel = 99
    vim.o.foldenable = true
    vim.o.foldlevelstart = 99
    
    -- 格式选项
    vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')
    
    -- 分割设置
    vim.o.splitright = true
    vim.o.splitbelow = true
    
    -- 界面设置
    vim.o.showmode = false
    vim.o.visualbell = true
    vim.o.virtualedit = 'block'
    
    -- 搜索设置
    vim.o.ignorecase = true
    vim.o.smartcase = true
    vim.o.inccommand = 'split'
    
    -- 消息设置
    vim.o.shortmess = vim.o.shortmess .. 'c'
    
    -- 补全设置
    vim.o.completeopt = 'menuone,noinsert,noselect,preview'
    
    -- 高亮设置
    vim.cmd([[hi NonText ctermfg=gray guifg=grey10]])
    
    -- 备份和撤销设置
    vim.cmd([[
    silent !mkdir -p $HOME/.config/nvim/tmp/backup
    silent !mkdir -p $HOME/.config/nvim/tmp/undo
    set backupdir=$HOME/.config/nvim/tmp/backup,.
    set directory=$HOME/.config/nvim/tmp/backup,.
    if has('persistent_undo')
        set undofile
        set undodir=$HOME/.config/nvim/tmp/undo,.
    endif
    ]])
end

return M 