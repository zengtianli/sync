-- ==========================================
-- 终端配置模块
-- ==========================================

local M = {}

function M.setup()
    -- 终端颜色配置
    vim.g.terminal_color_0  = '#000000'
    vim.g.terminal_color_1  = '#FF5555'
    vim.g.terminal_color_2  = '#50FA7B'
    vim.g.terminal_color_3  = '#F1FA8C'
    vim.g.terminal_color_4  = '#BD93F9'
    vim.g.terminal_color_5  = '#FF79C6'
    vim.g.terminal_color_6  = '#8BE9FD'
    vim.g.terminal_color_7  = '#BFBFBF'
    vim.g.terminal_color_8  = '#4D4D4D'
    vim.g.terminal_color_9  = '#FF6E67'
    vim.g.terminal_color_10 = '#5AF78E'
    vim.g.terminal_color_11 = '#F4F99D'
    vim.g.terminal_color_12 = '#CAA9FA'
    vim.g.terminal_color_13 = '#FF92D0'
    vim.g.terminal_color_14 = '#9AEDFE'

    -- 终端键位映射
    vim.keymap.set("t", "<C-N>", "<C-\\><C-N>", { noremap = true })
    vim.keymap.set("t", "<C-O>", "<C-\\><C-N><C-O>", { noremap = true })
    
    -- 外部文件加载（光标配置）
    local cursor_config = vim.fn.expand("$HOME/.config/nvim/cursor_for_qwerty.vim")
    if vim.fn.filereadable(cursor_config) == 1 then
        vim.cmd('source ' .. cursor_config)
    end
end

return M 