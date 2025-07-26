-- lua/plugins/neoscroll.lua

return {
  "karb94/neoscroll.nvim",
  event = "WinScrolled",
  config = function()
    local neoscroll = require("neoscroll")

    neoscroll.setup({
      easing_function = "sine",
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
    })

    local map = vim.keymap.set
    local scroll = require("neoscroll").scroll

    -- Custom smooth scroll mappings
    map("n", "<C-u>", function() scroll(-vim.wo.scroll, true, 150) end, {})
    map("n", "<C-d>", function() scroll(vim.wo.scroll, true, 150) end, {})
    map("n", "<C-b>", function() scroll(-vim.api.nvim_win_get_height(0), true, 250) end, {})
    map("n", "<C-f>", function() scroll(vim.api.nvim_win_get_height(0), true, 250) end, {})
    map("n", "<C-y>", function() scroll(-0.10, false, 100) end, {})
    map("n", "<C-e>", function() scroll(0.10, false, 100) end, {})
    map("n", "zt", function() require("neoscroll").zt(150) end, {})
    map("n", "zz", function() require("neoscroll").zz(150) end, {})
    map("n", "zb", function() require("neoscroll").zb(150) end, {})
  end,
}
