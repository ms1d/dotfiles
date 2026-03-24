-- Basic Settings
local opt = vim.opt

-- Indentation
opt.expandtab = false      -- Use tabs instead of spaces
opt.tabstop = 4            -- Number of spaces that a <Tab> in the file counts for
opt.shiftwidth = 4         -- Size of an indent
opt.softtabstop = 4        -- Number of spaces that a <Tab> counts for while performing editing operations

-- UI
opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Show relative line numbers
opt.fillchars = {
    eob = " ",
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
	vert = "│",
}

opt.shortmess:append("I")  -- Disable the intro message (splash screen)
opt.laststatus = 3         -- Global statusline at the bottom
opt.cmdheight = 0          -- Hide the command line when not in use
opt.showcmdloc = "statusline" -- Show command-line input in the statusline
opt.showtabline = 2      -- Show the tabline as well as the winbar

-- Disable netrw (default file explorer) to prevent "flashing" it on startup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Folding (Using UFO)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false     -- Disable folding at startup
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Search
opt.ignorecase = true      -- Ignore case in search patterns
opt.smartcase = true       -- Override ignorecase if search pattern contains uppercase characters

-- Others
opt.scrolloff = 8          -- Minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8      -- Minimal number of screen columns to keep to the left and right of the cursor
