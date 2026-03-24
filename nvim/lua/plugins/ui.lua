return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme tokyonight")

            -- Transparent Background Logic (ported from nobg.lua)
            local groups = {
                "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle",
                "SignColumn", "MsgArea", "MsgSeparator", "StatusLine", "StatusLineNC",
                "WinSeparator", "EndOfBuffer",
                "CursorLine", "CursorColumn", "ColorColumn", "Folded", "FoldColumn",
                "LineNr", "LineNrAbove", "LineNrBelow",
                "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
				"TabLine", "TabLineFill",
                "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeFloatNormal", "NeoTreeFloatBorder",
                "NeoTreeWinSeparator", "NeoTreeEndOfBuffer",
                "MasonNormal", "MasonHeader", "MasonHeaderSecondary", "MasonHighlightBlock", "MasonHighlightBlockBold",
                "LazyNormal", "LazyFloat", "LazyFloatBorder", "LazyBackdrop",
                "LspInfoBorder", "LspInfoTitle", "LspInlayHint",
                "TSNodeKey", "TSNodeUnmatched",
                "DiagnosticVirtualTextError", "DiagnosticVirtualTextWarn", "DiagnosticVirtualTextInfo", "DiagnosticVirtualTextHint",
				"DiagnosticNormal", "DiagnosticCursorLine"
            }

            for _, group in ipairs(groups) do
                vim.api.nvim_set_hl(0, group, { bg = "none" })
            end

            -- Additional Highlights
            vim.api.nvim_set_hl(0, "Comment", { fg = "#8088b8", italic = true })
            vim.api.nvim_set_hl(0, "Visual", { bg = "#2a2f3b" })
            vim.api.nvim_set_hl(0, "LineNr", { fg = "#9FD8C0" })
            vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7A849A" })
            vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#7A849A" })
            vim.api.nvim_set_hl(0, "Invisible", { bg = "none", fg = "none" })

            -- Pop-up Window Highlights
            vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#363d4a", bold = true }) -- Subtle selection background
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#444b6a" })           -- Reverted to subtle border color
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

            -- Window separators (Bright vertical lines, Invisible horizontal)
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#999fba", bg = "none" })
            vim.api.nvim_set_hl(0, "VertSplit", { fg = "#999fba", bg = "none" })
            vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#999fba", bg = "none" })

            vim.api.nvim_set_hl(0, "StatusLine", { fg = "none", bg = "none" })
            vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "none", bg = "none" })

			vim.api.nvim_set_hl(0, "TabLineSel", { bold = true })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = { enabled = true },
                    hijack_netrw_behavior = "open_default",
                    use_libuv_file_watcher = true,
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = true,
                        hide_gitignored = true,
                        hide_by_name = {
                            "node_modules",
                            "build",                 -- Hide build artifacts
                            "Testing",               -- Hide test results/folders
                            "compile_commands.json", -- Hide LSP database
                            "CMakeCache.txt",        -- Hide CMake temporary files
                        },
                        never_show = {
                            ".DS_Store",
                            "thumbs.db",
                        },
                    },
                },
            })
            vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Explorer" })
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        config = function()
            require("ufo").setup()
        end
    },
    { "nicolas-martin/region-folding.nvim" },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.set_query_linter_res"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                    },
                },
                presets = {
                    bottom_search = false,
                    command_palette = false,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = false,
                },
                status = {},
                cmdline = {
                    view = "cmdline_popup",
                },
                views = {
                    cmdline_popup = {
                        relative = "editor",
                        position = {
                            row = 0,
                            col = 0,
                        },
                        size = {
                            width = 0,
                            height = 0,
                        },
                        border = {
                            style = "none",
                        },
                        win_options = {
                            winblend = 100,
                        },
                    },
                    mini = {
                        win_options = {
                            winblend = 0,
                        },
                    },
                },
                messages = {
                    view = "mini",
                },
                routes = {
                    {
                        filter = {
                            find = "'height' key must be a positive Integer",
                        },
                        opts = { skip = true },
                    },
                },
            })

            -- Apply theme-consistent highlights for Noice messages
            vim.api.nvim_set_hl(0, "NoiceMini", { fg = "#F8F8FF", bg = "#0f0f0f" })
            vim.api.nvim_set_hl(0, "NoiceFormatProgressDone", { fg = "#9FD8C0" }) -- Cyan/Green for success
            vim.api.nvim_set_hl(0, "NoiceFormatProgressTodo", { fg = "#8088b8" })
        end
    },
    {
        "rebelot/heirline.nvim",
        event = "UiEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "SmiteshP/nvim-navic",
        },
        config = function()
            local conditions = require("heirline.conditions")
			local macro_state = {
				recording = false,  -- true while recording
				register = "",      -- current recording register
				keys = "",          -- keys typed so far
			}
            local utils = require("heirline.utils")
            local navic = require("nvim-navic")

			local key_icons = {
				["<Up>"]    = "↑",
				["<Down>"]  = "↓",
				["<Left>"]  = "←",
				["<Right>"] = "→",
				["<CR>"]    = "⏎",
				["<Esc>"]   = "⎋",
				["<BS>"]    = "⌫",
				["<Tab>"]   = "⇥",
				["<Space>"] = "␣",
				["<Enter>"] = "⏎",
				["<C-a>"]   = "⌃A",  -- example Ctrl keys
				["<C-c>"]   = "⌃C",
				["<C-v>"]   = "⌃V",
				-- add more where needed
			}

			-- Track when recording starts/stops
			vim.api.nvim_create_autocmd("RecordingEnter", {
				callback = function()
					macro_state.recording = true
					macro_state.register = vim.fn.reg_recording()
					macro_state.keys = ""
				end,
			})

			vim.api.nvim_create_autocmd("RecordingLeave", {
				callback = function()
					macro_state.recording = false
				end,
			})

			-- Capture keys as the user types
			vim.on_key(function(key)
				if not macro_state.recording then return end
				macro_state.keys = macro_state.keys .. vim.fn.keytrans(key)
			end, vim.api.nvim_create_namespace("macro_capture"))

            -- Initialize navic
            navic.setup({
                highlight = true
            })

            local function hex(v)
                if not v then return "none" end
                return type(v) == "number" and string.format("#%06x", v) or v
            end

            local colors = {
                bright_bg = hex(utils.get_highlight("Folded").bg),
                bright_fg = hex(utils.get_highlight("Folded").fg),
                red = hex(utils.get_highlight("DiagnosticError").fg),
                cmd_red = "#E06C75", -- Specific red for command mode
                dark_red = hex(utils.get_highlight("DiffDelete").fg),
                green = hex(utils.get_highlight("String").fg),
                blue = hex(utils.get_highlight("Function").fg),
                gray = hex(utils.get_highlight("NonText").fg),
                orange = hex(utils.get_highlight("DiagnosticWarn").fg),
                purple = hex(utils.get_highlight("Statement").fg),
                cyan = hex(utils.get_highlight("Special").fg),
                diag_warn = hex(utils.get_highlight("DiagnosticWarn").fg),
                diag_error = hex(utils.get_highlight("DiagnosticError").fg),
                diag_hint = hex(utils.get_highlight("DiagnosticHint").fg),
                diag_info = hex(utils.get_highlight("DiagnosticInfo").fg),
                git_del = hex(utils.get_highlight("diffDeleted").fg),
                git_add = hex(utils.get_highlight("diffAdded").fg),
                git_change = hex(utils.get_highlight("diffChanged").fg),
            }

            -- 1. MODE COMPONENT (with Arch Logo & Powerline)
            local ViMode = {
                static = {
                    mode_names = {
                        n = "N", no = "N?", nov = "N?", noV = "N?", ["no\22"] = "N?",
                        niI = "Ni", niR = "Nr", niV = "Nv", nt = "Nt", v = "V", vs = "Vs",
                        V = "V_", Vs = "Vs", ["\22"] = "^V", ["\22s"] = "^V", s = "S",
                        S = "S_", ["\19"] = "^S", i = "I", ic = "Ic", ix = "Ix",
                        R = "R", Rc = "Rc", Rx = "Rx", Rv = "Rv", Rvc = "Rvc", Rvx = "Rvx",
                        c = "C", cv = "Ex", ce = "Ex", r = "...", rm = "M", ["r?"] = "?",
                        ["!"] = "!", t = "T",
                    },
                    mode_colors = {
                        n = "blue", i = "green", v = "purple", V = "purple",
                        ["\22"] = "purple", c = "cmd_red", s = "purple", S = "purple",
                        ["\19"] = "purple", R = "orange", r = "orange", ["!"] = "red", t = "red",
                    }
                },
            }

            local function get_distro_icon()
                -- Use system call to safely read /etc/os-release
                local handle = io.popen("cat /etc/os-release 2>/dev/null")
                if not handle then return "  " end -- Fallback Linux icon
                local result = handle:read("*a")
                handle:close()

                if result:match('ID="arch"') or result:match('ID=arch') then
                    return "  "
                elseif result:match('ID="debian"') or result:match('ID=debian') then
                    return "  "
                end
                return "  "
            end

            local DistroLogo = {
                provider = get_distro_icon(),
                hl = function()
                    local mode = vim.fn.mode(1):sub(1, 1)
                    return { bg = ViMode.static.mode_colors[mode], fg = "bright_bg", bold = true }
                end,
            }

			local ModeName = {
				provider = function()
					local mode_full = vim.fn.mode(1)
					local mode = mode_full:sub(1,1)

					if mode == "c" then
						return "  "
					end

					local name = ViMode.static.mode_names[mode_full]
						or ViMode.static.mode_names[mode]
						or mode:upper()

					return " " .. name .. " "
				end,

				hl = function()
					local mode = vim.fn.mode(1):sub(1,1)
					return {
						bg = ViMode.static.mode_colors[mode],
						fg = "bright_bg",
						bold = true
					}
				end,

				update = {
					"ModeChanged",
					"CmdlineEnter",
					"CmdlineLeave",
				},
			}

            local ViModeSeparator = {
                provider = "",
                hl = function()
                    local mode = vim.fn.mode(1):sub(1, 1)
                    return { fg = ViMode.static.mode_colors[mode], bg = "none" }
                end,
            }

			local ShowCmd = {
				provider = function()
					local sc = vim.api.nvim_eval_statusline("%S", {}).str
					if sc == "" then
						return ""
					end
					return " " .. sc
				end,

				hl = { fg = "purple", bold = true },
			}

            -- 2. FILE INFO
            local FileNameBlock = {
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(0)
                end,
            }

            local FileIcon = {
                init = function(self)
                    local filename = self.filename
                    local extension = vim.fn.fnamemodify(filename, ":e")
                    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
                end,
                provider = function(self)
                    return self.icon and (self.icon .. " ")
                end,
                hl = function(self)
                    return { fg = self.icon_color }
                end
            }

            local FileName = {
                provider = function(self)
                    local filename = vim.fn.fnamemodify(self.filename, ":t")
                    if filename == "" then return "[No Name]" end
                    if not conditions.width_percent_below(#filename, 0.25) then
                        filename = vim.fn.pathshorten(filename)
                    end
                    return filename
                end,
                hl = { fg = "blue" },
            }

            local FileFlags = {
                {
                    condition = function() return vim.bo.modified end,
                    provider = " [+]",
                    hl = { fg = "green" },
                },
                {
                    condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
                    provider = " ",
                    hl = { fg = "orange" },
                },
            }

            FileNameBlock = utils.insert(FileNameBlock, { provider = "  " }, FileIcon, FileName, FileFlags, { provider = " " })

            -- 3. GIT STATUS
            local Git = {
                condition = conditions.is_git_repo,
                init = function(self)
                    self.status_dict = vim.b.gitsigns_status_dict
                    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
                end,
                hl = { fg = "orange" },
                { provider = "  " },
                {
                    provider = function(self) return self.status_dict.head end,
                    hl = { bold = true }
                },
                {
                    condition = function(self) return self.has_changes end,
                    provider = "("
                },
                {
                    provider = function(self)
                        local count = self.status_dict.added or 0
                        return count > 0 and ("+" .. count)
                    end,
                    hl = { fg = "git_add" },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.changed or 0
                        return count > 0 and ("~" .. count)
                    end,
                    hl = { fg = "git_change" },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.removed or 0
                        return count > 0 and ("-" .. count)
                    end,
                    hl = { fg = "git_del" },
                },
                {
                    condition = function(self) return self.has_changes end,
                    provider = ")"
                },
            }

            -- 3b. NOICE (Statusline integrated Command-line & Messages)
			local NoiceCommand = {
				condition = function()
					return vim.fn.mode():sub(1,1) == "c"
				end,

				provider = function()
					local cmd = vim.fn.getcmdline()
					if cmd == "" then
						return ""
					end

					cmd = cmd:gsub("%%", "%%%%")  -- escape %

					return " " .. cmd .. " "
				end,

				hl = { fg = "purple", bold = true },

				update = { "CmdlineChanged", "CmdlineEnter" },
			}

            -- 4. UTILS: SearchCount, Macro, WordCount
            local SearchCount = {
                condition = function() return vim.v.hlsearch ~= 0 and conditions.is_active() end,
                init = function(self)
                    local ok, search = pcall(vim.fn.searchcount)
                    if ok and search.total then self.search = search end
                end,
                provider = function(self)
                    if not self.search or self.search.total == 0 then return "" end
                    return string.format("  [%d/%d]", self.search.current, self.search.total)
                end,
                hl = { fg = "purple", bold = true },
            }

			local MacroRec = {
				condition = function()
					return macro_state.recording and conditions.is_active()
				end,

				provider = function()
					local reg = macro_state.register
					local keys = macro_state.keys

					-- replace keys with icons
					for k, v in pairs(key_icons) do
						keys = keys:gsub(vim.pesc(k), v)
					end

					-- optional: limit displayed length
					local MAX = 70
					if #keys > MAX then
						keys = "…" .. keys:sub(-MAX)
					end

					return string.format("  @%s [%s] ", reg, keys)
				end,
				hl = { fg = "red", bold = true },

				update = {
					"RecordingEnter",
					"RecordingLeave",
					"ModeChanged",
					"CursorMoved",
				},
			}

            local WordCount = {
                condition = function()
                    local ft = vim.bo.filetype
                    return ft == "markdown" or ft == "text"
                end,
                provider = function()
                    local words = vim.fn.wordcount().words
                    return " 󰈭 " .. words .. " words"
                end,
                hl = { fg = "gray" },
            }

            -- 5. LSP & DIAGNOSTICS
            local LSPActive = {
                condition = conditions.lsp_attached,
                update = { "LspAttach", "LspDetach" },
                provider = function()
                    local names = {}
                    -- Neovim 0.11+ uses get_clients
                    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                        table.insert(names, server.name)
                    end
                    return "  [" .. table.concat(names, " ") .. "]"
                end,
                hl = { fg = "green", bold = true },
            }

            local Diagnostics = {
                condition = conditions.has_diagnostics,
                static = {
                    error_icon = " ",
                    warn_icon = " ",
                    info_icon = " ",
                    hint_icon = "󰌵 ",
                },
                init = function(self)
                    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                end,
                update = { "DiagnosticChanged", "BufEnter" },
                {
                    provider = function(self) return self.errors > 0 and (self.error_icon .. self.errors .. " ") end,
                    hl = { fg = "diag_error" },
                },
                {
                    provider = function(self) return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ") end,
                    hl = { fg = "diag_warn" },
                },
                {
                    provider = function(self) return self.info > 0 and (self.info_icon .. self.info .. " ") end,
                    hl = { fg = "diag_info" },
                },
                {
                    provider = function(self) return self.hints > 0 and (self.hint_icon .. self.hints .. " ") end,
                    hl = { fg = "diag_hint" },
                },
            }

            -- 6. RULER
            local Ruler = {
                provider = " %7(%l/%L%):%2c %P ",
                hl = { fg = "gray" },
            }

			-- 7. SCROLL BAR
			local ScrollBar = {
				static = {
					sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
				},
				provider = function(self)
					local curr_line = vim.api.nvim_win_get_cursor(0)[1]
					local lines = vim.api.nvim_buf_line_count(0)
					local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
					return string.rep(self.sbar[i], 2)
				end,
				hl = { fg = "blue", bg = "bright_bg" },
			}

			local NeoTreeMode = {
				condition = function()
					return vim.bo.filetype == "neo-tree"
				end,

				provider = " 󰙅 Neo-tree ",

				hl = function()
					local mode = vim.fn.mode(1):sub(1,1)
					return {
						bg = ViMode.static.mode_colors[mode],
						fg = "bright_bg",
						bold = true
					}
				end,
			}

            -- ASSEMBLING THE STATUSLINE
            local StatusLine = {
                condition = function()
					if vim.bo.filetype == "neo-tree" then return true end

                    return not conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "quickfix", "terminal" },
                        filetype = { "qf", "help", "lazy", "mason", "notify" },
                    })
                end,
                {
                    fallthrough = false,
                    {
                        condition = function() return vim.fn.mode():sub(1, 1) == "c" end,
                        { DistroLogo, ModeName, ViModeSeparator, NoiceCommand, { provider = "%=" } },
                    },
					{
						condition = function() return vim.bo.filetype == "neo-tree" end,
						{ DistroLogo, NeoTreeMode, ViModeSeparator, { provider = " File Explorer " }, { provider = "%=" } },
					},
                    {
                        DistroLogo, ModeName, ViModeSeparator, ShowCmd, FileNameBlock, Git,
                        SearchCount,
                        { provider = "%=" },
                        MacroRec, WordCount, { provider = " " }, Diagnostics, LSPActive, Ruler, ScrollBar
                    }
                }
            }

            -- 8. TABLINE (Buffers at the top)

			local TablineFileNameBlock = {
				init = function(self)
					self.filename = vim.api.nvim_buf_get_name(self.bufnr)
				end,
			}

			local TablineFileIcon = {
				init = function(self)
					local filename = self.filename
					local extension = vim.fn.fnamemodify(filename, ":e")

					self.icon, self.icon_color =
						require("nvim-web-devicons").get_icon_color(
							filename,
							extension,
							{ default = true }
						)
				end,
				provider = function(self)
					return self.icon and (self.icon .. " ")
				end,
				hl = function(self)
					return { fg = self.icon_color }
				end
			}

			local TablineFileName = {
				provider = function(self)
					local filename = self.filename
					filename = filename == "" and "[No Name]"
						or vim.fn.fnamemodify(filename, ":t")

					return filename
				end,
			}

			local TablineFileFlags = {
				{
					condition = function(self)
						return vim.api.nvim_buf_get_option(self.bufnr, "modified")
					end,
					provider = " ●",
					hl = { fg = "green" },
				},
				{
					condition = function(self)
						return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
							or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
					end,
					provider = " ",
					hl = { fg = "orange" },
				},
			}

			TablineFileNameBlock = utils.insert(
				TablineFileNameBlock,
				TablineFileIcon,
				TablineFileName,
				TablineFileFlags
			)

			local TablineBufferBlock = {
				init = function(self)
					self.bufnr = self.bufnr
				end,

				condition = function(self)
					local bt = vim.bo[self.bufnr].buftype
					local ft = vim.bo[self.bufnr].filetype

					-- Only normal file buffers
					if bt ~= "" then
						return false
					end

					-- Explicit plugin exclusions
					local excluded = {
						["neo-tree"] = true,
						["help"] = true,
						["lazy"] = true,
						["mason"] = true,
						["qf"] = true,
						["notify"] = true,
					}

					return not excluded[ft]
				end,

				hl = function(self)
					if self.is_active then
						return { fg = "blue", bg = "bright_bg", bold = true }
					else
						return { fg = "gray", bg = "none" }
					end
				end,

				on_click = {
					callback = function(_, minwid)
						vim.api.nvim_win_set_buf(0, minwid)
					end,
					minwid = function(self)
						return self.bufnr
					end,
					name = "heirline_tabline_buffer_callback",
				},

				{
					provider = function(self)
						return " " .. self.bufnr .. ". "
					end,
					hl = "Comment",
				},

				TablineFileNameBlock,

				{ provider = " " },
			}

			local BufferLine = utils.make_buflist(
				TablineBufferBlock,
				{ provider = "  ", hl = { fg = "gray" } },
				{ provider = "  ", hl = { fg = "gray" } }
			)

            local Tabline = { BufferLine, { provider = "%=" } }

            -- 9. WINBAR (Breadcrumbs)
            local WinBar = {
                condition = function()
                    return not conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "quickfix", "terminal" },
                        filetype = { "neo-tree", "qf", "help", "lazy", "mason", "notify" },
                    })
                end,
                {
                    utils.insert(FileNameBlock, {
                        condition = function() return navic.is_available() end,
                        provider = function()
                            return " > " .. navic.get_location()
                        end,
                        hl = { fg = "gray", italic = true }
                    })
                }
            }

            require("heirline").setup({
                statusline = StatusLine,
                tabline = Tabline,
                winbar = WinBar,
                opts = {
                    colors = colors,
                    disable_winbar_cb = function(args)
                        return conditions.buffer_matches({
                            buftype = { "nofile", "prompt", "quickfix", "terminal" },
                            filetype = { "neo-tree", "qf", "help", "lazy", "mason", "notify" },
                        }, args.buf)
                    end,
                },
            })
        end
    },
}
