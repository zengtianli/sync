-- Yazi 插件配置
-- 更新于 2025-12-20，兼容 Yazi 25.9.15

-- 1. Git 状态显示
require("git"):setup {}

-- 2. 书签管理
require("yamb"):setup {
	cli = "fzf",
}

-- yatline 与新版 Yazi API 不兼容，暂时禁用
-- 等待插件更新后再启用
