return {
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        -- { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      {
        'williamboman/mason.nvim',
        config = true,
        -- roslyn for dotnet lsp
        opts = {
          registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
          },
        },
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      { 'saghen/blink.cmp', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('mhc-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = '[L]SP: ' .. desc })
          end

          map('<leader>ld', function()
            require('telescope.builtin').lsp_definitions()
          end, 'Goto [D]efinition')

          map('<leader>lr', function()
            require('telescope.builtin').lsp_references()
          end, 'Goto [R]eferences')

          map('<leader>li', function()
            require('telescope.builtin').lsp_implementations()
          end, 'Goto [I]mplementation')

          map('<leader>lt', function()
            require('telescope.builtin').lsp_type_definitions()
          end, '[T]ype Definition')

          map('<leader>lSd', function()
            require('telescope.builtin').lsp_document_symbols()
          end, '[S]ymbols [D]ocument')

          map('<leader>lSw', function()
            require('telescope.builtin').lsp_dynamic_workspace_symbols()
          end, '[S]ymbols [W]orkspace ')

          map('<leader>la', vim.lsp.buf.code_action, 'Code [A]ction')

          map('<leader>lk', vim.lsp.buf.hover, '[K]eyword Documentation')
          map('<leader>ls', vim.lsp.buf.signature_help, '[S]ignature Help')
          map('<leader>lD', vim.lsp.buf.declaration, 'Goto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('mhc-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('mhc-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'mhc-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>lh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {
          text = {
            [vim.diagnostic.severity.ERROR] = 'E ',
            [vim.diagnostic.severity.WARN] = 'W ',
            [vim.diagnostic.severity.INFO] = 'I ',
            [vim.diagnostic.severity.HINT] = 'H ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        gopls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'delve',
        'gofumpt',
        'goimports',
        'golangci-lint',
        'golines',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      local registry = require 'mason-registry'
      local pkg_to_lsp = require('mason-lspconfig').get_mappings().package_to_lspconfig
      for _, pkg_name in ipairs(registry.get_installed_package_names()) do
        local server_name = pkg_to_lsp[pkg_name]
        if server_name then
          local user_config = vim.tbl_deep_extend('force', {}, servers[server_name] or {})
          user_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, user_config.capabilities or {})
          vim.lsp.config(server_name, user_config)
          vim.lsp.enable(server_name)
        end
      end
    end,
  },
}
