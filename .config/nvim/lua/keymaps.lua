vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map({'i'}, 'kj', '<Esc>', { silent = true })
map({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, {buffer=bufnr, desc='LSP: [Code] Action'})
map({'n'},'<leader>cr', vim.lsp.buf.rename, {buffer=bufnr, desc='LSP: [C]ode [R]ename'})
map({'n'},'<leader>rn', vim.lsp.buf.rename, {buffer=bufnr, desc='LSP: [R]e[n]ame'})

--try to keep all my keymappings in here so I know where I can
--go when i have any conflicts

map({ 'i' }, 'kj', '<Esc>', { silent = true })
--open neotree.....i'm use to this keymap from nerdtree days

-- Keymaps for better default experience
-- See `:help map()`
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

map('t', 'kj', "<C-\\><C-N>", { desc = 'return to normal mode. |CTRL-\\_CTRL-N' })

--build in terminal
map('n', '<leader>db', ':term<CR>adotnet build --no-restore<CR>exit<CR><CR>', { desc = '[D]otnet [B]uild' , silent = true })

--some toggleterm shortcuts
map('n', '<leader>ht', ':ToggleTerm direction=horizontal<CR>', { desc = '[H]orizontal terminal', silent = true })
map('n', '<leader>vt', ':ToggleTerm direction=vertical size=60<CR>', { desc = '[V]ertical terminal', silent = true })

--move whole lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
