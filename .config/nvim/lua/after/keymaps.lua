--telescope ones from kickstart
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })

--lsp jumps
vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions,{desc =  '[G]oto [D]efinition'})
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {desc = '[G]oto [R]eferences'})
vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, {desc = '[G]oto [I]mplementation'})
vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, {desc = 'Type [D]efinition'})
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, {desc = '[D]ocument [S]ymbols'})
vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, {desc = '[W]orkspace [S]ymbols'})

-- See `:help K` for why this keymap
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc='Hover Documentation'})
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {desc='Signature Documentation'})

-- Lesser used LSP functionality
vim.keymap.set('n','gD', vim.lsp.buf.declaration, {desc='[G]oto [D]eclaration'})
vim.keymap.set('n','<leader>wa', vim.lsp.buf.add_workspace_folder, {desc='[W]orkspace [A]dd Folder'})
vim.keymap.set('n','<leader>wr', vim.lsp.buf.remove_workspace_folder, {desc='[W]orkspace [R]emove Folder'})


--harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>pe",function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, {desc='LSP: [Code] Action'})
vim.keymap.set({'n'},'<leader>cr', vim.lsp.buf.rename, {desc='LSP: [C]ode [R]ename'})
vim.keymap.set({'n'},'<leader>rn', vim.lsp.buf.rename, {desc='LSP: [R]e[n]ame'})

