local M = {}
-- 给标题自动编号
local function number_headings()
	local num1, num2, num3, num4, num5, num6 = 0, 0, 0, 0, 0, 0
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		if line:match("^# ") then
			num1 = num1 + 1
			num2, num3, num4, num5, num6 = 0, 0, 0, 0, 0
			local new_line = line:gsub("^# ", "# " .. tostring(num1) .. " ")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		elseif line:match("^## ") then
			num2 = num2 + 1
			num3, num4, num5, num6 = 0, 0, 0, 0
			local new_line = line:gsub("^## ", "## " .. tostring(num1) .. "." .. tostring(num2) .. " ")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		elseif line:match("^### ") then
			num3 = num3 + 1
			num4, num5, num6 = 0, 0, 0
			local new_line = line:gsub("^### ",
				"### " .. tostring(num1) .. "." .. tostring(num2) .. "." .. tostring(num3) .. " ")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		elseif line:match("^#### ") then
			num4 = num4 + 1
			num5, num6 = 0, 0
			local new_line = line:gsub("^#### ",
				"#### " .. tostring(num1) .. "." .. tostring(num2) .. "." .. tostring(num3) .. "." .. tostring(num4) .. " ")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		elseif line:match("^##### ") then
			num5 = num5 + 1
			num6 = 0
			local new_line = line:gsub("^##### ",
				"##### " ..
				tostring(num1) ..
				"." .. tostring(num2) .. "." .. tostring(num3) .. "." .. tostring(num4) .. "." .. tostring(num5) .. " ")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		elseif line:match("^###### ") then
			num6 = num6 + 1
			local new_line = line:gsub("^###### ",
				"###### " ..
				tostring(num1) ..
				"." ..
				tostring(num2) ..
				"." .. tostring(num3) .. "." .. tostring(num4) .. "." .. tostring(num5) .. "." .. tostring(num6) .. " ")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 给三级标题编号
local function number_h3_headings()
	local num = 0
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		if line:match("^### ") then
			num = num + 1
			local new_line = line:gsub("^### ", "### " .. tostring(num) .. ". ")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 取消标题编号
local function unnumber_headings(opts)
	-- 获取选择范围
	local start_line, end_line
	
	-- 使用命令提供的范围参数
	if opts and opts.range > 0 then
		start_line = opts.line1
		end_line = opts.line2
	else
		-- 如果没有范围，则处理整个文件
		start_line = 1
		end_line = vim.fn.line('$')
	end
	
	for i = start_line, end_line, 1 do
		local line = vim.fn.getline(i)
		-- 匹配任何级别的标题（# 到 ######），并移除后面的数字编号
		if line:match("^#+%s") then
			-- 改进的正则表达式：匹配 "# " 后面跟着的数字编号模式（如 "1 ", "1. ", "1.1 ", "1.1. "）
			-- 但保留标题文本内容
			local new_line = line:gsub("^(#+%s)%d+[%.%d]*%.?%s+", "%1")
			if new_line and new_line ~= line then
				vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
			end
		end
	end
end
-- 升级标题级别（减少#）
local function upgrade_headings()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		local new_line = line
		if line:match("^###### ") then
			new_line = line:gsub("^###### ", "##### ")
		elseif line:match("^##### ") then
			new_line = line:gsub("^##### ", "#### ")
		elseif line:match("^#### ") then
			new_line = line:gsub("^#### ", "### ")
		elseif line:match("^### ") then
			new_line = line:gsub("^### ", "## ")
		elseif line:match("^## ") then
			new_line = line:gsub("^## ", "# ")
		end
		if new_line ~= line then
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 降级标题级别（增加#）
local function degrade_headings()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		local new_line = line
		if line:match("^# ") then
			new_line = line:gsub("^# ", "## ")
		elseif line:match("^## ") then
			new_line = line:gsub("^## ", "### ")
		elseif line:match("^### ") then
			new_line = line:gsub("^### ", "#### ")
		elseif line:match("^#### ") then
			new_line = line:gsub("^#### ", "##### ")
		elseif line:match("^##### ") then
			new_line = line:gsub("^##### ", "###### ")
		end
		if new_line ~= line then
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 添加换行标签到句子末尾
local function add_br_to_sentences()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		-- 跳过标题行和空行
		if not line:match("^#+ ") and line:match("%S") then
			-- 在非空行末尾添加 <br/>
			local new_line = line:gsub("%s*$", "<br/>")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 移除换行标签
