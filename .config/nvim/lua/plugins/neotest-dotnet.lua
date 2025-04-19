return {
	"nvim-neotest/neotest",
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-dotnet")({
					dap = {
						adapter_name = "coreclr",
					},
					dotnet_additional_args = {
						"--no-build",
						"--no-restore",
					},
					-- discovery_root = "solution"
				}),
			},
		})
	end,
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"Issafalcon/neotest-dotnet",
	},
}
