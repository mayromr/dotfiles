--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

local kinds = require('blink.cmp.types').CompletionItemKind

local kind_map = {
  method = kinds.Method,
  ['function'] = kinds.Function,
  constructor = kinds.Constructor,
  field = kinds.Field,
  variable = kinds.Variable,
  class = kinds.Class,
  interface = kinds.Interface,
  module = kinds.Module,
  property = kinds.Property,
  unit = kinds.Unit,
  value = kinds.Value,
  enum = kinds.Enum,
  keyword = kinds.Keyword,
  snippet = kinds.Snippet,
  text = kinds.Text,
  color = kinds.Color,
  file = kinds.File,
  reference = kinds.Reference,
  customcolor = kinds.Color,
}

function source.new(opts)
  local self = setmetatable({}, { __index = source })
  self.opts = opts
  return self
end

function source:enabled()
  local filetype = vim.bo.filetype

  local is_dap_buffer = filetype == 'dap-repl' or vim.startswith(filetype, 'dapui_')

  -- NOTE: we want to return early if we are not in a dap buffer in order to prevent loading the dap plugin
  if not is_dap_buffer then
    return false
  end

  local current_session = require('dap').session()

  if not current_session then
    return false
  end

  return current_session.capabilities.supportsCompletionsRequest or false
end

-- nvim-dap uses . prefix for cretin functions
function source:get_trigger_characters()
  local default_trigger_chars = { '.' }

  local session = require('dap').session()
  if not session then
    return default_trigger_chars
  end

  local trigger_characters = session.capabilities.completionTriggerCharacters or {}

  vim.list_extend(trigger_characters, default_trigger_chars)
  vim.fn.sort(trigger_characters)
  vim.fn.uniq(trigger_characters)

  return trigger_characters
end

function source:get_completions(ctx, callback)
  local dap = require 'dap'
  local dap_repl = require 'dap.repl'
  local session = assert(dap.session())

  ---@type lsp.CompletionItem[]
  local completions = {}

  local col = ctx.cursor[2]
  local dap_prefix = 'dap> '
  local offset = vim.startswith(ctx.line, dap_prefix) and dap_prefix:len() or 0
  local typed = ctx.line:sub(offset + 1, col)

  if vim.startswith(typed, '.') then
    for _, values in pairs(dap_repl.commands) do
      for _, directive in pairs(values) do
        if type(directive) == 'string' and vim.startswith(directive, typed) then
          table.insert(completions, { insertText = directive, label = directive, kind = kinds.Keyword })
        end
      end
    end
    for command, _ in pairs(dap_repl.commands.custom_commands or {}) do
      if vim.startswith(command, typed) then
        table.insert(completions, { insertText = command, label = command, kind = kinds.Keyword })
      end
    end
  end

  session:request('completions', {
    frameId = (session.current_frame or {}).id,
    text = typed,
    column = col + 1 - offset,
  }, function(err, response)
    if err then
      return
    end
    for _, item in pairs(response.targets) do
      if item.type then
        item.kind = kind_map[item.type]
      end
      item.insertText = item.text or item.label
      table.insert(completions, item)
    end

    callback {
      items = completions,
      is_incomplete_backward = true,
      is_incomplete_forward = true,
    }
  end)

  return function() end
end

return source
