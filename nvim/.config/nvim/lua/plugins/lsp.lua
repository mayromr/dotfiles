local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {},
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        check = {
          command = 'clippy',
        },
      },
    },
  },
  harper_ls = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  ts_ls = {},
  svelte = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
  },
  -- terraformls = {},
  -- cspell = {},
  omnisharp = {
    settings = {
      cmd = { 'dotnet', vim.fn.stdpath 'data' .. '/mason/packages/omnisharp/libexec/OmniSharp.dll' },
      enable_ms_build_load_projects_on_demand = false,
      enable_editorconfig_support = true,
      enable_import_completion = true,
      enable_roslyn_analyzers = true,
    },
  },
  --

  lua_ls = {
    -- cmd = {...},
    -- filetypes { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          -- Tells lua_ls where to find all the Lua files that you have loaded
          -- for your neovim configuration.
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
          -- If lua_ls is really slow on your computer, you can try this instead:
          -- library = { vim.env.VIMRUNTIME },
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua',
  'sql-formatter',
  'prettier',
  'prettierd',
  'eslint_d',
  'black',
  'isort',
  'pylint',
  'mypy',
})

return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Mason must be loaded before its dependents so we need to set it up here.
      { 'mason-org/mason.nvim', opts = {} },
      {
        'mason-org/mason-lspconfig.nvim',
        opts = {
          automatic_enable = {
            exclude = {},
          },
        },
      },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = ensure_installed,
          integrations = {
            ['mason-lspconfig'] = true,
            ['mason-null-ls'] = false,
            ['mason-nvim-dap'] = false,
          },
        },
      },
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          --  TODO: gd is dumb af here, ask youval for better one
          map('gd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', Snacks.picker.lsp_declarations, '[G]oto [D]eclaration')

          -- Find references for the word under your cursor.
          map('gr', Snacks.picker.lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', Snacks.picker.lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('gt', Snacks.picker.lsp_type_definitions, '[G]oto [T]ype')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ss', Snacks.picker.lsp_symbols, '[S]earch [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>sS', Snacks.picker.lsp_workspace_symbols, '[S]earch [S]ymbols in workspace')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]name')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'v' })

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'LSP Hover')
          map('<c-k>', vim.lsp.buf.signature_help, 'Signature help', 'i')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ss', Snacks.picker.lsp_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>sS', Snacks.picker.lsp_workspace_symbols, 'Open Workspace Symbols')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
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
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>ci', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[C]ode Toggle [I]lay')
          end
        end,
      })
    end,
  },
}
