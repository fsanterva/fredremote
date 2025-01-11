-- Basic Settings
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set

-- Keymaps
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', {silent = true, noremap = true, expr = true})
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], {silent = true, noremap = true, expr = true})
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], {silent = true, noremap = true, expr = true})
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Auto commands
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- User Commands
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Statusline and mappings
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", {silent = true})
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", {silent = true})
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", {silent = true})
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", {silent = true})
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", {silent = true})
keyset("n", "<space>j", ":<C-u>CocNext<cr>", {silent = true})
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", {silent = true})
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", {silent = true})
