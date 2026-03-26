-- ==========================================
-- Neovim 自动命令配置
-- ==========================================

local M = {}

function M.setup()
    -- Markdown 文件启用拼写检查
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { 
        pattern = "*.md", 
        command = "setlocal spell" 
    })

    -- 自动切换到文件所在目录
    vim.api.nvim_create_autocmd("BufEnter", { 
        pattern = "*", 
        command = "silent! lcd %:p:h" 
    })

    -- 恢复上次光标位置
    vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
            local last_pos = vim.fn.line("'\"")
            if last_pos > 1 and last_pos <= vim.fn.line("$") then
                vim.cmd("normal! g'\"")
            end
        end
    })

    -- 终端相关自动命令
    vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        command = "startinsert"
    })

    -- 配置文件变更时自动重载
    vim.api.nvim_create_augroup("NVIMRC", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = "NVIMRC",
        pattern = ".vim.lua",
        command = "source %"
    })

    -- yabai 配置文件变更时重启服务
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = vim.fn.expand("$HOME/.config/yabai/yabairc"),
        command = "!yabai --restart-service"
    })
end

return M 