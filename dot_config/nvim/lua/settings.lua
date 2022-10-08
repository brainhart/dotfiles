
vim.api.nvim_command [[filetype plugin indent on]]
vim.g.mapleader = ","
vim.wo.relativenumber = true
vim.wo.number = true

vim.opt.updatetime=500 -- Smaller updatetime for CursorHold & CursorHoldI
-- vim.opt.shortmess+=c
vim.opt.signcolumn='yes'
vim.opt.autoread=true

vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.softtabstop=2
vim.opt.expandtab=true



vim.opt.autoindent=true
vim.wo.colorcolumn=100 --      " Turn on the colored column at column 80
vim.opt.textwidth=100
vim.opt.cursorline=true
vim.opt.wrap=false
vim.opt.spelllang='en_us'
vim.opt.mat=1 --               " How many seconds to blink on a matched paren
vim.opt.backspace='indent,eol,start' -- " Backspace for insert mode
vim.opt.ruler=true

vim.opt.inccommand='split' -- " Interactive substitute

vim.opt.shell='/bin/sh'

-- " Encoding
vim.opt.encoding='utf-8'
vim.opt.fileencoding='utf-8'
vim.opt.fileencodings='utf-8'
vim.opt.bomb=true
vim.opt.binary=true

vim.opt.fileformats='unix,dos,mac'

-- " Enable hidden buffers
vim.opt.hidden=true

-- " Searching
vim.opt.hlsearch=true
vim.opt.incsearch=true
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.backup=false
vim.opt.swapfile=false
vim.opt.writebackup=false

vim.opt.clipboard='unnamed,unnamedplus'

vim.opt.title=true
vim.opt.titleold="Terminal"
vim.opt.titlestring='%F'

vim.opt.termguicolors=true


vim.api.nvim_command [[colorscheme terafox]]

vim.api.nvim_exec('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}', false)

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
