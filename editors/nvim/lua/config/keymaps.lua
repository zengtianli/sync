-- ==========================================
-- Neovim 键映射配置
-- ==========================================

vim.g.mapleader = " "
vim.opt.wrap = false

-- 工具模块将在 keymaps 设置后初始化

-- 定义模式快捷变量
local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }

-- ==========================================
-- 核心键映射配置
-- ==========================================
local nmappings = {
	-- 基础编辑
	{ from = "U", to = "<c-r>", desc = "重做" },
	{ from = "S", to = ":w<CR>", desc = "保存文件" },
	{ from = "Q", to = ":q<CR>", desc = "退出" },
	{ from = "<M-j>", to = "J", mode = { "n", "v" }, desc = "连接行" },
	{ from = ";", to = ":", mode = mode_nv, desc = "命令模式" },
	{ from = "Y", to = "\"+y", mode = mode_v, desc = "复制到系统剪贴板" },
	{ from = "`", to = "~", mode = mode_nv, desc = "切换大小写" },

	-- 快速移动
	{ from = "K", to = "15k", mode = mode_nv, desc = "向上快速移动" },
	{ from = "J", to = "15j", mode = mode_nv, desc = "向下快速移动" },
	{ from = "W", to = "5w", mode = mode_nv, desc = "向前快速移动单词" },
	{ from = "B", to = "5b", mode = mode_nv, desc = "向后快速移动单词" },
	{ from = "H", to = "0", mode = mode_nv, desc = "行首" },
	{ from = "L", to = "$", mode = mode_nv, desc = "行尾" },

	-- 跳转优化
	{ from = "<C-i>", to = "<c-o>", mode = mode_nv, desc = "后退跳转" },
	{ from = "<C-o>", to = "<c-i>", mode = mode_nv, desc = "前进跳转" },
	{ from = ",.", to = "%", mode = mode_nv, desc = "匹配括号" },

	-- 选择增强
	{ from = "\\v", to = "v$h", desc = "选择到行尾（不包含换行符）" },

	-- 文件管理
	{ from = "R", to = ":Joshuto<CR>", desc = "打开文件管理器" },

	-- 其他工具
	{ from = "<leader>o", to = "za", desc = "切换折叠" },
}

-- ==========================================
-- 窗口管理键映射
-- ==========================================
local window_mappings = {
	-- 窗口切换
	{ from = "<leader>sk", to = "<C-w>k", desc = "切换到上方窗口" },
	{ from = "<leader>sj", to = "<C-w>j", desc = "切换到下方窗口" },
	{ from = "<leader>sh", to = "<C-w>h", desc = "切换到左侧窗口" },
	{ from = "<leader>sl", to = "<C-w>l", desc = "切换到右侧窗口" },

	-- 窗口分割
	{ from = "s", to = "<nop>", desc = "禁用s键" },
	{ from = "sk", to = ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", desc = "上方分割" },
	{ from = "sj", to = ":set splitbelow<CR>:split<CR>", desc = "下方分割" },
	{ from = "sh", to = ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", desc = "左侧分割" },
	{ from = "sl", to = ":set splitright<CR>:vsplit<CR>", desc = "右侧分割" },

	-- 窗口大小调整
	{ from = "<up>", to = ":res +5<CR>", desc = "增加窗口高度" },
	{ from = "<down>", to = ":res -5<CR>", desc = "减少窗口高度" },
	{ from = "<left>", to = ":vertical resize-5<CR>", desc = "减少窗口宽度" },
	{ from = "<right>", to = ":vertical resize+5<CR>", desc = "增加窗口宽度" },

	-- 窗口布局转换
	{ from = "srh", to = "<C-w>b<C-w>K", desc = "水平布局转换" },
	{ from = "srv", to = "<C-w>b<C-w>H", desc = "垂直布局转换" },
}


-- ==========================================
-- 文本处理键映射
-- ==========================================
local text_processing_mappings = {
	-- 显示和搜索
	{ from = "<leader>sw", to = ":if &wrap | set nowrap | else | set wrap | endif<CR>", desc = "切换自动换行" },
	{ from = "<leader><CR>", to = ":nohlsearch<CR>", desc = "清除搜索高亮" },

	-- 文本清理（普通模式和可视模式）
	{ from = "<leader>rv", to = ":g/^[^a-zA-Z0-9\\u4e00-\\u9fa5\\[\\]\\(\\)\\{\\}*`,.;:]*$/d<CR>", desc = "删除无效行" },
	{ from = "<leader>rb", to = ":g/^\\s*$/d<CR>", desc = "删除空白行" },
	{ from = "<leader>rl", to = ":%s/\\s*$//g<CR>", desc = "删除行尾空格" },
	{ from = "<leader>ro", to = ":g/^\\s*\\#\\s*.*$/d<CR>", desc = "删除注释行" },

	-- 空格处理（支持普通模式和可视模式）
	{ from = "<leader>rk", to = ":%s/\\s\\+//g<CR>", mode = "n", desc = "删除文件中所有多余空格" },
	{ from = "<leader>rk", to = ":s/\\s\\+//g<CR>", mode = "v", desc = "删除选中行所有多余空格" },

	-- 表格模式
	{ from = "<leader>tm", to = ":TableModeToggle<CR>", desc = "切换表格模式" },
	
	-- Marp 幻灯片预览
	{ from = "<leader>mp", to = ":MarpToggle<CR>", desc = "切换 Marp 幻灯片预览" },
	{ from = "<leader>ms", to = ":MarpStatus<CR>", desc = "查看 Marp 服务器状态" },
}

-- ==========================================
-- Operator 模式键映射
-- ==========================================
local operator_mappings = {
	{ from = "H", to = "0", mode = "o", desc = "操作到行首" },
	{ from = "L", to = "$", mode = "o", desc = "操作到行尾" },
}

-- ==========================================
-- 应用所有键映射
-- ==========================================
local function apply_mappings(mappings)
	for _, mapping in ipairs(mappings) do
		local opts = { noremap = true, silent = true }
		if mapping.desc then
			opts.desc = mapping.desc
		end
		vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, opts)
	end
end

-- 应用所有键映射组
apply_mappings(nmappings)
apply_mappings(window_mappings)
apply_mappings(text_processing_mappings)
apply_mappings(operator_mappings)

-- ==========================================
-- 自动命令
-- ==========================================
vim.cmd [[
	autocmd BufWritePost $HOME/.config/yabai/yabairc !yabai --restart-service
]]

-- ==========================================
-- 最后的设置
-- ==========================================

-- 禁用无用快捷键
vim.keymap.set("n", "<leader><esc>", "<nop>", { noremap = true, silent = true })

-- 初始化工具模块
require("config.utils").setup()
