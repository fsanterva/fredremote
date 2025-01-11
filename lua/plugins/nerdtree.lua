--  NERDTree
vim.cmd 'autocmd StdinReadPre * let s:std_in=1'
vim.cmd 'autocmd VimEnter * NERDTree'
vim.cmd 'autocmd BufWinEnter * NERDTreeMirror'
vim.cmd 'autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'
vim.api.nvim_set_keymap('n', '<F2>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
