-- ============================================================================== #
-- Autocommands:                                                                  #
-- ============================================================================== #
Config.now(function()
  -- Auto command helper to add autocommands to my custom group: ===================================
  local custom_group = vim.api.nvim_create_augroup('kaz-custom-config', {})
  _G.Config.new_autocmd = function(event, opts)
    opts.group = opts.group or custom_group
    vim.api.nvim_create_autocmd(event, opts)
  end

  -- Enable Cmd Autocomplete: ====================================================================
  Config.new_autocmd('CmdlineChanged', { pattern = { ':', '/', '?' }, callback = function()
    vim.fn.wildtrigger()
  end })

  -- Auto Save: ==================================================================================
  Config.new_autocmd({ 'BufLeave', 'FocusLost', 'VimLeavePre' }, {
    group = vim.api.nvim_create_augroup('save_buffers', {}),
    callback = function(event)
      local buf = event.buf
      if vim.api.nvim_get_option_value('modified', { buf = buf }) then
        vim.schedule(function()
          vim.api.nvim_buf_call(buf, function()
            vim.cmd 'silent! wa'
          end)
        end)
      end
    end,
  })

  ---Auto Cleanup: ===============================================================================
  Config.new_autocmd('FocusLost', {
    once = true,
    callback = function()
      if vim.g.is_windows then return end
      vim.system { 'find', vim.o.undodir, '-mtime', '+30d', '-delete' }
      vim.system { 'find', vim.lsp.log.get_filename(), '-size', '+20M', '-delete' }
    end,
  })

  -- No share or backup files: ===================================================================
  Config.new_autocmd({ 'BufWritePre' }, {
    pattern = vim.g.is_windows and { 'C:/users/lli/scoop/*', 'C:/users/lli/win.dots/*' } or { '/mnt/*', '/boot/*' },
    callback = function()
      vim.opt_local.undofile = false
      vim.opt_local.shada = 'NONE'
    end,
  })

  -- Disable swap/undo/backup files in temp directories or shm: ==================================
  Config.new_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('undo_disable', { clear = true }),
    pattern = { '/tmp/*', '*.tmp', '*.bak', 'COMMIT_EDITMSG', 'MERGE_MSG' },
    callback = function(event)
      vim.opt_local.undofile = false
      if event.file == 'COMMIT_EDITMSG' or event.file == 'MERGE_MSG' then
        vim.opt_local.swapfile = false
      end
    end,
  })

  -- Switch to Normal mode on focus/tab/window leave if in Insert mode: ==========================
  Config.new_autocmd({ 'FocusLost', 'WinLeave' }, {
    group = vim.api.nvim_create_augroup('leave_insert', {}),
    callback = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == 'i' or mode == 'ic' then
        vim.cmd('stopinsert')
      end
    end,
  })

  -- Delete empty temp ShaDa files: ==============================================================
  Config.new_autocmd({ 'VimLeavePre' }, {
    group = vim.api.nvim_create_augroup('delete_empty_shada', { clear = true }),
    pattern = { '*' },
    callback = function()
      local status = 0
      for _, f in ipairs(vim.fn.globpath(vim.fn.stdpath('data') .. '/shada', '*tmp*', false, true)) do
        if vim.tbl_isempty(vim.fn.readfile(f)) then
          status = status + vim.fn.delete(f)
        end
      end
      if status ~= 0 then
        vim.notify('Could not delete empty temporary ShaDa files.', vim.log.levels.ERROR)
        vim.fn.getchar()
      end
    end,
  })

  -- mariasolos/execute_cmd_and_stay: ============================================================
  Config.new_autocmd('CmdwinEnter', {
    group = vim.api.nvim_create_augroup('exe_keep_cmd_line_window', {}),
    desc = 'Execute command and stay in the command-line window',
    callback = function(args) vim.keymap.set({ 'n', 'i' }, '<leader><cr>', '<cr>q:', { buffer = args.buf }) end,
  })

  -- Remove background for all WinSeparator sections =============================================
  Config.new_autocmd('ColorScheme', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('sp_bg_removed', { clear = true }),
    desc = 'Remove background for all WinSeparator sections',
    callback = function()
      vim.cmd('highlight WinSeparator guibg=None')
    end,
  })

  -- Delete [No Name] buffers: ====================================================================
  Config.new_autocmd('BufHidden', {
    group = vim.api.nvim_create_augroup('delete_no_name_buffer', { clear = true }),
    callback = function(event)
      if event.file == '' and vim.bo[event.buf].buftype == '' and not vim.bo[event.buf].modified then
        vim.schedule(function() pcall(vim.api.nvim_buf_delete, event.buf, {}) end)
      end
    end,
  })

  -- auto detects filetype if the filetype is empty: ===============================================
  Config.new_autocmd('BufWritePost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('FileDetect', { clear = true }),
    callback = function()
      if vim.bo.filetype == '' then vim.cmd('filetype detect') end
    end,
  })

  -- jump to last accessed window on closing the current one: =====================================
  Config.new_autocmd('WinClosed', {
    nested = true,
    group = vim.api.nvim_create_augroup('jump_to_last_window', { clear = true }),
    callback = function()
      if vim.fn.expand('<amatch>') == vim.fn.win_getid() then vim.cmd('wincmd p') end
    end,
  })

  -- Disable diagnostics in node_modules =========================================================
  Config.new_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('disable_diagnostics', { clear = true }),
    pattern = '*/node_modules/*',
    callback = function()
      vim.diagnostic.enable(false, { bufnr = 0 })
    end,
  })

  -- Clear the last used search pattern when opening a new buffer ================================
  Config.new_autocmd('BufReadPre', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('clear_search', { clear = true }),
    callback = function()
      vim.fn.setreg('/', '')
      vim.cmd 'let @/ = ""'
    end,
  })

  -- Don't Comment New Line ======================================================================
  Config.new_autocmd('FileType', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('diable_new_line_comments', { clear = true }),
    callback = function()
      vim.opt_local.formatoptions:remove('c')
      vim.opt_local.formatoptions:remove('r')
      vim.opt_local.formatoptions:remove('o')
      vim.opt_local.formatoptions:remove('t')
    end,
  })

  -- Highlight Yank ==============================================================================
  Config.new_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    callback = function()
      if vim.v.operator == 'y' then
        vim.fn.setreg('+', vim.fn.getreg('0'))
        vim.hl.on_yank({ on_macro = true, on_visual = true, higroup = 'IncSearch', timeout = 100 })
      end
    end,
  })

  -- yankring: ==================================================================================
  Config.new_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('danwlker/yankring', { clear = true }),
    callback = function()
      if vim.v.event.operator == 'y' then
        for i = 9, 1, -1 do -- Shift all numbered registers.
          vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
        end
      end
    end,
  })

  -- Auto-resize splits on window resize:  =======================================================
  Config.new_autocmd('VimResized', {
    group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd('tabdo wincmd =')
      vim.cmd('tabnext ' .. current_tab)
    end,
  })

  -- Automatically adjust scrolloff based on window size: ======================================
  Config.new_autocmd('WinResized', {
    group = vim.api.nvim_create_augroup('smart_scrolloff', { clear = true }),
    callback = function()
      local percentage = 0.16
      local percentage_lines = math.floor(vim.o.lines * percentage)
      local max_lines = 5
      vim.o.scrolloff = math.min(max_lines, percentage_lines)
    end,
  })

  -- Fix broken macro recording notification for cmdheight 0: ====================================
  local show_recordering = vim.api.nvim_create_augroup('show_recordering', { clear = true })
  Config.new_autocmd('RecordingEnter', {
    pattern = '*',
    group = show_recordering,
    callback = function()
      -- Set to 1 when remove statusline
      vim.opt_local.cmdheight = 0
    end,
  })
  Config.new_autocmd('RecordingLeave', {
    pattern = '*',
    group = show_recordering,
    desc = 'Fix broken macro recording notification for cmdheight 0, pt2',
    callback = function()
      local timer = vim.loop.new_timer()
      ---@diagnostic disable-next-line: need-check-nil
      timer:start(50, 0, vim.schedule_wrap(function()
        vim.opt_local.cmdheight = 0
      end))
    end,
  })

  -- Remove hl search when move or enter insert: =================================================
  local clear_hl = vim.api.nvim_create_augroup('hl_clear', { clear = true })
  Config.new_autocmd('ModeChanged', {
    pattern = '*',
    group = clear_hl,
    callback = function()
      local mode = vim.fn.mode()
      if mode:match('i') then
        vim.opt.hlsearch = false
      else
        vim.opt.hlsearch = true
      end
    end,
  })
  Config.new_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
    group = clear_hl,
    callback = vim.schedule_wrap(function()
      vim.cmd.nohlsearch()
    end),
  })
  Config.new_autocmd('CursorMoved', {
    group = clear_hl,
    callback = function()
      if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
        vim.schedule(function()
          vim.cmd.nohlsearch()
        end)
      end
    end,
  })

  -- Trim space and lastlines if empty : =========================================================
  local trim_spaces = vim.api.nvim_create_augroup('trim_spaces', { clear = true })
  Config.new_autocmd('BufWritePre', {
    group = trim_spaces,
    pattern = { '*' },
    callback = function()
      local curpos = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[keeppatterns %s/\s\+$//e]])
      vim.api.nvim_win_set_cursor(0, curpos)
    end,
  })
  Config.new_autocmd('BufWritePre', {
    group = trim_spaces,
    pattern = { '*' },
    callback = function()
      local n_lines = vim.api.nvim_buf_line_count(0)
      local last_nonblank = vim.fn.prevnonblank(n_lines)
      if last_nonblank < n_lines then vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {}) end
    end,
  })

  -- Opts in command window: =====================================================================
  Config.new_autocmd('CmdwinEnter', {
    group = vim.api.nvim_create_augroup('cmd_open', { clear = true }),
    callback = function()
      vim.wo.number = false
      vim.wo.foldcolumn = '0'
      vim.wo.signcolumn = 'no'
    end,
  })

  -- Auto start insert when opening or focusing a terminal: ======================================
  Config.new_autocmd('BufEnter', {
    pattern = 'term://*',
    group = vim.api.nvim_create_augroup('term_focus', { clear = true }),
    callback = function()
      if vim.bo.buftype == 'terminal' then
        vim.cmd.startinsert()
      end
    end,
  })

  -- Opts in terminal buffer: ====================================================================
  Config.new_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('term_open', { clear = true }),
    callback = function()
      vim.opt_local.scrollback = 10000
      vim.opt_local.scrolloff = 0
      vim.opt_local.buflisted = false
      vim.opt_local.cursorline = false
      vim.opt_local.number = false
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.filetype = 'terminal'
      vim.bo.filetype = 'terminal'
      vim.bo.bufhidden = 'wipe'
      vim.cmd.startinsert()
    end,
  })

  -- Auto-close terminal when process exits: =====================================================
  Config.new_autocmd('TermClose', {
    group = vim.api.nvim_create_augroup('term_close', {}),
    callback = function()
      if vim.v.event.status == 0 then
        vim.api.nvim_buf_delete(0, {})
      end
    end,
  })
  Config.new_autocmd('TermClose', {
    group = vim.api.nvim_create_augroup('term_close', {}),
    pattern = { 'term://*', 'term:lazygit' },
    callback = function()
      vim.api.nvim_input('<CR>')
    end,
  })

  -- Auto create dir when saving a file, in case some intermediate directory does not exist: =====
  Config.new_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('auto_create_dir', {}),
    callback = function(event)
      if event.match:match('^%w%w+:[\\/][\\/]') then return end
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
  })

  -- Go to old position when opening a buffer: ===================================================
  Config.new_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('remember_position', { clear = true }),
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
        vim.schedule(function()
          vim.cmd('normal! zz')
        end)
      end
    end,
  })

  -- Highlight cursor line briefly when neovim regains focus: ====================================
  Config.new_autocmd({ 'FocusGained' }, {
    group = vim.api.nvim_create_augroup('track_cursor', { clear = true }),
    callback = function()
      vim.o.cursorline = false
      vim.cmd('redraw')
      vim.defer_fn(function()
        vim.o.cursorline = true
        vim.cmd('redraw')
      end, 300)
    end,
  })

  -- Show cursor line only in active window: =====================================================
  Config.new_autocmd({ 'BufWinEnter', 'WinEnter', 'WinLeave' }, {
    group = vim.api.nvim_create_augroup('auto_show_cursorline', { clear = true }),
    callback = function(ctx)
      if vim.bo[ctx.buf].buftype ~= '' then return end
      vim.opt_local.cursorline = ctx.event ~= 'WinLeave'
    end,
  })

  -- Check if we need to reload the file when it changed: ========================================
  Config.new_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = vim.api.nvim_create_augroup('checktime', { clear = true }),
    callback = function()
      local regex = vim.regex([[\(c\|r.?\|!\|t\)]])
      local mode = vim.api.nvim_get_mode()['mode']
      if (not regex:match_str(mode)) and vim.fn.getcmdwintype() == '' then
        vim.cmd('checktime')
      end
    end,
  })

  -- Notify when file is reloaded: ===============================================================
  Config.new_autocmd('FileChangedShellPost', {
    group = vim.api.nvim_create_augroup('reload_notify', { clear = true }),
    callback = function()
      vim.notify('File changed on disk. Buffer reloaded!', vim.log.levels.WARN)
    end,
  })

  -- Always open quickfix window automatically: ==================================================
  Config.new_autocmd('QuickFixCmdPost', {
    group = vim.api.nvim_create_augroup('auto_open_quickfix', { clear = true }),
    pattern = '[^l]*',
    command = 'cwindow',
    nested = true,
  })

  -- Always open loclist window automatically: ===================================================
  Config.new_autocmd('QuickFixCmdPost', {
    group = vim.api.nvim_create_augroup('auto_open_localist', { clear = true }),
    pattern = 'l*',
    command = 'lwindow',
    nested = true,
  })

  -- Clear jump list at start:====================================================================
  Config.new_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('clear_jumps', { clear = true }),
    callback = function()
      vim.cmd.clearjumps()
    end,
  })

  -- close some filetypes with <q>: ==============================================================
  Config.new_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('q_close', { clear = true }),
    pattern = { 'qf', 'man', 'help', 'query', 'notify', 'lspinfo', 'startuptime', 'git', 'checkhealth' },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      local close_buffer = vim.schedule_wrap(function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end)
      ---@type vim.keymap.set.Opts
      local keymap_opts = { buffer = event.buf, silent = true, desc = 'Close buffer', nowait = true }
      vim.keymap.set('n', 'q', close_buffer, keymap_opts)
    end,
  })

  -- Create an autocmd group for executing files: ================================================
  local exec_by_ft = vim.api.nvim_create_augroup('exec_by_ft', { clear = true })
  local function RunKeymap(filetype, command)
    Config.new_autocmd('FileType', {
      group = exec_by_ft,
      pattern = filetype,
      callback = function()
        vim.api.nvim_buf_set_keymap(
          0,
          'n',
          '<leader>aa',
          ':w<cr>:split term://' .. command .. ' %<cr>:resize 10<cr>',
          { noremap = true, silent = true }
        )
      end,
    })
  end

  -- Define the commands for each filetype: ======================================================
  RunKeymap('lua', 'lua')
  RunKeymap('python', 'python3')
  RunKeymap('javascript', 'node')
  RunKeymap('rust', 'cargo run')
  RunKeymap('go', 'go run')
  RunKeymap('cpp', 'g++ % -o %:r && ./%:r')
  RunKeymap('c', 'gcc % -o %:r && ./%:r')
end)
