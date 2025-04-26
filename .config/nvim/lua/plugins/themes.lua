return {
	{
		"rmehri01/onenord.nvim",
		lazy = false, -- load on startup
		priority = 1000, -- make sure it loads before other plugins
		config = function()
			local background = "dark"
			require("onenord").setup({
				theme = background, -- set dark mode
			})
			vim.o.background = background
			vim.cmd.colorscheme("onenord")
		end
	},
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			--vim.cmd.colorscheme("onedark")
		end
	}

}
