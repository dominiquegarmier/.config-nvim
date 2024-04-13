vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'jj', '<Esc>')

-- file tree
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- format
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format() end)

-- latex compile
local verbose = false
vim.keymap.set('n', '<leader>ll', function()
  if vim.bo.filetype ~= 'tex' then
    return
  end

  -- save file
  vim.cmd('w')

  if verbose then
    vim.cmd('!pdflatex main.tex')
  else
    vim.cmd('silent !pdflatex main.tex &>/dev/null &')
  end
end, { desc = 'saves and compiles latex' })
