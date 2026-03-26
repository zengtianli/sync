-- ==========================================
-- 配置模块加载器
-- ==========================================

local M = {}

-- 加载顺序定义
local LOAD_ORDER = {
    -- 第一阶段：基础配置
    {
        name = "基础配置",
        modules = {
            "config.core.options",
            "config.core.autocmds",
            "config.core.terminal",
            "config.core.machine_specific",
        }
    },
    
    -- 第二阶段：键位映射
    {
        name = "键位映射",
        modules = {
            "config.keymaps",
        }
    },
    
    -- 第三阶段：插件系统
    {
        name = "插件系统",
        modules = {
            "config.plugins",
        }
    },
    
    -- 第四阶段：工具模块
    {
        name = "工具模块",
        modules = {
            "config.utils",
        }
    },
}

function M.load_all()
    for _, phase in ipairs(LOAD_ORDER) do
        vim.notify("加载 " .. phase.name .. "...", vim.log.levels.INFO)
        
        for _, module_name in ipairs(phase.modules) do
            local ok, err = pcall(require, module_name)
            if not ok then
                vim.notify("加载模块失败: " .. module_name .. " - " .. err, vim.log.levels.ERROR)
            end
        end
    end
end

function M.load_module(module_name)
    local ok, module = pcall(require, module_name)
    if ok then
        if type(module.setup) == "function" then
            module.setup()
        end
        return module
    else
        vim.notify("无法加载模块: " .. module_name, vim.log.levels.WARN)
        return nil
    end
end

return M 