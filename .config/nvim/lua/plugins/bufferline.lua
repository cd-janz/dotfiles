return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "famiu/bufdelete.nvim"
  },
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "buffers",
        themable = false,
        numbers = "ordinal",
        close_command = nil,
        indicator = {
          style = "underline",
        },
        truncate_names = true,
        max_name_length = 16,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_update_on_event = true,
        diagnostics_indicator = function(count)
          return "(" .. count .. ")"
        end,
        offsets = {
          { filetype = "neo-tree", text = "File Explorer", text_align = "left", separator = false },
        },
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl =
              require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        auto_toggle_bufferline = true,
        hover = {
          enable = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    })
  end,
}
