local close_map = { 'n', 'q', '<CMD>DiffviewClose<CR>', { desc = 'Close diffview' } }

return {
  {
    'sindrets/diffview.nvim',
    opts = {
      enhanced_diff_hl = true,
      default_args = {
        DiffviewOpen = { '--untracked-files=no', '--imply-local' },
      },
      view = {
        default = {
          layout = 'diff2_horizontal',
        },
        merge_tool = {
          layout = 'diff3_mixed',
          disable_diagnostics = true,
          winbar_info = true,
        },
      },
      keymaps = {
        view = {
          close_map,
        },
        file_panel = {
          close_map,
        },
      },
    },
    cmd = { 'DiffviewOpen' },
    keys = {
      {
        '<leader>gd',
        function()
          require('diffview').open {}
        end,
        desc = 'Open diffview',
      },
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
      require('neogit').setup {
        integrations = {
          diffview = true,
          telescope = true,
        },
        commit_editor = {
          spell_check = false,
          kind = 'tab',
        },
      }
    end,

    keys = {
      {
        '<leader>go',
        function()
          require('neogit').open {}
        end,
        desc = 'Open neogit',
      },
    },
  },
}
