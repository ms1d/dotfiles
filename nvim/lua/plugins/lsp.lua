return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" },
        event = "VeryLazy",
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls", "vtsls", "tailwindcss", "pylsp", "marksman" },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "seblyng/roslyn.nvim",
            "SmiteshP/nvim-navic",
        },
        config = function()
            -- LSP keymaps using the modern LspAttach autocommand (Neovim 0.11+)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local opts = { buffer = bufnr }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "act", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("v", "r", vim.lsp.buf.rename, opts)

                    -- Attach nvim-navic for breadcrumbs
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.server_capabilities.documentSymbolProvider then
                        require("nvim-navic").attach(client, bufnr)
                    end
                end,
            })


            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Set global LSP defaults
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- Configure specific servers using the new vim.lsp.config API

            vim.lsp.config("clangd", {
                cmd = { "clangd", "--background-index", "--clang-tidy" },
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                            enable = true,
                        },
                    },
                },
            })

            vim.lsp.config("vtsls", {
                settings = {
                    vtsls = {
                        tsserver = {
                            useSyntaxServer = "never",
                        },
                    },
                },
            })

            vim.lsp.config("tailwindcss", {
                filetypes = {
                    "html", "css",
                    "javascript", "typescript",
                    "javascriptreact", "typescriptreact",
                },
            })

            vim.lsp.config("pylsp", {
                settings = {
                    pylsp = {
                        plugins = {
                            ruff = { enabled = true },
                            black = { enabled = true },
                            isort = { enabled = true },
                            rope_autoimport = { enabled = true },
                            mypy = { enabled = false },
                        },
                    },
                },
            })

            -- Enable the servers (Neovim will automatically use configurations from nvim-lspconfig)
            vim.lsp.enable({ "clangd", "lua_ls", "vtsls", "tailwindcss", "pylsp", "marksman" })

            -- Roslyn setup (keep using the plugin's own setup as it bridges to lspconfig/vim.lsp)
            require("roslyn").setup({
                lsp = {
                    capabilities = capabilities,
                }
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.markdownlint.with({
						extra_args = { "--config", ".markdownlint.json" },
					}),
                },
            })
        end,
    },
}
