local M = {}
-- 中英文标点映射表
local punctuation_map = {
	['，'] = ',',
	['。'] = '.',
	['？'] = '?',
	['！'] = '!',
	['：'] = ':',
	['；'] = ';',
	['"'] = '"',
	['"'] = '"',
	['「'] = '"',
	['」'] = '"',
	['（'] = '(',
	['）'] = ')',
	['【'] = '[',
	['】'] = ']',
	['《'] = '<',
	['》'] = '>',
	['…'] = '...',
	['、'] = ',',
	['～'] = '~',
	['·'] = '.',
	['『'] = '"',
	['』'] = '"',
	['〈'] = '<',
	['〉'] = '>',
	['［'] = '[',
	['］'] = ']',
	['｛'] = '{',
	['｝'] = '}'
}
-- 创建反向映射表（英文到中文）
local reverse_punctuation_map = {}
for cn, en in pairs(punctuation_map) do
	reverse_punctuation_map[en] = cn
end
-- 移除所有重复行
local function remove_all_duplicates()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local seen = {}
	local unique_lines = {}
	local total_lines = #lines
	for _, line in ipairs(lines) do
		if not seen[line] then
			seen[line] = true
			table.insert(unique_lines, line)
		end
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, unique_lines)
	local removed = total_lines - #unique_lines
	vim.notify("删除了 " .. removed .. " 个重复行", vim.log.levels.INFO)
end
-- 移除连续重复行
local function remove_consecutive_duplicates()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local unique_lines = {}
	local total_lines = #lines
	for i, line in ipairs(lines) do
		if i == 1 or line ~= lines[i - 1] then
			table.insert(unique_lines, line)
		end
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, unique_lines)
	local removed = total_lines - #unique_lines
	vim.notify("删除了 " .. removed .. " 个连续重复行", vim.log.levels.INFO)
end
-- 中文标点转英文标点
local function cn_punc_to_en_punc()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local modified_lines = {}
	local changes = 0
	for _, line in ipairs(lines) do
		local modified_line = line
		for cn_punct, en_punct in pairs(punctuation_map) do
			local count
			modified_line, count = modified_line:gsub(cn_punct, en_punct)
			changes = changes + count
		end
		table.insert(modified_lines, modified_line)
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, modified_lines)
	vim.notify("转换了 " .. changes .. " 个中文标点为英文标点", vim.log.levels.INFO)
end
-- 智能切换中英文标点
local function toggle_cn_en_punc()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	-- 统计中英文标点数量以决定转换方向
	local cn_count, en_count = 0, 0
	for _, line in ipairs(lines) do
		for cn_punct, _ in pairs(punctuation_map) do
			cn_count = cn_count + select(2, line:gsub(cn_punct, ""))
		end
		for en_punct, _ in pairs(reverse_punctuation_map) do
			local pattern = en_punct:gsub("([%%%[%]%(%)%.%*%+%-%?%^%$])", "%%%1")
			en_count = en_count + select(2, line:gsub(pattern, ""))
		end
	end
	-- 根据标点数量确定转换方向
	local is_cn_to_en = cn_count >= en_count
	local map_to_use = is_cn_to_en and punctuation_map or reverse_punctuation_map
	local modified_lines = {}
	local changes = 0
	for _, line in ipairs(lines) do
		local modified_line = line
		for from_punct, to_punct in pairs(map_to_use) do
			local count
			local pattern = from_punct:gsub("([%%%[%]%(%)%.%*%+%-%?%^%$])", "%%%1")
			modified_line, count = modified_line:gsub(pattern, to_punct)
			changes = changes + count
		end
		table.insert(modified_lines, modified_line)
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, modified_lines)
	local direction = is_cn_to_en and "中文到英文" or "英文到中文"
	vim.notify("已转换 " .. changes .. " 个标点符号（" .. direction .. "）", vim.log.levels.INFO)
end
-- 给数字补零
local function pad_numbers()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local modified_lines = {}
	local changes = 0
	for _, line in ipairs(lines) do
		local modified_line = line:gsub("G(%d+)", function(num)
			local padded_num = string.format("%03d", tonumber(num))
			changes = changes + 1
			return "G" .. padded_num
		end)
		table.insert(modified_lines, modified_line)
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, modified_lines)
	vim.notify("为 " .. changes .. " 个数字补零", vim.log.levels.INFO)
