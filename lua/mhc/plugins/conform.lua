return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>tf',
      function()
        vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
        print('Format on save: ' .. (vim.g.format_on_save_enabled and 'enabled' or 'disabled'))
      end,
      mode = '',
      desc = '[T]oggle [F]ormat on Save',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function()
      if not vim.g.format_on_save_enabled then
        return false
      end
      return {
        timeout_ms = 1000,
        lsp_fallback = true,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofumpt', 'goimports' },
      typescript = { 'prettierd' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },

      css = { 'prettierd' },
      json = { 'prettierd' },
      html = { 'prettierd' },
      markdown = { 'prettierd' },
    },
  },
  init = function()
    vim.g.format_on_save_enabled = true
  end,
}
