-- ==========================================
-- 统一自动补全配置
-- ==========================================

local M = {}

-- 辅助函数
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local limitStr = function(str)
  if #str > 25 then
    str = string.sub(str, 1, 22) .. "..."
  end
  return str
end



local pythonUnderscoreSecond = function(entry1, entry2)
  if vim.bo.filetype ~= "python" then return nil end
  local entry1StartsWithUnderscore = string.sub(entry1.completion_item.label, 1, 1) == "_" and entry1.source.name == 'nvim_lsp'
  local entry2StartsWithUnderscore = string.sub(entry2.completion_item.label, 1, 1) == "_" and entry2.source.name == 'nvim_lsp'
  if entry1StartsWithUnderscore and not entry2StartsWithUnderscore then
    return false
  elseif not entry1StartsWithUnderscore and entry2StartsWithUnderscore then
    return true
  end
  return nil
end



local setCompHL = function()
  local fgdark = "#2E3440"
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
  vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
  vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#cccccc" })
  vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })
  vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
end

-- 主配置
M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
  },
  config = function()
    local M = require("config.autocomplete")
    M.setup()
  end
}

function M.setup()
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  local cmp = require("cmp")
  setCompHL()
  
  cmp.setup({
    preselect = cmp.PreselectMode.None,
    window = {
      completion = {
        col_offset = -3,
        side_padding = 0,
      },
      documentation = cmp.config.window.bordered(),
    },
    sorting = {
      comparators = {
        pythonUnderscoreSecond,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.kind,
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      maxwidth = 60,
      maxheight = 10,
      format = function(entry, vim_item)
        vim_item.kind = " " .. vim_item.kind .. " "
        vim_item.menu = limitStr(entry:get_completion_item().detail or "")
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
    }, {
      { name = "path" },
      { name = "nvim_lua" },
    }),
    mapping = cmp.mapping.preset.insert({
      ['<C-l>'] = cmp.mapping.complete(),
      ['<c-f>'] = cmp.mapping({
        i = function(fallback)
          cmp.close()
          fallback()
        end
      }),
      ['<CR>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end
      }),
      ["<Tab>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            moveCursorBeforeComma()
          elseif has_words_before() then
            cmp.complete()
            moveCursorBeforeComma()
          else
            fallback()
          end
        end,
      }),
      ["<S-Tab>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            moveCursorBeforeComma()
          else
            fallback()
          end
        end,
      }),
    }),
  })
end

return M 