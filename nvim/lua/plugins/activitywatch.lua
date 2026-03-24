return {
    {
        "ActivityWatch/aw-watcher-vim",
        event = "VimEnter",
        config = function()
            local group = vim.api.nvim_create_augroup("ActivityWatch", { clear = true })

            local function safe_cmd(cmd)
                pcall(vim.cmd, cmd)
            end

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
                group = group,
                callback = function()
                    safe_cmd("AWHeartbeat")
                end,
            })

            vim.api.nvim_create_autocmd("VimEnter", {
                group = group,
                callback = function()
                    safe_cmd("AWStart")
                end,
            })

            vim.api.nvim_create_autocmd("VimLeavePre", {
                group = group,
                callback = function()
                    safe_cmd("AWStop")
                end,
            })
        end,
    },
}
