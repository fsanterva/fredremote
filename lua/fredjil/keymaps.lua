vim.g.mapleader = ','        -- Set leader key to ','
vim.g.maplocalleader = ','   -- Set local leader key to ','

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- Disable <Space> key
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- Navigate wrapped lines as single lines
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }) -- Navigate wrapped lines as single lines

vim.api.nvim_set_keymap("n", "<leader>cgn", "cgn", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>k", "zM", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>kk", "zR", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>zz", "zd", {noremap = true})
vim.api.nvim_set_keymap("v", "<2-RightMouse>", "zf", {noremap = true})

vim.api.nvim_set_keymap("n", "<2-LeftMouse>", "vit", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>cp", ":copen<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Backspace>", [[:e#<CR>]] ,{})
vim.api.nvim_set_keymap("n", "<leader>o", "<S-$>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>o", "<S-$>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>i", "0", {noremap = true})

vim.api.nvim_set_keymap("i", "jj", "<Esc><Esc>", {noremap=true})
vim.api.nvim_set_keymap('t', 'jj', [[<C-\><C-n>]], { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>ss", ":w<CR>", {noremap = true})
vim.api.nvim_set_keymap("i", "<leader>ss", ":w<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader><Space>", ":bd<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>vn", ":vnew<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>n", ":new<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>vv", "vit", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>llc", ":%bd | c#<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>end", ":qall!<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>vim", ":e ~/.config/nvim/init.lua<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>vit", "vit", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>ntree", ":NERDTreeToggle<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>pth", ":echo expand('%')<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>yth', [[:let @+ = expand('%') | call system('echo "' . @+ . '" | xclip -i -selection clipboard')<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cvv", "<C-v>", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Tab>", ":tabn<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<S-Tab>", ":tabp<CR>", {noremap=true})

vim.api.nvim_set_keymap("n", "<C-y>", ":vertical resize +20<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-t>", ":vertical resize -20<CR>", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>rep", ":%s /zz/zzzzzzz/g", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>ff", ":vimgrep /xxxxxxxx/gj **/*", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>nf", ":cfdo %s/xxxxx/xxxxx/g", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>nfu", ":cfdo update", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>w", ":lua Ww()<CR>", {noremap = true})
function Ww()
  if vim.fn.has('nvim') then
    vim.cmd("cd /mnt/c/wamp64/www/devs/dilate/wp")
    vim.cmd(":set modifiable")
    vim.cmd("e.")
  end
end

vim.api.nvim_set_keymap("n", "<leader>h", ":lua Wwh()<CR>", {noremap = true})
function Wwh()
  if vim.fn.has('nvim') then
    vim.cmd("cd /mnt/c/Windows/system32/drivers/etc/")
    vim.cmd("e .")
  end
end

vim.api.nvim_set_keymap("n", "<leader>vh", ":lua Wwvh()<CR>", {noremap = true})
function Wwvh()
  if vim.fn.has('nvim') then
    vim.cmd("cd /mnt/c/wamp64/bin/apache/apache2.4.58/conf/extra/")
    vim.cmd("e .")
  end
end 

vim.api.nvim_set_keymap("n", "<leader>v", ":r !xsel -ob<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>c", ":%w !xclip -selection clipboard<CR>", {noremap = true})