local function remove_br_from_sentences()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		-- 跳过标题行
		if not line:match("^#+ ") then
			-- 移除行尾的 <br/>
			local new_line = line:gsub("<br/>%s*$", "")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 移除Markdown标题的#符号，保留数字编号
local function remove_hash()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		-- 匹配以#开头的行，移除#和后面的空格
		if line:match("^#+%s+") then
			local new_line = line:gsub("^#+%s+", "")
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 添加Markdown标题的#符号，根据数字编号层级确定#的数量
local function add_hash()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		-- 匹配以数字开头的行，兼容两种格式：
		-- 1. "1 content" 或 "1.1 content" (数字后有空格)
		-- 2. "1content" 或 "1.1content" (数字后直接是内容)
		local number_part = line:match("^(%d+[%.%d]*)")
		if number_part and (line:match("^%d+[%.%d]*%s+") or line:match("^%d+[%.%d]*[^%d%.]")) then
			-- 计算点号的数量来确定层级
			local dot_count = select(2, number_part:gsub("%.", ""))
			local level = dot_count + 1 -- 层级 = 点号数量 + 1
			local hash_prefix = string.rep("#", level) .. " "
			-- 检查数字后面是否直接跟着内容（没有空格）
			local content_after_number = line:match("^%d+[%.%d]*(.*)$")
			if content_after_number and not content_after_number:match("^%s") and content_after_number ~= "" then
				-- 如果数字后面直接跟着内容，添加空格
				local new_line = hash_prefix .. number_part .. " " .. content_after_number
				vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
			else
				-- 如果数字后面已经有空格，保持原样
				local new_line = hash_prefix .. line
				vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
			end
		end
	end
end

-- 标准化Markdown标题格式，为没有空格的#标题添加空格
local function normalize_heading_format()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		-- 匹配以#开头但后面没有空格的行
		local hash_part, content = line:match("^(#+)([^%s#].*)")
		if hash_part and content then
			-- 为#后面添加空格
			local new_line = hash_part .. " " .. content
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 生成全文Markdown标题目录并在当前位置插入
local function generate_toc()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local toc_lines = {}
	local current_row = vim.api.nvim_win_get_cursor(0)[1]
	-- 遍历所有行查找标题
	for i, line in ipairs(lines) do
		-- 匹配Markdown标题
		if line:match("^#+%s+") then
			table.insert(toc_lines, line)
		end
	end
	-- 在当前位置插入目录
	table.insert(toc_lines, "") -- 在目录后添加空行
	vim.api.nvim_buf_set_lines(0, current_row - 1, current_row - 1, false, toc_lines)
end
-- 删除所有中括号内容 [...]
local function remove_brackets()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		local new_line = line:gsub("%[[^%]]*%]", "")
		if new_line ~= line then
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 删除所有学术引用 [数字]
local function remove_citations()
	-- 第一步：删除文内引用
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		local new_line = line:gsub("%[%d+%]", "")
		if new_line ~= line then
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
	-- 第二步：删除引用列表行
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local filtered_lines = {}
	for _, line in ipairs(lines) do
		if not line:match("^%[%d+%]") then
			table.insert(filtered_lines, line)
		end
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, filtered_lines)
end
-- 删除反引号包裹的中括号 `[...]`
local function remove_quoted_brackets()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		local new_line = line:gsub("`%[[^%]]*%]`", "")
		if new_line ~= line then
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 删除行尾空格
local function remove_trailing_spaces()
	for i = 1, vim.fn.line('$'), 1 do
		local line = vim.fn.getline(i)
		local new_line = line:gsub("%s+$", "")
		if new_line ~= line then
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, { new_line })
		end
	end
