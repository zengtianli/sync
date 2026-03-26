-- ==========================================
-- 核心默认配置
-- ==========================================

-- 使用模块加载器确保正确的加载顺序
local loader = require("config.loader")

-- 加载基础配置模块
loader.load_module("config.core.options")
loader.load_module("config.core.autocmds")
loader.load_module("config.core.terminal")
loader.load_module("config.core.machine_specific")

-- 加载文件类型配置
loader.load_module("config.ftplugin")
