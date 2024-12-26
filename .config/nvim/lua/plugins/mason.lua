return {
	{"williamboman/mason.nvim", opts = {
		registries = {
			'github:mason-org/mason-registry',
			'github:Crashdummyy/mason-registry'
		}
	}},
	{"williamboman/mason-lspconfig.nvim", opts = {}},
	{"neovim/nvim-lspconfig" } --no setup function on lsp-config
}
