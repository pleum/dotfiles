-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(ev)
    vim.keymap.set("n", "<leader>cg", function()
      local line = vim.api.nvim_get_current_line()
      if not line:match("//go:generate") then
        vim.notify("No go:generate directive on this line", vim.log.levels.WARN)
        return
      end

      local dir = vim.fn.expand("%:p:h")
      local output = {}

      vim.fn.jobstart({ "go", "generate" }, {
        cwd = dir,
        stdout_buffered = true,
        stderr_buffered = true,

        on_stdout = function(_, data)
          for _, l in ipairs(data) do
            if l ~= "" then
              table.insert(output, l)
            end
          end
        end,

        on_stderr = function(_, data)
          for _, l in ipairs(data) do
            if l ~= "" then
              table.insert(output, l)
            end
          end
        end,

        on_exit = function(_, code)
          local msg = table.concat(output, "\n")
          if code == 0 then
            vim.notify(msg ~= "" and msg or "go generate succeeded", vim.log.levels.INFO)
          else
            vim.notify("go generate failed (exit " .. code .. "):\n" .. msg, vim.log.levels.ERROR)
          end
        end,
      })
    end, { desc = "Run go:generate under cursor", buffer = ev.buf })
  end,
})
