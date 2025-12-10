return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      enabled = true,
      layout = { preset = 'telescope' },
      win = {
        input = {
          keys = {
            ['<C-k>'] = { 'history_back', mode = 'n' },
            ['<C-j>'] = { 'history_forward', mode = 'n' },
          },
        },
      },
    },
  },
  keys = {
    {
      '<leader><space>',
      function()
        Snacks.picker.smart { multi = { 'buffers', 'files' } }
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    -- find
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>sF',
      function()
        Snacks.picker.files { ignored = true }
      end,
      desc = 'Find Files',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>so',
      function()
        Snacks.picker.recent { filter = { cwd = true } }
      end,
      desc = 'Recent',
    },
    {
      '<leader>sO',
      function()
        Snacks.picker.recent()
      end,
      desc = 'All Recent',
    },

    -- gh TODO: use this?
    -- {
    --   '<leader>gi',
    --   function()
    --     Snacks.picker.gh_issue()
    --   end,
    --   desc = 'GitHub Issues (open)',
    -- },
    -- {
    --   '<leader>gI',
    --   function()
    --     Snacks.picker.gh_issue { state = 'all' }
    --   end,
    --   desc = 'GitHub Issues (all)',
    -- },
    -- {
    --   '<leader>gp',
    --   function()
    --     Snacks.picker.gh_pr()
    --   end,
    --   desc = 'GitHub Pull Requests (open)',
    -- },
    -- {
    --   '<leader>gP',
    --   function()
    --     Snacks.picker.gh_pr { state = 'all' }
    --   end,
    --   desc = 'GitHub Pull Requests (all)',
    -- },

    -- Grep
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep { hidden = true }
      end,
      desc = 'Search History',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Nvim files',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.pickers()
      end,
      desc = 'pickers',
    },
  },
}
