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

		-- Keybinding: open terminal in file dir
		vim.keymap.set("n", "<leader>tt", OpenTerminalInFileDir, { desc = "Toggle terminal in file dir" })

		-- Keybinding: kill terminal subprocesses and close all terminal buffers
		vim.keymap.set("n", "<leader>tk", function()
			local parent_pid = vim.fn.getpid()

			-- Step 1: kill all child bash-like shells started by Neovim
			local handle = io.popen("ps --no-headers -o pid,comm --ppid " .. parent_pid)
			if handle then
				for line in handle:lines() do
					local pid, cmd = line:match("(%d+)%s+(%S+)")
					if cmd == "bash" or cmd == "zsh" or cmd == "sh" then
						vim.fn.jobstart({ "kill", "-9", pid }, { detach = true })
					end
				end
				handle:close()
			end

			-- Step 2: close all terminal buffers in Neovim
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[buf].buftype == "terminal" then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end

			vim.notify("Killed all ToggleTerm processes and buffers", vim.log.levels.INFO)
		end, { desc = "Kill all ToggleTerm terminals and processes" })
	end,
}
