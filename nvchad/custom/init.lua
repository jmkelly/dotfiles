-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
vim.opt.relativenumber = true
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
