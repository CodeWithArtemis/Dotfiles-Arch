local utils = require("base.utils")
local is_windows = vim.fn.has("win32") == 1 -- true if on windows
return {
	-- Create annotations with one keybind, and jump your cursor in the inserted annotation
	--Github
	--
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "Genesis",
					path = "~/Desktop/Vault/Obsidian Vaults/Genesis",
				},
			},

			-- see below for full list of options 👇
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "User BaseFile",
		cmd = {
			"ColorizerToggle",
			"ColorizerAttachToBuffer",
			"ColorizerDetachFromBuffer",
			"ColorizerReloadAllBuffers",
		},
		opts = { user_default_options = { names = false } },
	},

	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},

	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	-- Go forward/backward with square brackets
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right",
		},
	},
	{
		"nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},

	{
		"Zeioth/compiler.nvim",
		cmd = {
			"CompilerOpen",
			"CompilerToggleResults",
			"CompilerRedo",
			"CompilerStop",
		},
		dependencies = { "stevearc/overseer.nvim" },
		opts = {},
	},

	--  overseer [task runner]
	--  https://github.com/stevearc/overseer.nvim
	{
		"stevearc/overseer.nvim",
		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerSaveBundle",
			"OverseerLoadBundle",
			"OverseerDeleteBundle",
			"OverseerRunCmd",
			"OverseerRun",
			"OverseerInfo",
			"OverseerBuild",
			"OverseerQuickAction",
			"OverseerTaskAction",
			"OverseerClearCache",
		},
		opts = {
			-- Tasks are disposed 5 minutes after running to free resources.
			-- If you need to close a task immediately:
			-- press ENTER in the output menu on the task you wanna close.
			task_list = { -- this refers to the window that shows the result
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
			-- component_aliases = { -- uncomment this to disable notifications
			--   -- Components included in default will apply to all tasks
			--   default = {
			--     { "display_duration", detail_level = 2 },
			--     "on_output_summarize",
			--     "on_exit_set_status",
			--     --"on_complete_notify",
			--     "on_complete_dispose",
			--   },
			-- },
		},
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				suggestion = { enabled = false },
				panel = { enabled = false },
			}, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
	},

	{
		"zbirenbaum/copilot-cmp",
		opts = { suggesion = { enabled = false }, panel = { enabled = false } },
		config = function(_, opts)
			require("copilot_cmp").setup(opts)
		end,
	},
	{
		"stevearc/overseer.nvim",
		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerSaveBundle",
			"OverseerLoadBundle",
			"OverseerDeleteBundle",
			"OverseerRunCmd",
			"OverseerRun",
			"OverseerInfo",
			"OverseerBuild",
			"OverseerQuickAction",
			"OverseerTaskAction",
			"OverseerClearCache",
		},
		opts = {
			task_list = { -- the window that shows the results.
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
			-- component_aliases = {
			--   default = {
			--     -- Behaviors that will apply to all tasks.
			--     "on_exit_set_status",                   -- don't delete this one.
			--     "on_output_summarize",                  -- show last line on the list.
			--     "display_duration",                     -- display duration.
			--     "on_complete_notify",                   -- notify on task start.
			--     "open_output",                          -- focus last executed task.
			--     { "on_complete_dispose", timeout=300 }, -- dispose old tasks.
			--   },
			-- },
		},
	},

	{
		"L3MON4D3/LuaSnip",
		build = not is_windows and "make install_jsregexp" or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"zeioth/NormalSnippets",
			"benfowler/telescope-luasnip.nvim",
		},
		event = "User BaseFile",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			region_check_events = "CursorMoved",
		},
		config = function(_, opts)
			if opts then
				require("luasnip").config.setup(opts)
			end
			vim.tbl_map(function(type)
				require("luasnip.loaders.from_" .. type).lazy_load()
			end, { "vscode", "snipmate", "lua" })
			-- friendly-snippets - enable standardized comments snippets
			require("luasnip").filetype_extend("typescript", { "tsdoc" })
			require("luasnip").filetype_extend("javascript", { "jsdoc" })
			require("luasnip").filetype_extend("lua", { "luadoc" })
			require("luasnip").filetype_extend("python", { "pydoc" })
			require("luasnip").filetype_extend("rust", { "rustdoc" })
			require("luasnip").filetype_extend("cs", { "csharpdoc" })
			require("luasnip").filetype_extend("c", { "cdoc" })
			require("luasnip").filetype_extend("cpp", { "cppdoc" })
			require("luasnip").filetype_extend("php", { "phpdoc" })
			require("luasnip").filetype_extend("kotlin", { "kdoc" })
			require("luasnip").filetype_extend("ruby", { "rdoc" })
			require("luasnip").filetype_extend("sh", { "shelldoc" })
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		cmd = {
			"MarkdownPreview",
			"MarkdownPreviewStop",
			"MarkdownPreviewToggle",
		},
	},

	--  [markdown markmap]
	--  https://github.com/zeioth/markmap.nvim
	--  Important: Make sure you have yarn in your PATH before running markmap.
	{
		"zeioth/markmap.nvim",
		build = "yarn global add markmap-cli",
		cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
		config = function(_, opts)
			require("markmap").setup(opts)
		end,
	},

	--  GIT ---------------------------------------------------------------------
	--  Git signs [git hunks]
	--  https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable("git") == 1,
		event = "User BaseGitFile",
		opts = function()
			local get_icon = require("base.utils").get_icon
			return {
				max_file_length = vim.g.big_file.lines,
				signs = {
					add = { text = get_icon("GitSign") },
					change = { text = get_icon("GitSign") },
					delete = { text = get_icon("GitSign") },
					topdelete = { text = get_icon("GitSign") },
					changedelete = { text = get_icon("GitSign") },
					untracked = { text = get_icon("GitSign") },
				},
			}
		end,
	},

	{
		"mfussenegger/nvim-dap",
		enabled = vim.fn.has("win32") == 0,
		event = "User BaseFile",
		config = function()
			local dap = require("dap")

			-- C#
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
				args = { "--interpreter=vscode" },
			}
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function() -- Ask the user what executable wants to debug
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Program.exe", "file")
					end,
				},
			}

			-- F#
			dap.configurations.fsharp = dap.configurations.cs

			-- Visual basic dotnet
			dap.configurations.vb = dap.configurations.cs

			-- Java
			-- Note: The java debugger jdtls is automatically spawned and configured
			-- by the plugin 'nvim-java' in './3-dev-core.lua'.

			-- Python
			dap.adapters.python = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = { "-m", "debugpy.adapter" },
			}
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}", -- This configuration will launch the current file if used.
				},
			}

			-- Lua
			dap.adapters.nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end
			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
					program = function()
						pcall(require("osv").launch({ port = 8086 }))
					end,
				},
			}

			-- C
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
					detached = function()
						if is_windows then
							return false
						else
							return true
						end
					end,
				},
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function() -- Ask the user what executable wants to debug
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			-- C++
			dap.configurations.cpp = dap.configurations.c

			-- Rust
			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function() -- Ask the user what executable wants to debug
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					initCommands = function() -- add rust types support (optional)
						-- Find out where to look for the pretty printer Python module
						local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

						local script_import = 'command script import "'
							.. rustc_sysroot
							.. '/lib/rustlib/etc/lldb_lookup.py"'
						local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

						local commands = {}
						local file = io.open(commands_file, "r")
						if file then
							for line in file:lines() do
								table.insert(commands, line)
							end
							file:close()
						end
						table.insert(commands, 1, script_import)

						return commands
					end,
				},
			}

			-- Go
			-- Requires:
			-- * You have initialized your module with 'go mod init module_name'.
			-- * You :cd your project before running DAP.
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}
			dap.configurations.go = {
				{
					type = "delve",
					name = "Compile module and debug this file",
					request = "launch",
					program = "./${relativeFileDirname}",
				},
				{
					type = "delve",
					name = "Compile module and debug this file (test)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}

			-- Dart / Flutter
			dap.adapters.dart = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
				args = { "dart" },
			}
			dap.adapters.flutter = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
				args = { "flutter" },
			}
			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch dart",
					dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/", -- ensure this is correct
					flutterSdkPath = "/opt/flutter", -- ensure this is correct
					program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
					cwd = "${workspaceFolder}",
				},
				{
					type = "flutter",
					request = "launch",
					name = "Launch flutter",
					dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/", -- ensure this is correct
					flutterSdkPath = "/opt/flutter", -- ensure this is correct
					program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
					cwd = "${workspaceFolder}",
				},
			}

			-- Kotlin
			-- Kotlin projects have very weak project structure conventions.
			-- You must manually specify what the project root and main class are.
			dap.adapters.kotlin = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/kotlin-debug-adapter",
			}
			dap.configurations.kotlin = {
				{
					type = "kotlin",
					request = "launch",
					name = "Launch kotlin program",
					projectRoot = "${workspaceFolder}/app", -- ensure this is correct
					mainClass = "AppKt", -- ensure this is correct
				},
			}

			-- Javascript / Typescript (firefox)
			dap.adapters.firefox = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
			}
			dap.configurations.typescript = {
				{
					name = "Debug with Firefox",
					type = "firefox",
					request = "launch",
					reAttach = true,
					url = "http://localhost:4200", -- Write the actual URL of your project.
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "/usr/bin/firefox",
				},
			}
			dap.configurations.javascript = dap.configurations.typescript
			dap.configurations.javascriptreact = dap.configurations.typescript
			dap.configurations.typescriptreact = dap.configurations.typescript

			-- Javascript / Typescript (chromium)
			-- If you prefer to use this adapter, comment the firefox one.
			-- But to use this adapter, you must manually run one of these two, first:
			-- * chromium --remote-debugging-port=9222 --user-data-dir=remote-profile
			-- * google-chrome-stable --remote-debugging-port=9222 --user-data-dir=remote-profile
			-- After starting the debugger, you must manually reload page to get all features.
			-- dap.adapters.chrome = {
			--  type = 'executable',
			--  command = vim.fn.stdpath('data')..'/mason/bin/chrome-debug-adapter',
			-- }
			-- dap.configurations.typescript = {
			--  {
			--   name = 'Debug with Chromium',
			--   type = "chrome",
			--   request = "attach",
			--   program = "${file}",
			--   cwd = vim.fn.getcwd(),
			--   sourceMaps = true,
			--   protocol = "inspector",
			--   port = 9222,
			--   webRoot = "${workspaceFolder}"
			--  }
			-- }
			-- dap.configurations.javascript = dap.configurations.typescript
			-- dap.configurations.javascriptreact = dap.configurations.typescript
			-- dap.configurations.typescriptreact = dap.configurations.typescript

			-- PHP
			dap.adapters.php = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/php-debug-adapter",
			}
			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9000,
				},
			}

			-- Shell
			dap.adapters.bashdb = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
				name = "bashdb",
			}
			dap.configurations.sh = {
				{
					type = "bashdb",
					request = "launch",
					name = "Launch file",
					showDebugOutput = true,
					pathBashdb = vim.fn.stdpath("data")
						.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
					pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
					trace = true,
					file = "${file}",
					program = "${file}",
					cwd = "${workspaceFolder}",
					pathCat = "cat",
					pathBash = "/bin/bash",
					pathMkfifo = "mkfifo",
					pathPkill = "pkill",
					args = {},
					env = {},
					terminalKind = "integrated",
				},
			}

			-- Elixir
			dap.adapters.mix_task = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls-debugger",
				args = {},
			}
			dap.configurations.elixir = {
				{
					type = "mix_task",
					name = "mix test",
					task = "test",
					taskArgs = { "--trace" },
					request = "launch",
					startApps = true, -- for Phoenix projects
					projectDir = "${workspaceFolder}",
					requireFiles = {
						"test/**/test_helper.exs",
						"test/**/*_test.exs",
					},
				},
			}
		end, -- of dap config
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"rcarriga/cmp-dap",
			"jay-babu/mason-nvim-dap.nvim",
			"jbyuki/one-small-step-for-vimkind",
		},
	},

	-- nvim-dap-ui [dap ui]
	-- https://github.com/mfussenegger/nvim-dap-ui
	-- user interface for the debugger dap
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
		opts = { floating = { border = "rounded" } },
		config = function(_, opts)
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			dapui.setup(opts)
		end,
	},

	-- cmp-dap [dap autocomplete]
	-- https://github.com/mfussenegger/cmp-dap
	-- Enables autocomplete for the debugger dap.
	-- {
	-- 	"rcarriga/cmp-dap",
	-- 	dependencies = { "nvim-cmp" },
	-- 	config = function()
	-- 		require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	-- 			sources = {
	-- 				{ name = "dap" },
	-- 			},
	-- 		})
	-- 	end,
	-- },
	--
	-- {
	{
		"skywind3000/gutentags_plus",
		ft = { "c", "cpp" },
		dependencies = { "ludovicchabant/vim-gutentags" },
		config = function()
			-- NOTE: On vimplugins we use config instead of opts.
			vim.g.gutentags_plus_nomap = 1
			vim.g.gutentags_resolve_symlinks = 1
			vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "/tags"
			vim.api.nvim_create_autocmd("FileType", {
				desc = "Auto generate C/C++ tags",
				callback = function()
					local is_c = vim.bo.filetype == "c" or vim.bo.filetype == "cpp"
					if is_c then
						vim.g.gutentags_enabled = 1
					else
						vim.g.gutentags_enabled = 0
					end
				end,
			})
		end,
	},

	{
		"nvim-neotest/neotest",
		cmd = { "Neotest" },
		dependencies = {
			"sidlatau/neotest-dart",
			"Issafalcon/neotest-dotnet",
			"jfpedroza/neotest-elixir",
			"nvim-neotest/neotest-go",
			"rcasia/neotest-java",
			"nvim-neotest/neotest-jest",
			"olimorris/neotest-phpunit",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
			"lawrence-laz/neotest-zig",
		},
		opts = function()
			return {
				-- your neotest config here
				adapters = {
					require("neotest-dart"),
					require("neotest-dotnet"),
					require("neotest-elixir"),
					require("neotest-go"),
					require("neotest-java"),
					require("neotest-jest"),
					require("neotest-phpunit"),
					require("neotest-python"),
					require("neotest-rust"),
					require("neotest-zig"),
				},
			}
		end,
		config = function(_, opts)
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup(opts)
		end,
	},
	{ "onsails/lspkind.nvim" },

	{
		"zeioth/heirline-components.nvim",
		opts = {
			icons = require("base.icons.nerd_font"),
		},
	},

	--  heirline [ui components]
	--  https://github.com/rebelot/heirline.nvim
	--  Use it to customize the components of your user interface,
	--  Including tabline, winbar, statuscolumn, statusline.
	--  Be aware some components are positional. Read heirline documentation.
	{
		"rebelot/heirline.nvim",
		dependencies = { "zeioth/heirline-components.nvim" },
		event = "User BaseDefered",
		opts = function()
			local lib = require("heirline-components.all")
			return {
				opts = {
					disable_winbar_cb = function(args) -- We do this to avoid showing it on the greeter.
						local is_disabled = not require("heirline-components.buffer").is_valid(args.buf)
							or lib.condition.buffer_matches({
								buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
								filetype = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" },
							}, args.buf)
						return is_disabled
					end,
				},
				tabline = { -- UI upper bar
					lib.component.tabline_conditional_padding(),
					lib.component.tabline_buffers(),
					lib.component.fill({ hl = { bg = "tabline_bg" } }),
					lib.component.tabline_tabpages(),
				},
				winbar = { -- UI breadcrumbs bar
					init = function(self)
						self.bufnr = vim.api.nvim_get_current_buf()
					end,
					fallthrough = false,
					-- Winbar for terminal, neotree, and aerial.
					{
						condition = function()
							return not lib.condition.is_active()
						end,
						{
							lib.component.neotree(),
							lib.component.compiler_play(),
							lib.component.fill(),
							lib.component.compiler_redo(),
							lib.component.aerial(),
						},
					},
					-- Regular winbar
					{
						lib.component.neotree(),
						lib.component.compiler_play(),
						lib.component.fill(),
						lib.component.breadcrumbs(),
						lib.component.fill(),
						lib.component.compiler_redo(),
						lib.component.aerial(),
					},
				},
				statuscolumn = { -- UI left column
					init = function(self)
						self.bufnr = vim.api.nvim_get_current_buf()
					end,
					lib.component.foldcolumn(),
					lib.component.numbercolumn(),
					lib.component.signcolumn(),
				} or nil,
				statusline = { -- UI statusbar
					hl = { fg = "fg", bg = "bg" },
					lib.component.mode(),
					lib.component.git_branch(),
					lib.component.file_info(),
					lib.component.git_diff(),
					lib.component.diagnostics(),
					lib.component.fill(),
					lib.component.cmd_info(),
					lib.component.fill(),
					lib.component.lsp(),
					lib.component.compiler_state(),
					lib.component.virtual_env(),
					lib.component.nav(),
					lib.component.mode({ surround = { separator = "right" } }),
				},
			}
		end,
		config = function(_, opts)
			local heirline = require("heirline")
			local heirline_components = require("heirline-components.all")

			-- Setup
			heirline_components.init.subscribe_to_events()
			heirline.load_colors(heirline_components.hl.get_colors())
			heirline.setup(opts)
		end,
	},
}
