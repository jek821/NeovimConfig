return {
  "github/copilot.vim",
  config = function()
    function ToggleCopilot()
      if vim.g.copilot_enabled then
        vim.cmd("Copilot disable")
        vim.g.copilot_enabled = false
        print("Copilot Disabled")
      else
        vim.cmd("Copilot enable")
        vim.g.copilot_enabled = true
        print("Copilot Enabled")
      end
    end

    vim.g.copilot_enabled = false
    vim.api.nvim_set_keymap("n", "<leader>ct", [[:lua ToggleCopilot()<CR>]], { noremap = true, silent = true })
  end,
}

