local utils = require("base.utils")

return {
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open the file manager in nvim's working directory",
			},
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
		},
	},

	{
		"zeioth/project.nvim",
		event = "User BaseDefered",
		cmd = "ProjectRoot",
		opts = {
			-- How to find root directory
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
				".solution",
				".solution.toml",
			},
			-- Don't list the next projects
			exclude_dirs = {
				"~/",
			},
			silent_chdir = true,
			manual_mode = false,

			-- Don't chdir for certain buffers
			exclude_chdir = {
				filetype = { "", "OverseerList", "alpha" },
				buftype = { "nofile", "terminal" },
			},

			--ignore_lsp = { "lua_ls" },
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
	{
		"cappyzawa/trim.nvim",
		event = "BufWrite",
		opts = {
			trim_on_write = true,
			trim_trailing = true,
			trim_last_line = false,
			trim_first_line = false,
			-- ft_blocklist = { "markdown", "text", "org", "tex", "asciidoc", "rst" },
			-- patterns = {[[%s/\(\n\n\)\n\+/\1/]]}, -- Only one consecutive bl
		},
	},

	{
		enabled = false,
		"folke/flash.nvim",
		---@type Flash.Config
		opts = {
			search = {
				forward = true,
				multi_window = false,
				wrap = false,
				incremental = true,
			},
		},
	},

	{
		"max397574/better-escape.nvim",
		event = "InsertCharPre",
		opts = {
			mapping = {},
			timeout = 300,
		},
	},
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						--- @type string, string, string
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		},
	},

	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
				-- Open file/folder in git repository
				browse = "<Leader>go",
			},
		},
	},

	{

		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				{
					"debugloop/telescope-undo.nvim",
					cmd = "Telescope",
				},
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					enabled = vim.fn.executable("make") == 1,
					build = "make",
				},
			},
			cmd = "Telescope",
			opts = function()
				local get_icon = require("base.utils").get_icon
				local actions = require("telescope.actions")
				local mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<ESC>"] = actions.close,
						["<C-c>"] = false,
					},
					n = { ["q"] = actions.close },
				}
				return {
					defaults = {
						prompt_prefix = get_icon("Selected", 1),
						selection_caret = get_icon("Selected", 1),
						multi_icon = get_icon("selected", 1),
						path_display = { "truncate" },
						sorting_strategy = "ascending",
						layout_config = {
							horizontal = {
								prompt_position = "top",
								preview_width = 0.50,
							},
							vertical = {
								mirror = false,
							},
							width = 0.87,
							height = 0.80,
							preview_cutoff = 120,
						},
						mappings = mappings,
					},
					extensions = {
						undo = {
							use_delta = true,
							side_by_side = true,
							diff_context_lines = 0,
							entry_format = "󰣜 #$ID, $STAT, $TIME",
							layout_strategy = "horizontal",
							layout_config = {
								preview_width = 0.65,
							},
							mappings = {
								i = {
									["<cr>"] = require("telescope-undo.actions").yank_additions,
									["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
									["<C-cr>"] = require("telescope-undo.actions").restore,
								},
							},
						},
					},
				}
			end,
			config = function(_, opts)
				local telescope = require("telescope")
				telescope.setup(opts)
				-- Here we define the Telescope extension for all plugins.
				-- If you delete a plugin, you can also delete its Telescope extension.
				if utils.is_available("nvim-notify") then
					telescope.load_extension("notify")
				end
				if utils.is_available("telescope-fzf-native.nvim") then
					telescope.load_extension("fzf")
				end
				if utils.is_available("telescope-undo.nvim") then
					telescope.load_extension("undo")
				end
				if utils.is_available("project.nvim") then
					telescope.load_extension("projects")
				end
				if utils.is_available("LuaSnip") then
					telescope.load_extension("luasnip")
				end
				if utils.is_available("aerial.nvim") then
					telescope.load_extension("aerial")
				end
				if utils.is_available("nvim-neoclip.lua") then
					telescope.load_extension("neoclip")
					telescope.load_extension("macroscope")
				end
			end,
		},
	},

	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		opts = {
			highlights = {
				Normal = { link = "Normal" },
				NormalNC = { link = "NormalNC" },
				NormalFloat = { link = "Normal" },
				FloatBorder = { link = "FloatBorder" },
				StatusLine = { link = "StatusLine" },
				StatusLineNC = { link = "StatusLineNC" },
				WinBar = { link = "WinBar" },
				WinBarNC = { link = "WinBarNC" },
			},
			size = 10,
			open_mapping = [[<F7>]],
			shading_factor = 2,
			direction = "float",
			float_opts = {
				border = "rounded",
				highlights = { border = "Normal", background = "Normal" },
			},
		},
	},

	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		opts = {
			default = {
				find = {
					-- pick one of item in find_engine [ fd, rg ]
					cmd = "fd",
					options = {},
				},
				replace = {
					-- pick one of item in [ sed, oxi ]
					cmd = "sed",
				},
			},
			is_insert_mode = true, -- start open panel on is_insert_mode
			is_block_ui_break = true, -- prevent the UI from breaking
			mapping = {
				["toggle_line"] = {
					map = "d",
					cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
					desc = "toggle item.",
				},
				["enter_file"] = {
					map = "<cr>",
					cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
					desc = "open file.",
				},
				["send_to_qf"] = {
					map = "sqf",
					cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					desc = "send all items to quickfix.",
				},
				["replace_cmd"] = {
					map = "src",
					cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
					desc = "replace command.",
				},
				["show_option_menu"] = {
					map = "so",
					cmd = "<cmd>lua require('spectre').show_options()<CR>",
					desc = "show options.",
				},
				["run_current_replace"] = {
					map = "c",
					cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
					desc = "confirm item.",
				},
				["run_replace"] = {
					map = "R",
					cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
					desc = "replace all.",
				},
				["change_view_mode"] = {
					map = "sv",
					cmd = "<cmd>lua require('spectre').change_view()<CR>",
					desc = "results view mode.",
				},
				["change_replace_sed"] = {
					map = "srs",
					cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
					desc = "use sed to replace.",
				},
				["change_replace_oxi"] = {
					map = "sro",
					cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
					desc = "use oxi to replace.",
				},
				["toggle_live_update"] = {
					map = "sar",
					cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
					desc = "auto refresh changes when nvim writes a file.",
				},
				["resume_last_search"] = {
					map = "sl",
					cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
					desc = "repeat last search.",
				},
				["insert_qwerty"] = {
					map = "i",
					cmd = "<cmd>startinsert<CR>",
					desc = "insert (qwerty).",
				},
				["insert_colemak"] = {
					map = "o",
					cmd = "<cmd>startinsert<CR>",
					desc = "insert (colemak).",
				},
				["quit"] = {
					map = "q",
					cmd = "<cmd>lua require('spectre').close()<CR>",
					desc = "quit.",
				},
			},
		},
	},
	{
		"AckslD/nvim-neoclip.lua",
		requires = "nvim-telescope/telescope.nvim",
		event = "User BaseFile",
		opts = {},
	},

	--  zen-mode.nvim [distraction free mode]
	--  https://github.com/folke/zen-mode.nvim
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
	},

	--  suda.nvim [write as sudo]
	--  https://github.com/lambdalisue/suda.vim
	{
		"lambdalisue/suda.vim",
		cmd = { "SudaRead", "SudaWrite" },
	},

	--  vim-matchup [improved % motion]
	--  https://github.com/andymass/vim-matchup
	{
		"andymass/vim-matchup",
		event = "User BaseFile",
		config = function()
			vim.g.matchup_matchparen_deferred = 1 -- work async
			vim.g.matchup_matchparen_offscreen = {} -- disable status bar icon
		end,
	},
	--  hop.nvim [go to word visually]
	--  https://github.com/smoka7/hop.nvim
	{
		"smoka7/hop.nvim",
		cmd = { "HopWord" },
		opts = { keys = "etovxqpdygfblzhckisuran" },
	},
}
