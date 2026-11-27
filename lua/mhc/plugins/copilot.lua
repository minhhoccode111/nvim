return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    panel = { enabled = false },
    filetypes = { markdown = true },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      trigger_on_accept = false,
      keymap = {
        accept = '<Tab>',
      },
    },
  },
}
