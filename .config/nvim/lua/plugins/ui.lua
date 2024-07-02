return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	--  UI icons [icons]
	--  https://github.com/nvim-tree/nvim-web-devicons
	{
		"nvim-tree/nvim-web-devicons",
		enabled = vim.g.icons_enabled,
		event = "User BaseDefered",
		opts = {
			override = {
				default_icon = {
					icon = require("base.utils").get_icon("DefaultFile"),
					name = "default",
				},
				deb = { icon = "", name = "Deb" },
				lock = { icon = "󰌾", name = "Lock" },
				mp3 = { icon = "󰎆", name = "Mp3" },
				mp4 = { icon = "", name = "Mp4" },
				out = { icon = "", name = "Out" },
				["robots.txt"] = { icon = "󰚩", name = "Robots" },
				ttf = { icon = "", name = "TrueTypeFont" },
				rpm = { icon = "", name = "Rpm" },
				woff = { icon = "", name = "WebOpenFontFormat" },
				woff2 = { icon = "", name = "WebOpenFontFormat2" },
				xz = { icon = "", name = "Xz" },
				zip = { icon = "", name = "Zip" },
			},
		},
		config = function(_, opts)
			require("nvim-web-devicons").setup(opts)
			pcall(vim.api.nvim_del_user_command, "NvimWebDeviconsHiTest")
		end,
	},

	{
		"folke/which-key.nvim",
		event = "User BaseDefered",
		opts = {
			icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
			disable = { filetypes = { "TelescopePrompt" } },
		},
		config = function(_, opts)
			require("which-key").setup(opts)
			require("base.utils").which_key_register()
		end,
	},

	{
		"tzachar/highlight-undo.nvim",
		event = "User BaseDefered",
		opts = {
			hlgroup = "CurSearch",
			duration = 150,
			keymaps = {
				{ "n", "u", "undo", {} }, -- If you remap undo/redo, change this
				{ "n", "<C-r>", "redo", {} },
			},
		},
		config = function(_, opts)
			require("highlight-undo").setup(opts)

			-- Also flash on yank.
			vim.api.nvim_create_autocmd("TextYankPost", {
				desc = "Highlight yanked text",
				pattern = "*",
				callback = function()
					vim.highlight.on_yank()
				end,
			})
		end,
	},

	{
		"rcarriga/nvim-notify",
		event = "User BaseDefered",
		opts = function()
			local fps
			if is_android then
				fps = 30
			else
				fps = 144
			end

			return {
				timeout = 2000,
				fps = fps,
				max_height = function()
					return math.floor(vim.o.lines * 0.25)
				end,
				max_width = function()
					return math.floor(vim.o.columns * 0.25)
				end,
				on_open = function(win)
					-- enable markdown support on notifications
					vim.api.nvim_win_set_config(win, { zindex = 175 })
					if not vim.g.notifications_enabled then
						vim.api.nvim_win_close(win, true)
					end
					if not package.loaded["nvim-treesitter"] then
						pcall(require, "nvim-treesitter")
					end
					vim.wo[win].conceallevel = 3
					local buf = vim.api.nvim_win_get_buf(win)
					if not pcall(vim.treesitter.start, buf, "markdown") then
						vim.bo[buf].syntax = "markdown"
					end
					vim.wo[win].spell = false
				end,
			}
		end,
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},

	-- animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				-- separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = [[
        ██████╗ ███████╗██╗   ██╗ █████╗ ███████╗██╗     ██╗███████╗███████╗
        ██╔══██╗██╔════╝██║   ██║██╔══██╗██╔════╝██║     ██║██╔════╝██╔════╝
        ██║  ██║█████╗  ██║   ██║███████║███████╗██║     ██║█████╗  █████╗  
        ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══██║╚════██║██║     ██║██╔══╝  ██╔══╝  
        ██████╔╝███████╗ ╚████╔╝ ██║  ██║███████║███████╗██║██║     ███████╗
        ╚═════╝ ╚══════╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝     ╚══════╝
      ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
		end,
	},
	"f-person/auto-dark-mode.nvim",
	config = {
		update_interval = 1000,
		set_dark_mode = function()
			vim.api.nvim_set_option("background", "dark")
		end,
		set_light_mode = function()
			vim.api.nvim_set_option("background", "light")
		end,
	},
	{
		"xiyaowong/transparent.nvim",
	},
}
