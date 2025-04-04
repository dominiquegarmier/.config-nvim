local copilot = require("copilot")
local suggestion = require("copilot.suggestion")

copilot.setup({
	suggestion = {
		auto_trigger = true,
	},
	filetypes = {
		markdown = true,
	},
	auto_start = true,
})

local accept = function()
	if suggestion.is_visible() then
		suggestion.accept()
	else
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-l>", true, true, true), "n")
	end
end

vim.keymap.set("i", "<C-l>", function()
	accept()
end, { noremap = true, silent = true })
