return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	conf = function()
		local treesitter = require("nvim-treesitter")
		treesitter.install({
			"lua",
			"ini",
		})
	end,
}
