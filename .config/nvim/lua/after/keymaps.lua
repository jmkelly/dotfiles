--telescope ones from kickstart
--
--
--some helper functions
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local dap = require('dap')
local harpoon = require("harpoon")
local telescope = require("telescope.builtin")
local dotnet = require("config.dotnet")


map('n', '<leader><space>', telescope.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>gf', telescope.git_files, { desc = 'Search [G]it [F]iles' })
map('n', '<leader>ff', telescope.find_files, { desc = '[F]ind [F]iles' })
map('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>fg', telescope.live_grep, { desc = '[F]ind by [G]rep' })

--lsp jumps
map('n', 'gd', telescope.lsp_definitions,{desc =  '[G]oto [D]efinition'})
map('n', 'gr', telescope.lsp_references, {desc = '[G]oto [R]eferences'})
map('n', 'gI', telescope.lsp_implementations, {desc = '[G]oto [I]mplementation'})
map('n', '<leader>D', telescope.lsp_type_definitions, {desc = 'Type [D]efinition'})
map('n', '<leader>ds', telescope.lsp_document_symbols, {desc = '[D]ocument [S]ymbols'})
map('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols, {desc = '[W]orkspace [S]ymbols'})

-- See `:help K` for why this keymap
map('n', 'K', vim.lsp.buf.hover, {desc='Hover Documentation'})
map('n', '<C-k>', vim.lsp.buf.signature_help, {desc='Signature Documentation'})

-- Lesser used LSP functionality
map('n','gD', vim.lsp.buf.declaration, {desc='[G]oto [D]eclaration'})
map('n','<leader>wa', vim.lsp.buf.add_workspace_folder, {desc='[W]orkspace [A]dd Folder'})
map('n','<leader>wr', vim.lsp.buf.remove_workspace_folder, {desc='[W]orkspace [R]emove Folder'})

--leaving the <leader>nt because this is what I'm used to from nerdtree....but over time if I can get used to <leader>oi, i'll remove it
map('n', "<leader>nt", require('oil').open_float, { desc = 'Open Oil', silent = true })
map('n', "<leader>oi", require('oil').open_float, { desc = 'Open Oil', silent = true })

--harpoon
map("n", "<leader>a", function() harpoon:list():add() end)
map("n", "<leader>pe",function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<leader>1", function() harpoon:list():select(1) end)
map("n", "<leader>2", function() harpoon:list():select(2) end)
map("n", "<leader>3", function() harpoon:list():select(3) end)
map("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function() harpoon:list():prev() end)
map("n", "<C-S-N>", function() harpoon:list():next() end)

map({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, {desc='LSP: [Code] Action'})
map({'n'},'<leader>cr', vim.lsp.buf.rename, {desc='LSP: [C]ode [R]ename'})
map({'n'},'<leader>rn', vim.lsp.buf.rename, {desc='LSP: [R]e[n]ame'})

map({'n'},'<leader>du', vim.lsp.buf.rename, {desc='LSP: [R]e[n]ame'})


--debugger
map('n', "<leader>du", function() require("dapui").toggle({ }) end, {desc = "Dap UI" })
map('n', "<leader>de", function() require("dapui").eval() end, {desc = "Eval"})
map('n', '<F5>', function() dap.continue() end, { desc="Debug Continue [F5]"})
map('n', '<F10>', function() dap.step_over() end, { desc="Debug Step Over [F10]" })
map('n', '<F11>', function() dap.step_into() end, { desc="Debug Step Into [F11]" })
map('n', '<F12>', function() dap.step_out() end, { desc="Debug Step Out [F12]" })
map('n', '<F9>', function() dap.toggle_breakpoint() end, { desc="Debug Toggle Breakpoint [F9]" })
map('n', '<Leader>B', function() dap.set_breakpoint() end)
map('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
map('n', '<Leader>dr', function() dap.repl.open() end)
map('n', '<Leader>dl', function() dap.run_last() end)
map({'n', 'v'}, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end)
map({'n', 'v'}, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end)
map('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
map('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)

--map("n", "<leader>dt", function () require('neotest').run.run() end, { noremap = true, silent = true, desc = '[d]otnet [t]est nearest' })
map("n", "<leader>ddt", function () require('neotest').run.run({strategy = "dap"}) end, { noremap = true, silent = true, desc = '[d]otnet [d]ebug [t]est nearest' })
map("n", "<leader>tw", function () require('neotest').summary.toggle() end, { noremap = true, silent = true, desc = 'toggle [t]est [w]indow' })

map('n', '<leader>db', dotnet.build_no_restore, { desc = '[D]otnet [B]uild' , silent = true })
map('n', '<leader>dt', dotnet.test_nearest, { desc = '[D]otnet [T]est nearest' , silent = true })
