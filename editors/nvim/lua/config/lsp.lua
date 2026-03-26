-- ==========================================
-- 统一LSP配置
-- ==========================================

local M = {}
local F = {}
local documentation_window_open = false

-- LSP相关工具函数
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local limitStr = function(str)
	if #str > 25 then
		str = string.sub(str, 1, 22) .. "..."
	end
	return str
end



-- 配置文档和签名
F.configureDocAndSignature = function()
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help, {
			focusable = false,
			border = "rounded",
			zindex = 60,
		}
	)
	local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
	vim.api.nvim_create_autocmd({ "CursorHold" }, {
		pattern = "*",
		callback = function()
			if not documentation_window_open then
				vim.diagnostic.open_float(0, {
					scope = "cursor",
					focusable = false,
					zindex = 10,
					close_events = {
						"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre",
						"InsertEnter", "WinLeave", "ModeChanged"
					},
				})
			end
		end,
		group = group,
	})
end

-- 配置文档显示
local documentation_window_open_index = 0
local function show_documentation()
	documentation_window_open_index = documentation_window_open_index + 1
	local current_index = documentation_window_open_index
	documentation_window_open = true
	vim.defer_fn(function()
		if current_index == documentation_window_open_index then
			documentation_window_open = false
		end
	end, 500)
	vim.lsp.buf.hover()
end

