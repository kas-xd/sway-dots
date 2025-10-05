-- Python
vim.lsp.config('pyright', {
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'workspace',
				typeCheckingMode = 'basic',
			},
		},
	},
})

-- Lua
vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', '.git' },
	settings = {
		Lua = {
			diagnostics = { globals = { 'vim' } },
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

-- Typst
vim.lsp.config('tinymist', {
	cmd = { 'tinymist' },
	filetypes = { 'typst' },
	root_markers = { '.git' },
	settings = {
		exportPdf = 'onSave',
		formatterMode = 'typstyle',
	},
})

-- Enable all LSPs
vim.lsp.enable({ 
	'lua_ls', 
	'pyright',  
	'tinymist', 
})