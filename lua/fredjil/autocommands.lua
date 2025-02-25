
vim.api.nvim_command("set splitright")

vim.api.nvim_command("set clipboard=unnamed")
vim.api.nvim_command([[autocmd BufNewFile,BufRead *.md execute "rightbelow vnew" | execute "e"]])

vim.api.nvim_command("set foldenable")

vim.api.nvim_command([[autocmd BufWinLeave * silent! mkview]])
vim.api.nvim_command([[autocmd BufWinEnter * silent! loadview]])
vim.api.nvim_command([[autocmd BufEnter * silent! set foldmethod=manual]])

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }) -- Highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true }) -- Re-compile packer whenever you save this init.lua
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
}) 

vim.cmd('autocmd BufEnter * silent! lcd %:p:h') -- Define autocmd for changing directory to the file's directory on BufEnter

vim.cmd[[
  command! -nargs=* -complete=customlist,Fredcompletion Fred execute <q-args>
  function! Fredcompletion(ArgLead, CmdLine, CursorPos)
    return [':fred ', ':fredzzzz ', ':!ls', ':r!ls', ':vimgrep /xxxxxx/g **/*', ':find . -type -name "*.php"', ':find . -type -name "*.js"']
  endfunction
]]

vim.cmd[[cnoreabbrev <expr> fred getcmdtype() == ':' && getcmdline() == 'fred' ? 'Fred ' : 'fred']]
