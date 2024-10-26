   return {
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup {
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'c_sharp', 'html', 'css' },

			-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		}
	end
}
