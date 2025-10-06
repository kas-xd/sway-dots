vim.pack.add({
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("mini.completion").setup({
	delay = { completion = 100, info = 100, signature = 50 },
	window = {
		info = { height = 25, width = 80, border = "rounded" },
		signature = { height = 25, width = 80, border = "rounded" },
	},
})
require("mini.pick").setup()
require("mini.pairs").setup()
require("mini.jump").setup()

require("oil").setup({
	view_options = { show_hidden = true },
})

require("lualine").setup({
	options = {
		theme = "gruvbox",
		icons_enabled = false,
		component_separators = "|",
		section_separators = "",
	},
	sections = {
		lualine_b = { "branch", "diff", "diagnostics" },
	},
})

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 500,
	},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "python", "lua", "markdown", "typst" },
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { desc = "Expand/jump snippet" })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { desc = "Jump snippet backward" })

vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	elseif ls.expand_or_jumpable() then
		return "<Plug>luasnip-expand-or-jump"
	else
		return "<Tab>"
	end
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>"
	elseif ls.jumpable(-1) then
		return "<Plug>luasnip-jump-prev"
	else
		return "<S-Tab>"
	end
end, { expr = true })

vim.keymap.set("i", "<CR>", [[pumvisible() ? "\<C-y>" : "\<CR>"]], { expr = true })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		typst = { "typstfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })
