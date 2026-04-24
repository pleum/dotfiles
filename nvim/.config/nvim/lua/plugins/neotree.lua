return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
      filesystem = {
        filtered_items = {
          hide_gitignored = true,
        },
      },
      git_status = {
        timeout = 500, -- increase from default 200ms
      },
    },
  },
}
