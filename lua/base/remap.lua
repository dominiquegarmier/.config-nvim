vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'jj', '<Esc>')

-- file tree
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- quickfix
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')
vim.keymap.set('n', '<leader>qo', '<cmd>copen<CR>')
vim.keymap.set('n', '<leader>qc', '<cmd>cclose<CR>')

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
