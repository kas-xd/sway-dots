require('options')
require('keymaps')
require('plugins')
require('lsp')

-- Theme
require('gruvbox').setup({ transparent_mode = true })
vim.cmd.colorscheme('gruvbox')
