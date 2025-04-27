return {
	{
		"williamboman/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" }, --i would like to have rosyln here, but its not an "offical" mason lsp package so it won't automatically install
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {},
		config = function()
			require("lspconfig").lua_ls.setup({
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
		end,
	}, --no setup function on lsp-config
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
		config = function()
			require("lspconfig").lua_ls.setup({})
			require("mason-nvim-dap").setup({
				ensure_installed = { "netcoredbg" }, -- Add DAPs you want
				automatic_installation = true, -- optional: installs when dap config is added
			})
		end,
	},
}