end
-- 移除数字前导零
local function unpad_numbers()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local modified_lines = {}
	local total_changes = 0
	for _, line in ipairs(lines) do
		local modified_line, changes_in_line = line:gsub("G(%d+)", function(num_str)
			local unpadded_num = tostring(tonumber(num_str))
			return "G" .. unpadded_num
		end)
		total_changes = total_changes + changes_in_line
		table.insert(modified_lines, modified_line)
	end
	if total_changes > 0 then
		vim.api.nvim_buf_set_lines(0, 0, -1, false, modified_lines)
		vim.notify("移除了 " .. total_changes .. " 个数字的前导零", vim.log.levels.INFO)
	else
		vim.notify("没有找到需要移除前导零的数字", vim.log.levels.INFO)
	end
end
-- 数学运算函数
local function perform_math_operation(operation, operand)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local modified_lines = {}
	local changes = 0
	if not operation or not operand then
		vim.notify("用法: :PerformMathOperation [operation] [operand]", vim.log.levels.ERROR)
		vim.notify("示例: :PerformMathOperation divide 365", vim.log.levels.INFO)
		return
	end
	local op_value = tonumber(operand)
	if not op_value then
		vim.notify("错误: 操作数必须是数字", vim.log.levels.ERROR)
		return
	end
	for _, line in ipairs(lines) do
		local modified_line = line:gsub("(%d+%.?%d*)", function(number_str)
			local num = tonumber(number_str)
			if num then
				local result
				if operation == "divide" then
					result = num / op_value
				elseif operation == "multiply" then
					result = num * op_value
				elseif operation == "add" then
					result = num + op_value
				elseif operation == "subtract" then
					result = num - op_value
				else
					return number_str
				end
				changes = changes + 1
				return string.format("%.2f", result)
			else
				return number_str
			end
		end)
		table.insert(modified_lines, modified_line)
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, modified_lines)
	vim.notify("修改了 " .. changes .. " 个数字", vim.log.levels.INFO)
