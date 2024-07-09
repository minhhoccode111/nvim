-- Autoformat

return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat Code',
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
    notify_on_error = false,
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
        --
        -- markdown = true,
        -- json = true,
        -- md = true,
      }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = { -- <leader>F to add like ';' to js, ts
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },

      python = { { 'isort', 'black' } },
      -- web
      javascript = { { 'prettierd', 'prettier', 'standardjs' } },
      typescript = { { 'prettierd', 'prettier' } },
      -- jsx = { { 'prettierd', 'prettier', 'standardjs' } },
      -- tsx = { { 'prettierd', 'prettier', 'standardjs' } },
      javascriptreact = { { 'prettierd', 'prettier', 'standardjs' } },
      typescriptreact = { { 'prettierd', 'prettier', 'standardjs' } },
      html = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      markdown = { { 'prettierd', 'prettier' } },
      -- go = { 'ast_grep' },

      -- low level
      c = { { 'clang-format', 'ast_grep' } },
    },
  },
  init = function()
    -- Initialize the format on save toggle state to true by default
    vim.g.format_on_save_enabled = true
  end,
}
