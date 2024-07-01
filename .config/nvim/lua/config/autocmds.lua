-- Turn off paste mode when leaving insert

local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
local utils = require("base.utils")

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})
vim.api.nvim_set_hl(0, "HighlightURL", { underline = true })
autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
	desc = "URL Highlighting",
	callback = function()
		utils.set_url_effect()
	end,
})

-- 7. Customize right click contextual menu.
autocmd("VimEnter", {
	desc = "Disable right contextual menu warning message",
	callback = function()
		-- Disable right click message
		vim.api.nvim_command([[aunmenu PopUp.How-to\ disable\ mouse]])
		-- vim.api.nvim_command [[aunmenu PopUp.-1-]] -- You can remode a separator like this.
		vim.api.nvim_command([[menu PopUp.Toggle\ \Breakpoint <cmd>:lua require('dap').toggle_breakpoint()<CR>]])
		vim.api.nvim_command([[menu PopUp.-2- <Nop>]])
		vim.api.nvim_command([[menu PopUp.Start\ \Compiler <cmd>:CompilerOpen<CR>]])
		vim.api.nvim_command([[menu PopUp.Start\ \Debugger <cmd>:DapContinue<CR>]])
		vim.api.nvim_command([[menu PopUp.Run\ \Test <cmd>:Neotest run<CR>]])
	end,
})

-- 8. Unlist quickfix buffers if the filetype changes.
autocmd("FileType", {
	desc = "Unlist quickfist buffers",
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- 9. Close all notifications on BufWritePre.
autocmd("BufWritePre", {
	desc = "Close all notifications on BufWritePre",
	callback = function()
		require("notify").dismiss({ pending = true, silent = true })
	end,
})

-- ## COMMANDS --------------------------------------------------------------

-- 10. Testing commands
-- Aditional commands to the ones implemented in neotest.
-------------------------------------------------------------------

-- Customize this command to work as you like
cmd("TestNodejs", function()
	vim.cmd(":ProjectRoot") -- cd the project root (requires project.nvim)
	vim.cmd(":TermExec cmd='npm run test'") -- convention to run tests on nodejs
	-- You can generate code coverage by add this to your project's packages.json
	-- "tests": "jest --coverage"
end, { desc = "Run all unit tests for the current nodejs project" })

-- Customize this command to work as you like
cmd("TestNodejsE2e", function()
	vim.cmd(":ProjectRoot") -- cd the project root (requires project.nvim)
	vim.cmd(":TermExec cmd='npm run e2e'") -- Conventional way to call e2e in nodejs (requires ToggleTerm)
end, { desc = "Run e2e tests for the current nodejs project" })

-- Extra commands
----------------------------------------------

-- Change working directory
cmd("Cwd", function()
	vim.cmd(":cd %:p:h")
	vim.cmd(":pwd")
end, { desc = "cd current file's directory" })

-- Set working directory (alias)
cmd("Swd", function()
	vim.cmd(":cd %:p:h")
	vim.cmd(":pwd")
end, { desc = "cd current file's directory" })

-- Write all buffers
cmd("WriteAllBuffers", function()
	vim.cmd("wa")
end, { desc = "Write all changed buffers" })

-- Close all notifications
cmd("CloseNotifications", function()
	require("notify").dismiss({ pending = true, silent = true })
end, { desc = "Dismiss all notifications" })
