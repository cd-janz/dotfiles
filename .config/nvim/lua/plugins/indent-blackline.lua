return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {},
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#CD5656", bg = "#CD5656" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FFFED3", bg = "#FFFED3" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#295F98", bg = "#295F98" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#F39E60", bg = "#F39E60" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#BAD8B6", bg = "#BAD8B6" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#A594F9", bg = "#A594F9" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#7BD3EA", bg = "#7BD3EA" })
		end)
		local ibl = require("ibl")
		ibl.setup({
			indent = { highlight = highlight, char = " ", priority = 1 },
			scope = { enabled = true, highlight = highlight },
		})
	end,
}
