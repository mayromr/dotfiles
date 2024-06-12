return {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

  -- TODO: fix indent level not following tabs
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = { indent = { char = '│' }, scope = { show_start = false, show_end = false } } },
  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  -- This is equivalent to:
  --   require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = '▌' },
        change = { text = '▌' },
        delete = { text = '▌' },
        topdelete = { text = '▌' },
        changedelete = { text = '▌' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VeryLazy'
  --
  -- which loads which-key after all the UI elements are loaded. Events can be
  -- normal autocommands events (:help autocomd-events).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Diagnostics', _ = 'which_key_ignore' },
        ['<leader>j'] = { name = '[J]ump List', _ = 'which_key_ignore' },
        ['<leader>b'] = { name = 'De[B]ug', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]un Tests', _ = 'which_key_ignore' },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {},
    keys = { { '<leader>F', '<cmd>lua require("spectre").toggle()<CR>', desc = '[F]ind and Replace' } },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'auto',
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  'tpope/vim-abolish',
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]parenthen
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- require('mini.files').setup()
      -- vim.keymap.set('n', '<leader>e', function()
      --   require('mini.files').open(vim.api.nvim_buf_get_name(0))
      -- end, { desc = 'Open File Tree Relative To File' })
      -- vim.keymap.set('n', '<leader>E', require('mini.files').open, { desc = 'Open File Tree In cwd' })

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
}
