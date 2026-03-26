local M = {}

local function run_vim_shortcut(shortcut)
	local escaped_shortcut = vim.api.nvim_replace_termcodes(shortcut, true, false, true)
	vim.api.nvim_feedkeys(escaped_shortcut, 'n', true)
end

-- 运行代码的主要函数
function M.run_code()
	local filetype = vim.bo.filetype
	vim.cmd('w')
	
	if filetype == 'c' then
		vim.opt.splitbelow = true
		vim.cmd('sp')
		vim.cmd('res -5')
		vim.cmd('term gcc % -o %< && time ./%<')
	elseif filetype == 'cpp' then
		vim.opt.splitbelow = true
		vim.cmd('!clang++ -std=c++11 % -Wall -o %<')
		vim.cmd('sp')
		vim.cmd('res -15')
		vim.cmd('term ./%<')
	elseif filetype == 'cs' then
		vim.opt.splitbelow = true
		vim.cmd('silent! !mcs %')
		vim.cmd('sp')
		vim.cmd('res -5')
		vim.cmd('term mono %<.exe')
	elseif filetype == 'java' then
		vim.opt.splitbelow = true
		vim.cmd('sp')
		vim.cmd('res -5')
		vim.cmd('term javac % && time java %<')
	elseif filetype == 'sh' then
		vim.cmd('!time bash %')
	elseif filetype == 'python' then
		vim.opt.splitbelow = true
		vim.cmd('sp')
		vim.cmd('term python3 %')
	elseif filetype == 'html' then
		vim.cmd('silent! !' .. vim.g.mkdp_browser .. ' % &')
	elseif filetype == 'markdown' then
		vim.cmd('MarkdownPreview')
	elseif filetype == 'tex' then
		  -- LaTeX compilation can be handled by other means if needed
	
	elseif filetype == 'javascript' then
		vim.opt.splitbelow = true
		vim.cmd('sp')
		vim.cmd('term node %')
	elseif filetype == 'racket' then
		vim.opt.splitbelow = true
		vim.cmd('sp')
		vim.cmd('res -5')
		vim.cmd('term racket %')
	elseif filetype == 'go' then
		vim.opt.splitbelow = true
		vim.cmd('sp')
		vim.cmd('term go run .')
	else
		vim.notify("未支持的文件类型: " .. filetype, vim.log.levels.WARN)
	end
end

-- 智能退出函数
function M.smart_quit()
	vim.cmd("TroubleClose")
	local wins = vim.api.nvim_tabpage_list_wins(0)
	if #wins > 1 then
		run_vim_shortcut([[<C-w>j:q<CR>]])
	end
end

-- 设置键映射
function M.setup()
	vim.keymap.set('n', '<leader>ra', M.run_code, { noremap = true, silent = true, desc = "运行当前文件代码" })
	vim.keymap.set("n", "<leader>q", M.smart_quit, { noremap = true, silent = true, desc = "智能退出" })
end

return M 