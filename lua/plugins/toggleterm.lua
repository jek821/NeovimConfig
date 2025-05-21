return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			start_in_insert = true,
			open_mapping = [[<c-\>]],
			auto_scroll = true,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		-- Function to open a terminal in the current file's directory
		function OpenTerminalInFileDir()
			local file_dir = vim.fn.expand("%:p:h")
			local term = Terminal:new({
				dir = file_dir,
				direction = "float",
			})
			term:toggle()
		end

		-- Function to force close all terminals and kill subprocesses
		function KillAllTerminals()
			require("toggleterm.terminal").TerminalManager.get():shutdown()
		end

		-- Keybindings
		vim.keymap.set("n", "<leader>tt", OpenTerminalInFileDir, { desc = "Toggle terminal in file dir" })
		vim.keymap.set("n", "<leader>tk", KillAllTerminals, { desc = "Kill all terminals" })
	end,
}
