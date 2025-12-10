return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        lsp_styles = {
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
          inlay_hints = {
            background = true,
          },
        },
        integrations = {
          gitsigns = true,
          treesitter = true,
          diffview = true,
          snacks = { enabled = true },
          mini = {
            enabled = true,
          },
        },
      }
      -- setup must be called before loading
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
