local copilot = require("copilot")
local suggestion = require("copilot.suggestion")

copilot.setup({
  suggestion = {
    auto_trigger = true,
  },
  auto_start = true,
})

vim.keymap.set("i", "<C-l>", function() suggestion.accept_line() end)
vim.keymap.set("i", "<C-c>", function() suggestion.next() end)
