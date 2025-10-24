return {
  "lewis6991/hover.nvim",
  config = function()
    local hover = require("hover")
    hover.setup({
      init = function()
        require("hover.providers.lsp")
      end,
      preview_opts = {
        border = "single",
      },
      title = true,
      mouse_providers = {
        "LSP",
      },
      mouse_delay = 2000,
    })
  end,
}
