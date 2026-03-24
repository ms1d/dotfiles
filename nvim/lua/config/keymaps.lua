-- Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Clear search highlights with <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Diagnostic URL helper
map("n", "go", function()
    local diag = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })[1]
    if diag and diag.user_data and diag.user_data.lsp and diag.user_data.lsp.codeDescription then
        vim.fn.jobstart({ "xdg-open", diag.user_data.lsp.codeDescription.href })
    else
        print("No diagnostic URL available")
    end
end, { desc = "Open diagnostic URL" })

-- Folding (UFO helper) - Using pcall to avoid errors if ufo is not loaded
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
map("n", "zp", function()
    local ok, ufo = pcall(require, "ufo")
    if ok then
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    else
        vim.lsp.buf.hover()
    end
end, { desc = "Preview fold or hover" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize window
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })
