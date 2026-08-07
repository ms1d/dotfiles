-- Autocommands
local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Diagnostic window highlights
api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.api.nvim_win_set_option(0, "winhighlight", table.concat({
            "Normal:DiagnosticNormal",
            "NormalNC:DiagnosticNormal",
            "CursorLine:DiagnosticCursorLine",
            "WinSeparator:Invisible",
            "StatusLine:Invisible",
            "StatusLineNC:Invisible",
        }, ","))
    end,
})

-- Update diagnostics in insert mode
vim.diagnostic.config({
	virtual_lines = true,
    update_in_insert = true,
    float = {
        border = "rounded",
        source = "always",
    },
})

-- Globally set border for LSP floats
local _orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return _orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Automatically update quickfix list with diagnostics (if it's already open)
api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        local qf_exists = false
        for _, win in ipairs(api.nvim_list_wins()) do
            if api.nvim_buf_get_option(api.nvim_win_get_buf(win), "filetype") == "qf" then
                qf_exists = true
                break
            end
        end
        if qf_exists then
            vim.diagnostic.setqflist({ open = false })
        end
    end,
})

-- Auto-open folds (UFO)
api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local ok, ufo = pcall(require, "ufo")
        if ok then
            ufo.openFoldsExceptKinds({})
        end
    end,
})

