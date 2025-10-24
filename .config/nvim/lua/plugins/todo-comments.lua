return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
	},
	opts = {
		keywords = {
			FIX = { icon = "󱚡 ", color = "#CD5656", alt = { "ERROR", "BUG", "ISSUE" } },
			TODO = { icon = " ", color = "#9EC6F3" },
			WARN = { icon = " ", color = "#FBF3B9", alt = { "WARNING" } },
			PERF = { icon = "󰾆 ", color = "#98A1BC", alt = { "OPTIMIZE", "PERFORMANCE" } },
			NOTE = { icon = "󰍩 ", color = "#A594F9" },
			TEST = { icon = "󰙨", color = "#819A91" },
		},
	},
}
