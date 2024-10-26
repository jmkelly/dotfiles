vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set({'i'}, 'kj', '<Esc>', { silent = true })
vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, {buffer=bufnr, desc='LSP: [Code] Action'})
vim.keymap.set({'n'},'<leader>cr', vim.lsp.buf.rename, {buffer=bufnr, desc='LSP: [C]ode [R]ename'})
vim.keymap.set({'n'},'<leader>rn', vim.lsp.buf.rename, {buffer=bufnr, desc='LSP: [R]e[n]ame'})

--try to keep all my keymappings in here so I know where I can
--go when i have any conflicts

vim.keymap.set({ 'i' }, 'kj', '<Esc>', { silent = true })
--open neotree.....i'm use to this keymap from nerdtree days
vim.keymap.set('n', "<leader>nt", ':Neotree toggle<CR>', { desc = 'Open or close Neotree', silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('t', 'kj', "<C-\\><C-N>", { desc = 'return to normal mode. |CTRL-\\_CTRL-N' })

--vim-test
vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>', { desc = '[T]est [N]earest', silent = true })
vim.keymap.set('n', '<leader>ta', ':TestSuite<CR>', { desc = '[T]est [A]ll', silent = true })

--build in terminal
vim.keymap.set('n', '<leader>db', ':term<CR>adotnet build<CR>exit<CR><CR>', { desc = '[D]otnet [B]uild' , silent = true })
vim.keymap.set('n', '<leader>dt', ':term<CR>adotnet test<CR>exit<CR>', { desc = '[D]otnet [T]est ', silent = true })

--some toggleterm shortcuts
vim.keymap.set('n', '<leader>ht', ':ToggleTerm direction=horizontal<CR>', { desc = '[H]orizontal terminal', silent = true })
vim.keymap.set('n', '<leader>vt', ':ToggleTerm direction=vertical size=60<CR>', { desc = '[V]ertical terminal', silent = true })

--move whole lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
