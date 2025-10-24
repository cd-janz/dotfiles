return {
	"xzbdmw/colorful-menu.nvim",
	config = function()
		local colorful = require("colorful-menu")
		colorful.setup({
			ls = {
				lua_ls = {
					arguments_hl = "@comment",
				},
			},
			fallback_highlight = "@variable",
			max_width = 80,
		})
	end,
}
