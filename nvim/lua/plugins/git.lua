return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add          = { text = "┃" },
                change       = { text = "┃" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
            signcolumn = true,  -- Show signs in the gutter
            numhl      = true, -- Don't highlight line numbers
            linehl     = false, -- Don't highlight entire lines
            word_diff  = false, -- Don't highlight word-level changes
            watch_gitdir = {
                follow_files = true
            },
            auto_attach = true,
            attach_to_untracked = false,
            current_line_blame = false, -- Keep inline blame off by default
            sign_priority = 6,
            update_debounce = 100,
            max_file_length = 40000,
            preview_config = {
                border = "rounded",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1
            },
        }
    }
}
