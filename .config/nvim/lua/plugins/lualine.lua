return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff' },
			lualine_c = { 'filename', 'diagnostics' },
			lualine_y = { 'lsp_status' },
			lualine_z = { 'location' },
		},
	},
}
