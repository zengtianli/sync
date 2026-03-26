-- ==========================================
-- 统一文件类型配置
-- ==========================================

local M = {}

function M.setup()
  -- ==========================================
  -- 通用设置
  -- ==========================================
  
  -- 基础语言的缩进设置（2空格）
  local basic_indent_langs = { 'c', 'java', 'graphml', 'racket', 'text' }
  for _, lang in ipairs(basic_indent_langs) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = lang,
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
        vim.opt_local.smarttab = true
      end
    })
  end

  -- 4空格缩进的语言
  local wide_indent_langs = { 'cs', 'swift' }
  for _, lang in ipairs(wide_indent_langs) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = lang,
      callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
        vim.opt_local.smarttab = true
      end
    })
  end

  -- ==========================================
  -- 特定语言配置
  -- ==========================================

  -- C# 配置
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
      vim.keymap.set("n", "<LEADER>aw", ":CocAction<CR>", { buffer = true })
    end
  })

  -- Go 配置
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
      vim.keymap.set("n", "<LEADER>tf", ":GoTestFunc<CR>", { buffer = true })
    end
  })

  -- Prisma 配置
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "prisma",
    callback = function()
      vim.keymap.set("n", "<LEADER>'r", ":noa w<CR>:silent exec \"!npx prisma format\"<CR>:e<CR>", { buffer = true })
    end
  })

  -- Racket 配置
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "racket",
    callback = function()
      vim.g.AutoPairs = {
        ['('] = ')', ['['] = ']', ['{'] = '}', ['"'] = '"',
        ["`"] = "`", ['```'] = '```', ['"""'] = '"""', ["'''"] = "'''"
      }
    end
  })



  -- Markdown 配置
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      -- 基础设置
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.expandtab = true
      vim.opt_local.smarttab = true
    end
  })

  -- ==========================================
  -- 全局自动命令
  -- ==========================================
  
  -- yabai配置文件自动重启
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = vim.fn.expand("$HOME/.config/yabai/yabairc"),
    command = "!yabai --restart-service"
  })
end

return M 