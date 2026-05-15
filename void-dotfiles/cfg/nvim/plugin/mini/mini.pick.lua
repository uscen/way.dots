-- ============================================================================== #
-- Picker:                                                                        #
-- ============================================================================== #
Config.later(function()
  local MiniPick = require('mini.pick')
  local MiniExtra = require('mini.extra')
  local MiniFiles = require('mini.files')
  local MiniBufremove = require('mini.bufremove')
  MiniPick.setup({
    mappings = {
      choose             = '<Tab>',
      move_down          = '<C-j>',
      move_up            = '<C-k>',
      toggle_preview     = '<C-p>',
      choose_in_split    = '<C-v>',
      choose_in_vsplit   = '<C-s>',
      paste              = '<C-e>',
      another_choose     = {
        char = '<CR>',
        func = function()
          local choose_mapping = MiniPick.get_picker_opts().mappings.choose
          vim.api.nvim_input(choose_mapping)
        end,
      },
      actual_paste       = {
        char = '<C-r>',
        func = function()
          local content = vim.fn.getreg '+'
          if content ~= '' then
            local current_query = MiniPick.get_picker_query() or {}
            table.insert(current_query, content)
            MiniPick.set_picker_query(current_query)
          end
        end,
      },
      marked_to_quickfix = {
        char = '<S-q>',
        func = function()
          local items = MiniPick.get_picker_matches().marked or {}
          MiniPick.default_choose_marked(items)
          MiniPick.stop()
        end,
      },
      all_to_quickfix    = {
        char = '<C-q>',
        func = function()
          local matched_items = MiniPick.get_picker_matches().all or {}
          MiniPick.default_choose_marked(matched_items)
          MiniPick.stop()
        end,
      },
    },
    options = { use_cache = true, content_from_bottom = false },
    window = { config = { height = vim.o.lines, width = vim.o.columns }, prompt_caret = '|', prompt_prefix = '󱓇 ' },
    source = {
      preview = function(buf_id, item)
        return MiniPick.default_preview(buf_id, item, { line_position = 'center' })
      end,
    },
  })
  vim.ui.select = MiniPick.ui_select
  -- UI: =========================================================================================
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniPickStart',
    callback = function()
      local win_id = vim.api.nvim_get_current_win()
      vim.wo[win_id].winblend = 5
    end,
  })

  -- Pick Directory Form Nvim: ===================================================================
  MiniPick.registry.config = function()
    return MiniPick.builtin.files(nil, { source = { name = 'Config Files', cwd = vim.fn.stdpath('config') } })
  end

  -- Pick Directory Form Home : ==================================================================
  MiniPick.registry.home = function()
    local cwd = vim.fn.expand('~/')
    local choose = function(item)
      vim.schedule(function()
        MiniPick.builtin.files(nil, { source = { cwd = item.path } })
      end)
    end
    return MiniExtra.pickers.explorer({ cwd = cwd }, { source = { choose = choose } })
  end

  -- Pick Directory Project: =====================================================================
  MiniPick.registry.projects = function()
    local cwd = vim.fn.expand('~/Projects')
    local choose = function(item)
      vim.schedule(function()
        MiniPick.builtin.files(nil, { source = { cwd = item.path } })
      end)
    end
    return MiniExtra.pickers.explorer({ cwd = cwd }, { source = { choose = choose } })
  end

  -- Delete buffer in Buffers picker: =============================================================
  MiniPick.registry.buffers = function(local_opts)
    local wipeout_cur = function()
      local exclude_map = {}
      local matches = MiniPick.get_picker_matches()
      if vim.tbl_count(matches.marked) > 0 then
        for _, mark in pairs(matches.marked) do
          if mark == nil then return end
          exclude_map[mark.bufnr] = true
          MiniBufremove.wipeout(mark.bufnr)
        end
      elseif matches.current then
        exclude_map[matches.current.bufnr] = true
        MiniBufremove.wipeout(matches.current.bufnr)
      end
      local filter = vim.tbl_filter(function(value)
        return not exclude_map[value.bufnr]
      end, MiniPick.get_picker_items())
      MiniPick.set_picker_items(filter)
    end
    local buffer_mappings = { wipeout = { char = '<C-d>', func = wipeout_cur } }
    MiniPick.builtin.buffers(local_opts, { mappings = buffer_mappings })
  end

  -- Pick file using zoxide: =========================================================================
  Config.new_command('PickZoxide', function()
    local zoxide_output = vim.fn.system('zoxide query -l')
    local zoxide_dirs = vim.split(zoxide_output, '\n', { trimempty = true })
    MiniPick.start({
      source = {
        items = zoxide_dirs,
        choose = function(dir)
          vim.schedule(function()
            vim.fn.chdir(dir)
            return MiniFiles.open(dir)
          end)
        end,
      },
    })
  end)

  -- Pick file using fd: =========================================================================
  Config.new_command('PickFiles', function()
    MiniPick.builtin.cli({ command = { 'fd', '-t=f', '-H', '-I', '-E=.git', '-E=node_modules' } }, {
      source = {
        name = 'Files (fd)',
        show = function(buf, items, query)
          MiniPick.default_show(buf, items, query, { show_icons = true })
        end,
      },
    })
  end)
end)
