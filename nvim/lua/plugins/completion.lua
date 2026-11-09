return {
    {
        "L3MON4D3/LuaSnip", -- snippet engine
		event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
			"windwp/nvim-autopairs",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("nvim-autopairs").setup()

			require("blink.cmp").setup({
				keymap = {
					preset = "default",

					["<C-Space>"] = { "show", "fallback" },

					["<CR>"] = { "select_and_accept", "fallback" },

					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },

					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },

					-- Normal sources + Minuet, manually triggered
					["<A-y>"] = {
						function(cmp)
							cmp.show({
								providers = {
									"minuet",
									"lsp",
									"snippets",
									"buffer",
									"path",
								},
							})
						end,
					},
				},

				snippets = {
					preset = "luasnip",
				},

				sources = {
					default = {
						"lsp",
						"snippets",
						"buffer",
						"path",
					},

					providers = {
						minuet = {
							name = "Minuet",
							module = "minuet.blink",
							async = true,
							timeout_ms = 3000,
							score_offset = 50,
						},
					},
				},

				completion = {
					trigger = {
						prefetch_on_insert = false,
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500,
					},
				},
			})
		end,
	},
	{
		"milanglacier/minuet-ai.nvim", --llama-cpp models
		event = "InsertEnter",
		config = function()
			require("minuet").setup({
				notify = false, -- suppresses ALL errors when model isn't running

				cmp = {
					enable_autocomplete = false,
				},

				provider = "openai_fim_compatible",
				n_completions = 2,
				context_window = 1024,

				provider_options = {
					openai_fim_compatible = {
						name = "Llama.cpp",
						end_point = "http://localhost:8888/v1/completions",
						api_key = "TERM",
						model = "PLACEHOLDER",

						stream = true,

						optional = {
							max_tokens = 120,
							top_p = 0.9
						},

						template = {
							prompt = function(before, after, _)
								return "<|fim_prefix|>"
                                .. before
                                .. "<|fim_suffix|>"
                                .. after
                                .. "<|fim_middle|>"
							end,
							suffix = false
						}
					}
				}
			})
		end
	}
}
