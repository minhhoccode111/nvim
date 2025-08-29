-- Formatters: add spaces, semi-colon, etc. so code have consistent format

return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>AF',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[A]ction: [F]ormat Code',
    },
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
    format_on_save = function(bufnr)
      -- Check global toggle state
      if not vim.g.format_on_save_enabled then
        return false
      end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      -- Manually edit code style CS50
      -- but we still be able to manually <leader>F to format
      local disable_filetypes = {
        -- c = true,
        -- cpp = true,
        -- json = true,
        -- markdown = true,
        -- md = true,
      }
      return {
        timeout_ms = 1500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      c = { 'clang-format' },
      bash = { 'shfmt' },
      python = { 'black' },

      lua = { 'stylua' },
      go = { 'golines' },
      cs = { 'csharpier' },

      typescript = { 'prettierd' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },

      css = { 'prettierd' },
      json = { 'jq', 'prettierd' },
      html = { 'prettierd' },
      markdown = { 'prettierd' },
    },
  },
  init = function()
    -- Initialize the format on save toggle state to true by default
    vim.g.format_on_save_enabled = true
    -- vim.g.format_on_save_enabled = false
  end,
}
