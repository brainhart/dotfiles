
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end


-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Map colon to semicolon and the reverse
nmap(';', ':')
nmap(':', ';')
map('v', ';', ':')
map('v', ':', ';')

-- Switch windows
map('', '<C-j>', '<C-w>j')
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')
map('', '<C-h>', '<C-w>h')

-- Clean search (highlight)
nmap('<leader><space>', ':noh<cr>')

-- Create Splits
map('', '<leader>h', ':<C-u>split<CR>')
map('', '<leader>v', ':<C-u>vsplit<CR>')

-- Vmap for maintain Visual Mode after shifting > and <
vim.api.nvim_set_keymap("v", "<", "<gv", {})
vim.api.nvim_set_keymap("v", ">", ">gv", {})
