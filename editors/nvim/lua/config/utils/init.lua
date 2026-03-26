-- ==========================================
-- 工具模块统一入口
-- ==========================================

local M = {}

function M.setup()
    -- 加载所有工具模块
    local code_runner = require('config.code_runner')
    local markdown_utils = require('config.markdown_utils')
    local text_utils = require('config.text_utils')
    
    -- 初始化工具模块
    code_runner.setup()
    markdown_utils.setup()
    text_utils.setup()
end

return M 