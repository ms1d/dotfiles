-- Neovim Configuration
vim.loader.enable()

-- Structure:
-- lua/
--   config/
--     options.lua    -> Basic vim options
--     keymaps.lua    -> Global keymaps
--     autocmds.lua   -> Autocommands
--   plugins/
--     lsp.lua        -> LSP, Mason, formatting
--     completion.lua -> CMP, snippets, autopairs
--     ui.lua         -> Colorscheme, neo-tree, ufo
--     treesitter.lua -> Treesitter
--     editor.lua     -> Telescope, other tools

-- 1. Load Core Config
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- 2. Bootstrap Plugin Manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 3. Load Plugins
require("lazy").setup({
    spec = {
        -- Import plugin specs from lua/plugins/*.lua
        { import = "plugins.lsp" },
        { import = "plugins.completion" },
        { import = "plugins.ui" },
        { import = "plugins.treesitter" },
        { import = "plugins.git" },
        { import = "plugins.activitywatch" },
    },
    -- Configure lazy.nvim UI
    ui = {
        border = "rounded",
    },
    checker = {
        enabled = true, -- Check for updates automatically
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})
