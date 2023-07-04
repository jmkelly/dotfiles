---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<C-d>"] = { "<C-d>zz", "move down half a page and recentre to middle of window" },
		["<C-u>"] = { "<C-u>zz", "move up half a page and recentre to middle of window" },
		["<leader>rn"] = { vim.lsp.buf.rename, "[Re[n]ame" },
		["gd"] = { vim.lsp.buf.definition, "[G]oto [D]efinition" },
	},
	i = {
		--insert escape remapping
		["jk"] = { "<Esc>", "escape insert mode", opts = { nowait = true } },
		["kj"] = { "<Esc>", "escape insert mode", opts = { nowait = true } },
		["<Tab>"] = {
			function()
				return vim.fn["codeium#Accept"]()
			end,
			opts = { expr = true },
		},
		["<C-]>"] = {
			function()
				return vim.fn["codeium#CycleCompletions"](1)
			end,
			opts = { expr = true },
		},
		["<C-[>"] = {
			function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end,
			opts = { expr = true },
		},
		["<C-x>"] = {
			function()
				return vim.fn["codeium#Clear"]()
			end,
			opts = { expr = true },
		},
	},
	t = {
		--exit terminal emulator with some sensible keys
		["kj"] = { "<C-\\><C-n>", "escape terminal mode" },
		["<Esc>"] = { "<C-\\><C-n>", "escape terminal mode" },
	},
	v = {
		-- great for moving whole lines in visual mode
		["J"] = { ":m '>+1<CR>gv=gv", "move line up in visual mode" },
		["K"] = { ":m '<-2<CR>gv=gv", "move line down in visual mode" },
	},
}

return M
