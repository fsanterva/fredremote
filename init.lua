-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(
	function(use)
  		use 'preservim/nerdtree'
		use 'wbthomason/packer.nvim'
		use { 'neovim/nvim-lspconfig', requires = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'j-hui/fidget.nvim', 'folke/neodev.nvim', }, }
		use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' }, }
		use { 'nvim-treesitter/nvim-treesitter', run = function() pcall(require('nvim-treesitter.install').update { with_sync = true }) end, }
		use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter', }
		use 'sainnhe/everforest'
		-- use 'navarasu/onedark.nvim'
		use 'ap/vim-css-color'
		use 'Yggdroot/indentLine'
		use {'neoclide/coc.nvim', branch = 'release'}
		use 'alvan/vim-closetag'
		use 'nvim-lualine/lualine.nvim'
		use 'numToStr/Comment.nvim'
		use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
		use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

		-- Git related plugins
		use 'tpope/vim-fugitive'
		use 'tpope/vim-rhubarb'
		use 'lewis6991/gitsigns.nvim'

		-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
		local has_plugins, plugins = pcall(require, 'custom.plugins')
		if has_plugins then
			plugins(use)
		end

		if is_bootstrap then
			require('packer').sync()
		end
	end
)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true 

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true

-- vim.cmd [[colorscheme onedark]]
vim.cmd [[colorscheme everforest]]

vim.cmd("augroup ProjectDrawer")

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- lualine 
require('lualine').setup {
  options = {
    icons_enabled = false,
    -- theme = 'onedark',
    theme = 'everforest',
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable Comment.nvim
require('Comment').setup()


-- -- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup { signs = { add = { text = '+' }, change = { text = '~' }, delete = { text = '_' }, topdelete = { text = '‾' }, changedelete = { text = '~' }, }, }

-- [[ Configure Telescope ]]
require('telescope').setup { defaults = { mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false, }, }, }, }

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>op', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },
  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}


-- LSP settings.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = true },
      telemetry = { enable = true },
    },
  },
}

require('neodev').setup()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
require('mason').setup()
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
require('fidget').setup()
local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {

    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et







vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.api.nvim_command("set splitright")
vim.api.nvim_set_option("wrap", false)

vim.api.nvim_set_keymap("n", "<leader>cgn", "cgn", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>k", "zM", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>kk", "zR", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>zz", "zd", {noremap = true})
vim.api.nvim_set_keymap("n", "<Space>", "za", {noremap = true})
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

vim.api.nvim_set_keymap("n", "<leader>pth", ":echo expand('%')<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>yth', [[:let @+ = expand('%') | call system('echo "' . @+ . '" | xclip -i -selection clipboard')<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cvv", "<C-v>", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Tab>", ":tabn<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<S-Tab>", ":tabp<CR>", {noremap=true})

vim.api.nvim_set_keymap("n", "<C-y>", ":vertical resize +20<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-t>", ":vertical resize -20<CR>", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>rep", ":%s /xxxxxx/xxxxxx/g", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>ff", ":vimgrep /xxxxxxxx/gj **/*", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>nf", ":cfdo %s/xxxxx/xxxxx/g", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>nfu", ":cfdo update", {noremap=true})

vim.cmd("augroup ProjectDrawer")
-- vim.cmd("autocmd VimEnter * :cd /mnt/c/wamp64/www/devs/wp/")
-- vim.cmd("autocmd VimEnter * :Vexplore")
-- vim.cmd("autocmd VimEnter * :Lex")
vim.cmd("augroup END")

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

-- ============== Settings ==============

vim.g.netrw_banner = 1
vim.g.netrw_altv = 1 
vim.g.netrw_liststyle = 0 
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 30 
vim.g.netrw_sort_by = "exten"

-- netrw_browse_split:-
-- 0: Open files in the current window.
-- 1: Open files in a new horizontal split window at the top.
-- 2: Open files in a new vertical split window on the left.
-- 3: Open files in a new tab page.
-- 4: Open files in a new horizontal split window at the top (same as 1).

vim.api.nvim_command("set clipboard=unnamed")
vim.api.nvim_set_keymap("n", "<leader>v", ":r !xsel -ob<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>c", ":%w !xclip -selection clipboard<CR>", {noremap = true})

vim.api.nvim_command([[autocmd BufNewFile,BufRead *.md execute "rightbelow vnew" | execute "e"]])

vim.api.nvim_command("set foldenable")
vim.api.nvim_command([[autocmd BufWinLeave * silent! mkview]])
vim.api.nvim_command([[autocmd BufWinEnter * silent! loadview]])
vim.api.nvim_command([[autocmd BufEnter * silent! set foldmethod=manual]])

-- /* CloseTag 
-- ----------- */

vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml'
vim.g.closetag_xhtml_filenames = '*.xhtml,*.jsx'
vim.g.closetag_filetypes = 'html,xhtml,phtml'
vim.g.closetag_xhtml_filetypes = 'xhtml,jsx'
vim.g.closetag_shortcut = '>'
vim.g.closetag_close_shortcut = '<leader>>'
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_regions = {
    ['typescript.tsx'] = 'jsxRegion,tsxRegion',
    ['javascript.jsx'] = 'jsxRegion',
    ['typescriptreact'] = 'jsxRegion,tsxRegion',
    ['javascriptreact'] = 'jsxRegion',
}

-- /* COC 
-- ------ */

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
local keyset = vim.keymap.set
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
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
local opts = {silent = true, nowait = true}
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)
local opts = {silent = true, nowait = true, expr = true}
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
vim.g.nvim_tree_ignore = { "node_modules" }
vim.g.netrw_list_hide = "node_modules"

-- /* Automatically open NERDTree when starting Neovim 
-- --------------------------------------------------- */ 

vim.cmd 'autocmd StdinReadPre * let s:std_in=1'
vim.cmd 'autocmd VimEnter * NERDTree'
vim.cmd 'autocmd BufWinEnter * NERDTreeMirror'
vim.cmd 'autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'
vim.api.nvim_set_keymap('n', '<F2>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.opt.autochdir = true -- Set autochdir
vim.cmd('autocmd BufEnter * silent! lcd %:p:h') -- Define autocmd for changing directory to the file's directory on BufEnter

-- Set 'jjj' to enter terminal mode

-- See `:help vim.keymap.set()`