-- 配置LSP键绑定
F.configureKeybinds = function()
	vim.api.nvim_create_autocmd('LspAttach', {
		desc = 'LSP actions',
		callback = function(event)
			local opts = { buffer = event.buf, noremap = true, nowait = true }
			vim.keymap.set('n', '<leader>h', show_documentation, opts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			vim.keymap.set('n', 'gD', ':tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>', opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
			vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
			vim.keymap.set('n', '<leader>aw', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', "<leader>,", vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', '<leader>-', vim.diagnostic.goto_prev, opts)
			vim.keymap.set('n', '<leader>=', vim.diagnostic.goto_next, opts)
		end
	})
end

-- 签名配置
F.signature_config = {}

-- LSP主配置
M = {
	{
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{
				'williamboman/mason.nvim',
				build = ":MasonUpdate",
			},
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'j-hui/fidget.nvim',                tag = "legacy" },
			"folke/neodev.nvim",
			"ray-x/lsp_signature.nvim",



		},
		config = function()
			local lsp = require('lsp-zero').preset({})
			M.lsp = lsp

			-- Mason设置
			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {
					"biome", "cssls", 'ts_ls', 'eslint', 'gopls', 'jsonls', 'html',
					'clangd', 'dockerls', 'ansiblels', 'terraformls', 'texlab',
					'pyright', 'yamlls', 'tailwindcss', 'taplo', "prismals"
				}
			})

			-- LSP attach配置
			lsp.on_attach(function(client, bufnr)
				if client.name == "ts_ls" and vim.bo[bufnr].filetype ~= "javascript" then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
				lsp.default_keymaps({ buffer = bufnr })
				client.server_capabilities.semanticTokensProvider = nil

				-- 配置自动补全
				require("config.autocomplete").setup()
				require("lsp_signature").on_attach(F.signature_config, bufnr)

				vim.diagnostic.config({
					severity_sort = true,
					underline = true,
					signs = true,
					virtual_text = false,
					update_in_insert = false,
					float = true
				})
				lsp.set_sign_icons({
					error = '✘', warn = '▲', hint = '⚑', info = '»'
				})
			end)

			lsp.set_server_config({
				on_init = function(client)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})

			lsp.format_on_save({ format_opts = {} })

			-- 配置 Neodev
			require("neodev").setup({ lspconfig = false, override = function() end })

			-- Lua LSP配置
			vim.lsp.config.lua_ls = {
				cmd = { 'lua-language-server' },
				filetypes = { 'lua' },
				root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
				settings = {
					Lua = {
						diagnostics = { globals = { 'vim', 'require' } },
						workspace = { checkThirdParty = false },
						completion = { callSnippet = "Replace" }
					}
				}
			}

			-- JSON LSP配置
			vim.lsp.config.jsonls = {
				cmd = { 'vscode-json-language-server', '--stdio' },
				filetypes = { 'json', 'jsonc' },
				root_markers = { '.git' }
			}

			-- HTML LSP配置
			vim.lsp.config.html = {
				cmd = { 'vscode-html-language-server', '--stdio' },
				filetypes = { 'html' },
				root_markers = { '.git' }
			}

			-- Python LSP配置
			vim.lsp.config.pyright = {
				cmd = { 'pyright-langserver', '--stdio' },
				filetypes = { 'python' },
				root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' }
			}

			-- TailwindCSS LSP配置
			vim.lsp.config.tailwindcss = {
				cmd = { 'tailwindcss-language-server', '--stdio' },
				filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
				root_markers = { 'tailwind.config.js', 'tailwind.config.ts', '.git' }
			}

			-- TypeScript LSP配置
			vim.lsp.config.ts_ls = {
				cmd = { 'typescript-language-server', '--stdio' },
				filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
				root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }
			}

			-- Biome LSP配置
			vim.lsp.config.biome = {
				cmd = { 'biome', 'lsp-proxy' },
				filetypes = { 'javascript', 'javascriptreact', 'json', 'jsonc', 'typescript', 'typescriptreact' },
				root_markers = { 'biome.json', '.git' }
			}

			-- CSS LSP配置
			vim.lsp.config.cssls = {
				cmd = { 'vscode-css-language-server', '--stdio' },
				filetypes = { 'css', 'scss', 'less' },
				root_markers = { '.git' }
			}

			-- TOML LSP配置
			vim.lsp.config.taplo = {
				cmd = { 'taplo', 'lsp', 'stdio' },
				filetypes = { 'toml' },
				root_markers = { '.git' }
			}

			-- Ansible LSP配置
			vim.lsp.config.ansiblels = {
				cmd = { 'ansible-language-server', '--stdio' },
				filetypes = { 'yaml.ansible' },
				root_markers = { 'ansible.cfg', '.git' }
			}

			-- Terraform LSP配置
			vim.lsp.config.terraformls = {
				cmd = { 'terraform-ls', 'serve' },
				filetypes = { 'terraform', 'tf' },
				root_markers = { '.terraform', '.git' }
			}

			-- Prisma LSP配置
			vim.lsp.config.prismals = {
				cmd = { 'prisma-language-server', '--stdio' },
				filetypes = { 'prisma' },
				root_markers = { 'schema.prisma', '.git' }
			}

			-- TeX LSP配置
			vim.lsp.config.texlab = {
				cmd = { 'texlab' },
				filetypes = { 'tex', 'bib' },
				root_markers = { '.latexmkrc', '.git' },
				settings = {
					texlab = {
						bibtexFormatter = "texlab",
						build = {
							args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
							executable = "latexmk", forwardSearchAfter = false, onSave = true
						},
						chktex = { onEdit = false, onOpenAndSave = false },
						diagnosticsDelay = 300, formatterLineLength = 80,
						forwardSearch = { args = {} },
						latexFormatter = "latexindent",
						latexindent = { modifyLineBreaks = false }
					}
				}
			}

			-- YAML LSP配置
			vim.lsp.config.yamlls = {
				cmd = { 'yaml-language-server', '--stdio' },
				filetypes = { 'yaml', 'yaml.docker-compose' },
				root_markers = { '.git' },
				settings = {
					redhat = { telemetry = { enabled = false } },
					yaml = {
						schemaStore = { enable = false },
						validate = false,
						customTags = {
							"!fn", "!And", "!If", "!Not", "!Equals", "!Or", "!FindInMap sequence",
							"!Base64", "!Cidr", "!Ref", "!Sub", "!GetAtt", "!GetAZs",
							"!ImportValue", "!Select", "!Split", "!Join sequence"
						}
					}
				}
			}

			-- Go LSP配置
			vim.lsp.config.gopls = {
				cmd = { 'gopls' },
				filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
				root_markers = { 'go.work', 'go.mod', '.git' }
			}

			-- 启用所有配置的 LSP 服务器
			vim.lsp.enable({ 'lua_ls', 'jsonls', 'html', 'pyright', 'tailwindcss', 'ts_ls', 'biome', 'cssls', 'taplo', 'ansiblels', 'terraformls', 'prismals', 'texlab', 'yamlls', 'gopls' })

			lsp.setup()

			-- 自动格式化配置
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				pattern = { "*.tf", "*.tfvars", "*.lua" },
				callback = function() vim.lsp.buf.format() end,
			})

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				pattern = { "*.hcl" },
				callback = function()
					local bufnr = vim.api.nvim_get_current_buf()
					local filename = vim.api.nvim_buf_get_name(bufnr)
					vim.fn.system(string.format("packer fmt %s", vim.fn.shellescape(filename)))
					vim.cmd("edit!")
				end,
			})

			-- 折叠支持
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false, lineFoldingOnly = true
			}
			-- 将折叠能力添加到所有 LSP 配置中
			for _, server in ipairs({ 'lua_ls', 'jsonls', 'html', 'pyright', 'tailwindcss', 'ts_ls', 'biome', 'cssls', 'taplo', 'ansiblels', 'terraformls', 'prismals', 'texlab', 'yamlls', 'gopls' }) do
				if vim.lsp.config[server] then
					vim.lsp.config[server].capabilities = vim.tbl_deep_extend(
						'force',
						vim.lsp.config[server].capabilities or {},
						capabilities,
						require('cmp_nvim_lsp').default_capabilities()
					)
				end
			end

			require("fidget").setup({})


			F.configureDocAndSignature()
			F.configureKeybinds()

			-- 格式化文件类型配置
			local format_on_save_filetypes = {
				json = false,
				lua = true,
				html = true,
				css = true,
				javascript = true,
				typescript = true,
				typescriptreact = true,
				c = true,
				cpp = true,
				objc = true,
				objcpp = true,
				dockerfile = true,
				terraform = false,
				tex = true,
				toml = true,
				prisma = true
			}

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function()
					if format_on_save_filetypes[vim.bo.filetype] then
						local lineno = vim.api.nvim_win_get_cursor(0)
						vim.lsp.buf.format({ async = false })
						pcall(vim.api.nvim_win_set_cursor, 0, lineno)
					end
				end,
			})
		end
	},
}

return M

