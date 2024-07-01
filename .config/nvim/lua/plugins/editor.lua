local utils = require("base.utils")

return {
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
}
