return {
  {
    "ledger/vim-ledger",
    ft = { "ledger", "journal" },
    config = function()
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2

      vim.g.ledger_autofmt_bufwritepre = 1
    end,
  },
}