end
-- 删除Python注释和文档字符串
local function remove_python_comments_and_docstrings()
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local source = table.concat(lines, "\n")
	local script_path = "/Users/tianli/useful_scripts/remove_comments.py"
	local cmd = { "python3", script_path }
	local result = vim.fn.system(cmd, source)
	if vim.v.shell_error ~= 0 then
		vim.notify("删除注释时出错: " .. result, vim.log.levels.ERROR)
		return
	end
	local new_lines = vim.split(result, "\n")
	if new_lines[#new_lines] == '' then
		table.remove(new_lines, #new_lines)
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
	vim.notify("已删除Python注释和文档字符串", vim.log.levels.INFO)
end
-- 行编号函数
function M.number_lines_from_zero()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local start_line = vim.fn.getpos("'<")[2]
	local end_line = vim.fn.getpos("'>")[2]
	local offset = start_line - 1
	vim.cmd('silent! ' .. start_line .. ',' .. end_line .. 's/^/\\=printf("%02d_", line(".") - ' .. offset .. ')/')
	vim.api.nvim_win_set_cursor(0, cursor_pos)
	vim.cmd('noh')
end

-- 插入空行
local function insert_blank_lines()
	local total_lines = vim.api.nvim_buf_line_count(0)
	local number = 100
	for i = number, total_lines, number do
		vim.api.nvim_buf_set_lines(0, i, i, false, { "" })
	end
	vim.notify("已插入空行", vim.log.levels.INFO)
end
-- 县级地名替换为地级市
local function replace_to_prefecture()
	local prefecture_map = {
		-- 衢州市
		["柯城"] = "衢州",
		["衢江"] = "衢州",
		["龙游"] = "衢州",
		-- 金华市
		["婺城"] = "金华",
		["兰溪"] = "金华",
		-- 杭州市
		["建德"] = "杭州",
		["桐庐"] = "杭州",
		["富阳"] = "杭州",
		["西湖"] = "杭州",
		["萧山"] = "杭州",
		["滨江"] = "杭州",
		["钱塘区"] = "杭州",
		["上城区"] = "杭州",
		-- 绍兴市
		["柯桥"] = "绍兴",
		["越城"] = "绍兴",
		["上虞"] = "绍兴",
		-- 宁波市
		["余姚"] = "宁波",
		["杭州湾新区"] = "宁波",
		["慈溪"] = "宁波",
		-- 嘉兴市
		["海宁市"] = "嘉兴",
		["海盐县"] = "嘉兴",
		["平湖市"] = "嘉兴",
	}
	-- 获取所有行
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local changes = 0
	-- 处理每一行
	for i, line in ipairs(lines) do
		local original_line = line
		for county, prefecture in pairs(prefecture_map) do
			line = line:gsub(county, prefecture)
		end
		if line ~= original_line then
			changes = changes + 1
		end
		lines[i] = line
	end
	-- 写回缓冲区
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.notify("替换了 " .. changes .. " 行中的县级地名为地级市", vim.log.levels.INFO)
end

-- ================== 新功能添加区域 ==================
-- 在这里添加新的功能函数...

-- 去掉圈圈数字
local function remove_circle_numbers()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local modified_lines = {}
    local changes = 0
    
    -- 圈圈数字的Unicode字符列表
    local circle_numbers = {
        "①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩", 
        "⑪", "⑫", "⑬", "⑭", "⑮", "⑯", "⑰", "⑱", "⑲", "⑳"
    }
    
    for _, line in ipairs(lines) do
        local new_line = line
        local original_line = line
        
        -- 逐个替换圈圈数字
        for _, circle_num in ipairs(circle_numbers) do
            new_line = new_line:gsub(circle_num, "")
        end
        
        -- 清理多余的标点和空格
        new_line = new_line:gsub("^、", "")  -- 开头的顿号
        new_line = new_line:gsub("、、+", "、")  -- 连续的顿号
        new_line = new_line:gsub("、$", "")  -- 结尾的顿号
        new_line = new_line:gsub("^%s+", "")  -- 开头的空格
        new_line = new_line:gsub("%s+", " ")  -- 多个空格变一个
        new_line = new_line:gsub("^%s*$", "")  -- 只有空格的行变成空行
        
        if new_line ~= original_line then
            changes = changes + 1
        end
        
        table.insert(modified_lines, new_line)
    end
    
    vim.api.nvim_buf_set_lines(0, 0, -1, false, modified_lines)
    vim.notify("处理了 " .. changes .. " 行，移除了圈圈数字", vim.log.levels.INFO)
end



-- ================== 统一注册区域 ==================
-- 设置命令和键映射
function M.setup()
	-- 创建所有命令
	vim.api.nvim_create_user_command("RemoveDuplicates", remove_all_duplicates, {})
	vim.api.nvim_create_user_command("RemoveConsecutiveDuplicates", remove_consecutive_duplicates, {})
	vim.api.nvim_create_user_command("Cnpunc2Enpun", cn_punc_to_en_punc, {})
	vim.api.nvim_create_user_command("ToggleCNEPunc", toggle_cn_en_punc, {})
	vim.api.nvim_create_user_command("PadNumbers", pad_numbers, {})
	vim.api.nvim_create_user_command("UnpadNumbers", unpad_numbers, {})
	vim.api.nvim_create_user_command("RemovePythonComments", remove_python_comments_and_docstrings, {})
	vim.api.nvim_create_user_command("InsertBlankLines", insert_blank_lines, {})
	vim.api.nvim_create_user_command("ReplaceToPrefecture", replace_to_prefecture, {})
	vim.api.nvim_create_user_command("RemoveCircleNumbers", remove_circle_numbers, {})
	vim.api.nvim_create_user_command("PerformMathOperation", function(opts)
		local args = vim.split(opts.args, " ")
		perform_math_operation(args[1], args[2])
	end, {
		nargs = "+",
		complete = function(_, _, _)
			return { "divide", "multiply", "add", "subtract" }
		end
	})
	
	-- 设置所有键映射
	vim.api.nvim_set_keymap('x', '<leader>nl', [[:<C-u>lua require('config.text_utils').number_lines_from_zero()<CR>]],
		{ noremap = true, silent = true, desc = "从0开始给行编号" })
	vim.api.nvim_set_keymap('n', '<leader>rp', ':ReplaceToPrefecture<CR>',
		{ noremap = true, silent = true, desc = "替换县级地名为地级市" })
	
	-- 在这里添加新功能的命令和快捷键注册...
end

return M