end
-- 删除空行
local function remove_blank_lines()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local filtered_lines = {}
	for _, line in ipairs(lines) do
		if line:match("%S") then
			table.insert(filtered_lines, line)
		end
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, filtered_lines)
end
-- 删除多余空行（连续空行只保留一行）
local function remove_extra_blank_lines()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local filtered_lines = {}
	local prev_blank = false
	for _, line in ipairs(lines) do
		local is_blank = not line:match("%S")
		if not is_blank or not prev_blank then
			table.insert(filtered_lines, line)
		end
		prev_blank = is_blank
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, filtered_lines)
end
-- 删除引用URL行（[数字] URL格式的行）
local function remove_reference_urls()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local filtered_lines = {}
	for _, line in ipairs(lines) do
		-- 匹配 [数字] 后面跟着URL的行
		if not line:match("^%[%d+%]%s+https?://") then
			table.insert(filtered_lines, line)
		end
	end
	vim.api.nvim_buf_set_lines(0, 0, -1, false, filtered_lines)
end
-- 将数字编号转换为Markdown标题
function M.convert_to_markdown_headings()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local result = {}
	for _, line in ipairs(lines) do
		-- 匹配像 "1.", "1.1.", "1.1.1." 这样的模式
		local prefix, content = line:match("^([%d%.]+)(.*)$")
		if prefix then
			local depth = select(2, prefix:gsub("%.", ""))
			-- 创建对应层级的Markdown标题
			local heading_prefix = string.rep("#", depth) .. " "
			table.insert(result, heading_prefix .. content:gsub("^%s*", ""))
		else
			-- 如果没有找到数字前缀，保持行不变
			table.insert(result, line)
		end
	end
	-- 用结果替换缓冲区内容
	vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
end

-- 设置命令和键映射
function M.setup()
	local commands = {
		{ name = 'NumberHeadings', func = number_headings, desc = "给标题编号" },
		{ name = 'UnnumberHeadings', func = unnumber_headings, desc = "取消标题编号" },
		{ name = 'AddBrToSentences', func = add_br_to_sentences, desc = "添加换行标签" },
		{ name = 'RemoveBrFromSentences', func = remove_br_from_sentences, desc = "移除换行标签" },
		{ name = 'UpgradeHeadings', func = upgrade_headings, desc = "升级标题级别" },
		{ name = 'DegradeHeadings', func = degrade_headings, desc = "降级标题级别" },
		{ name = 'Numberh3headings', func = number_h3_headings, desc = "给三级标题编号" },
		{ name = 'NumberedToMarkdown', func = M.convert_to_markdown_headings, desc = "将数字编号转换为Markdown标题" },
		{ name = 'RemoveHash', func = remove_hash, desc = "移除Markdown标题的#符号，保留数字编号" },
		{ name = 'AddHash', func = add_hash, desc = "添加Markdown标题的#符号，根据数字编号层级确定#的数量" },
		{ name = 'NormalizeHeadings', func = normalize_heading_format, desc = "标准化Markdown标题格式，为没有空格的#标题添加空格" },
		{ name = 'GenerateToc', func = generate_toc, desc = "生成全文Markdown标题目录" },
		{ name = 'RemoveBrackets', func = remove_brackets, desc = "删除所有中括号内容" },
		{ name = 'RemoveCitations', func = remove_citations, desc = "删除所有学术引用" },
		{ name = 'RemoveQuotedBrackets', func = remove_quoted_brackets, desc = "删除反引号包裹的中括号" },
		{ name = 'RemoveTrailingSpaces', func = remove_trailing_spaces, desc = "删除行尾空格" },
		{ name = 'RemoveBlankLines', func = remove_blank_lines, desc = "删除空行" },
		{ name = 'RemoveExtraBlankLines', func = remove_extra_blank_lines, desc = "删除多余空行" },
		{ name = 'RemoveReferenceUrls', func = remove_reference_urls, desc = "删除引用URL行" },
	}
	
	for _, cmd in ipairs(commands) do
		-- UnnumberHeadings 需要接收范围参数
		if cmd.name == 'UnnumberHeadings' then
			vim.api.nvim_create_user_command(cmd.name, function(opts)
				cmd.func(opts)
			end, { range = true, desc = cmd.desc })
		else
			vim.api.nvim_create_user_command(cmd.name, cmd.func, { range = true, desc = cmd.desc })
		end
	end
end

return M
