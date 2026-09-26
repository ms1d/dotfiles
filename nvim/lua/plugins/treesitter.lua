return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleStat", "TSUpdate", "TSUpdateSync" },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.config").setup({
                ensure_installed = {
                    "tsx", "typescript", "javascript", "html",
                    "lua", "c", "cpp", "python", "c_sharp", "markdown", "markdown_inline"
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-ts-autotag").setup({})
        end,
    },
}
