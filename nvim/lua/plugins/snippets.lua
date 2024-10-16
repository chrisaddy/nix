return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    config = function()
      local snip = require 'luasnip'
      local types = require 'luasnip.util.types'
      local s = snip.snippet
      local i = snip.insert_node
      local fmt = require('luasnip.extras.fmt').fmt

      snip.config.set_config {
        history = true,
        store_selection_keys = '<Tab>',
        updateevents = 'TextChanged,TextChangedI',
        override_builtin = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { '●', 'LuasnipChoiceNodeVirtualText' } },
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { '●', 'LuasnipInsertNodeVirtualText' } },
            },
          },
        },
      }
      require('luasnip.loaders.from_vscode').lazy_load()

      local cmp = require 'cmp'

      cmp.setup {
        mapping = {
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if snip.expandable() then
                snip.expand()
              else
                cmp.confirm {
                  select = true,
                }
              end
            else
              fallback()
            end
          end),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif snip.locally_jumpable(1) then
              snip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif snip.locally_jumpable(-1) then
              snip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
      }
      -- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/snippets/*.lua', true)) do
      --   loadfile(ft_path)()
      -- end
      require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/lua/snippets' }
    end,
  },
  {
    'benfowler/telescope-luasnip.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('telescope').load_extension 'luasnip'
      require('which-key').add {
        {
          '<leader>cs',
          '<cmd>Telescope luasnip<cr>',
          { desc = '[C]ode [S]nippet' },
        },
      }
    end,
  },
}
