vim.o.hlsearch = true        -- Highlight search matches
vim.wo.number = true         -- Show line numbers
vim.o.mouse = 'a'            -- Enable mouse support
vim.o.breakindent = true     -- Enable break indent
vim.o.undofile = true        -- Save undo history
vim.o.ignorecase = true      -- Ignore case in search patterns
vim.o.smartcase = true       -- Override 'ignorecase' if search contains uppercase letters
vim.o.tabstop = 4            -- Number of spaces that a <Tab> counts for
vim.o.shiftwidth = 4         -- Number of spaces for each step of (auto)indent
vim.o.updatetime = 250       -- Faster completion (default is 4000ms)
vim.o.termguicolors = true   -- Enable true color support
vim.o.completeopt = 'menuone,noselect' -- Completion options for a better experience


vim.g.netrw_banner = 1
vim.g.netrw_altv = 2 
vim.g.netrw_liststyle = 0 
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 30 
vim.g.netrw_sort_by = "exten"

vim.opt.autochdir = true -- Set autochdir 

vim.api.nvim_set_option("wrap", false)
