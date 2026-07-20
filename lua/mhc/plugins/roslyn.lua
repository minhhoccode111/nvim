return {
  'seblyng/roslyn.nvim',
  ft = { 'cs' },
  opts = {
    broad_search = true,
  },
  config = function()
    vim.lsp.config('roslyn', {
      settings = {
        ['csharp|inlay_hints'] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_parameters = true,
        },
        ['csharp|code_lens'] = {
          dotnet_enable_references_code_lens = true,
          dotnet_enable_tests_code_lens = true,
        },
      },
    })
  end,
}
