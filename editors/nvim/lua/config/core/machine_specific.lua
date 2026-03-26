-- ==========================================
-- 机器特定配置管理
-- ==========================================

local M = {}

function M.setup()
    local config_path = vim.fn.stdpath("config")
    local current_config_path = config_path .. "/lua/config/machine_specific.lua"
    
    -- 如果机器特定配置文件不存在，则从默认模板创建
    if not vim.loop.fs_stat(current_config_path) then
        local current_config_file = io.open(current_config_path, "wb")
        local default_config_path = config_path .. "/default_config/_machine_specific_default.lua"
        local default_config_file = io.open(default_config_path, "rb")
        
        if default_config_file and current_config_file then
            local content = default_config_file:read("*all")
            current_config_file:write(content)
            io.close(default_config_file)
            io.close(current_config_file)
        end
    end
    
    -- 加载机器特定配置
    local ok, err = pcall(require, "config.machine_specific")
    if not ok then
        vim.notify("Failed to load machine specific config: " .. err, vim.log.levels.WARN)
    end
    
    -- 设置一些默认的机器特定配置（可以被 machine_specific.lua 覆盖）
    vim.g.python3_host_prog = vim.g.python3_host_prog or '/Users/tianli/miniforge3/bin/python'
end

return M 