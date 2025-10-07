vim.loader.enable()
vim.g.mapleader = ' '
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8
vim.opt.winborder = "single"
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.updatetime = 200
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.undofile = true

-- plugins
vim.pack.add({
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/echasnovski/mini.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/mbbill/undotree' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

-- theme
require('gruvbox').setup({ transparent_mode = true })
vim.cmd.colorscheme('gruvbox')

-- gitsigns
require('gitsigns').setup({
  signs = {
    add = { text = '▎' }, change = { text = '▎' }, delete = { text = '▁' },
    topdelete = { text = '▔' }, changedelete = { text = '▎' },
  },
})

-- oil
require('oil').setup({
  skip_confirm_for_simple_edits = true,
  view_options = { show_hidden = true },
})

-- mini.nvim
require('mini.pairs').setup()
require('mini.jump').setup()
require('mini.pick').setup()
require('mini.snippets').setup()
require('mini.completion').setup({
  window = { info = { border = 'rounded' }, signature = { border = 'rounded' } },
})
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.comment').setup()

-- statusline
local statusline = require('mini.statusline')
statusline.setup({ use_icons = false })
vim.api.nvim_set_hl(0, 'StatusLine',   { fg = '#ebdbb2', bg = '#3c3836' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#a89984', bg = '#282828' })

-- treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'python', 'typst' },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
})

-- keymaps
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>",  { desc = "Quit" })
vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>",     { desc = "Files" })
vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<CR>", { desc = "Grep" })
vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<CR>",   { desc = "Buffers" })
vim.keymap.set("n", "<leader>h", "<cmd>Pick help<CR>",      { desc = "Help" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>",            { desc = "Explorer" })
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "UndoTree" })

-- lsp maps
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,      { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition,          { desc = 'Definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references,          { desc = 'References' })
vim.keymap.set('n', 'K',  vim.lsp.buf.hover,               { desc = 'Hover' })

-- diagnostics
vim.diagnostic.config({
  virtual_text = true, signs = true, underline = true,
  update_in_insert = false, severity_sort = true,
})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diag' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diag' })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show Diag" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diag List" })

-- lsp
local lsp_caps = require('mini.completion').get_lsp_capabilities()
vim.lsp.config('*', { capabilities = lsp_caps })

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      diagnostics = { globals = { 'vim', 'require' } },
    },
  },
})
vim.lsp.config('pyright', {})
vim.lsp.config('tinymist', {})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    pcall(vim.lsp.inlay_hint.enable, true, args.buf)
  end,
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'pyright', 'tinymist' },
  automatic_enable = false,
})

for _, name in ipairs({ 'lua_ls', 'pyright', 'tinymist' }) do
  pcall(vim.lsp.enable, name)
end
