-- ============================================================================== #
-- Misc:                                                                          #
-- ============================================================================== #
Config.later(function()
  local M = {}
  -- Open url in buffer: ===========================================================================
  function M.openUrl()
    local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
    local urls = {}
    for url in text:gmatch([[%l%l%l+://[^%s)%]}"'`>]+]]) do
      urls[#urls + 1] = url
    end
    if #urls == 0 then
      return vim.notify('No URL found in file.', vim.log.levels.WARN)
    elseif #urls == 1 then
      return vim.ui.open(urls[1])
    end
    vim.ui.select(urls, { prompt = ' Open URL:' }, function(url)
      if url then vim.ui.open(url) end
    end)
  end

  vim.api.nvim_create_user_command('OpenUrl', M.openUrl, {})

  -- Toggle word: ==================================================================================
  function M.smartWord()
    local toggles = {
      ['True'] = 'False',
      ['true'] = 'false',
      ['yes'] = 'no',
      ['on'] = 'off',
      ['enable'] = 'disable',
      ['enabled'] = 'disabled',
      ['active'] = 'inactive',
      ['visible'] = 'hidden',
      ['success'] = 'error',
      ['always'] = 'never',
      ['allow'] = 'deny',
      ['show'] = 'hide',
      ['let'] = 'const',

      ['up'] = 'down',
      ['top'] = 'bottom',
      ['light'] = 'dark',
      ['right'] = 'left',
      ['width'] = 'height',
      ['relative'] = 'absolute',

      ['min'] = 'max',
      ['next'] = 'previous',
      ['before'] = 'after',
      ['above'] = 'below',
      ['start'] = 'end',
      ['backward'] = 'forward',
      ['open'] = 'close',
      ['inner'] = 'outer',
      ['encode'] = 'decode',
      ['input'] = 'output',

      ['and'] = 'or',
      ['=='] = '!=',
      ['>'] = '<',
      ['>='] = '<=',
      ['||'] = '&&',
    }
    local cword = vim.fn.expand('<cword>')
    local newWord
    for word, opposite in pairs(toggles) do
      if cword == word then newWord = opposite end
      if cword == opposite then newWord = word end
    end
    if newWord then
      local prevCursor = vim.api.nvim_win_get_cursor(0)
      vim.cmd.normal { '"_ciw' .. newWord, bang = true }
      vim.api.nvim_win_set_cursor(0, prevCursor)
    end
  end

  vim.api.nvim_create_user_command('SmartWord', M.smartWord, {})

  -- Smart duplicate line: =========================================================================
  function M.smartDuplicate()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local ft = vim.bo.filetype
    -- FILETYPE-SPECIFIC TWEAKS
    if ft == 'css' then
      local newLine = line
      if line:find('top:') then newLine = line:gsub('top:', 'bottom:') end
      if line:find('bottom:') then newLine = line:gsub('bottom:', 'top:') end
      if line:find('right:') then newLine = line:gsub('right:', 'left:') end
      if line:find('left:') then newLine = line:gsub('left:', 'right:') end
      if line:find('height:') then newLine = line:gsub('height:', 'width:') end
      if line:find('width:') then newLine = line:gsub('width:', 'height:') end
      line = newLine
    elseif ft == 'javascript' or ft == 'typescript' or ft == 'swift' then
      line = line:gsub('^(%s*)if(.+{)$', '%1} else if%2')
    elseif ft == 'lua' then
      line = line:gsub('^(%s*)if( .* then)$', '%1elseif%2')
    elseif ft == 'zsh' or ft == 'bash' then
      line = line:gsub('^(%s*)if( .* then)$', '%1elif%2')
    elseif ft == 'python' then
      line = line:gsub('^(%s*)if( .*:)$', '%1elif%2')
    end
    -- INSERT DUPLICATED LINE
    vim.api.nvim_buf_set_lines(0, row, row, false, { line })
    -- MOVE CURSOR DOWN, AND TO VALUE/FIELD (IF THERE IS ANY)
    local _, luadocFieldPos = line:find('%-%-%-@%w+ ')
    local _, valuePos = line:find('[:=] ')
    local targetCol = luadocFieldPos or valuePos or col
    vim.api.nvim_win_set_cursor(0, { row + 1, targetCol })
  end

  vim.api.nvim_create_user_command('SmartDuplicate', M.smartDuplicate, {})

  -- Delete buff: ==================================================================================
  M.delete_buffer = function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local normal_wins = {}
    for _, win in ipairs(wins) do
      if vim.api.nvim_win_get_config(win).relative == '' then
        table.insert(normal_wins, win)
      end
    end
    local buflist = vim.fn.getbufinfo({ buflisted = 1 })
    if #buflist <= 1 then
      -- Last buffer: Quit Neovim entirely
      vim.cmd('quit')
    elseif #normal_wins > 1 then
      local cur_buf = vim.api.nvim_get_current_buf()
      require('mini.bufremove').wipeout(cur_buf, true)
      vim.cmd('close')
    else
      -- Only one window left, but multiple buffers
      vim.cmd('bdelete')
    end
  end

  vim.api.nvim_create_user_command('DeleteBuffer', M.delete_buffer, {})

  -- Delete listed unmodified buffers that are not in a window: ==================================
  function M.deleteInactiveBuffers()
    local notify = false
    local number = 0
    for _, buf in ipairs(vim.fn.getbufinfo()) do
      if vim.tbl_isempty(buf.windows) and buf.listed == 1 and buf.changed == 0 then
        notify = true
        number = number + 1
        vim.cmd.bdelete({ buf.bufnr, bang = true })
      end
    end
    if notify then
      vim.notify('Deleted ' .. tostring(number) .. ' inactive buffer(s).', vim.log.levels.INFO)
    else
      vim.notify('No inactive buffers were deleted.', vim.log.levels.INFO)
    end
  end

  vim.api.nvim_create_user_command('DeleteInactiveBuffers', M.deleteInactiveBuffers, {})

  -- Delete others buffers: ======================================================================
  function M.deleteOthersBuffers()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= vim.fn.bufnr() and vim.fn.buflisted(buf) == 1 then
        require('mini.bufremove').wipeout(buf, true)
      end
    end
  end

  vim.api.nvim_create_user_command('DeleteOtherBuffers', M.deleteOthersBuffers, {})


  -- Surround: =====================================================================================
  function M.SurroundOrReplaceQuotes()
    local word = vim.fn.expand('<cword>')
    local row, old_pos = unpack(vim.api.nvim_win_get_cursor(0))
    vim.fn.search(word, 'bc', row)
    local _, word_pos = unpack(vim.api.nvim_win_get_cursor(0))
    local line_str = vim.api.nvim_get_current_line()
    local before_word = line_str:sub(0, word_pos)
    local pairs_count = 0
    for _ in before_word:gmatch('["\'`]') do
      pairs_count = pairs_count + 1
    end
    if pairs_count % 2 == 0 then
      vim.cmd('normal ysiw\'')
      vim.api.nvim_win_set_cursor(0, { row, old_pos + 1 })
      return
    end
    for i = #before_word, 1, -1 do
      local char = before_word:sub(i, i)
      if char == "'" then
        vim.cmd("normal cs'\"")
        vim.api.nvim_win_set_cursor(0, { row, old_pos })
        return
      end
      if char == '"' then
        vim.cmd('normal cs\"`')
        vim.api.nvim_win_set_cursor(0, { row, old_pos })
        return
      end
      if char == '`' then
        vim.cmd("normal cs`'")
        vim.api.nvim_win_set_cursor(0, { row, old_pos })
        return
      end
    end
  end

  vim.api.nvim_create_user_command('SurroundOrReplaceQuotes', M.SurroundOrReplaceQuotes, {})

  -- This is a simplified version of in-and-out.nvim: ==============================================
  -- https://github.com/ysmb-wtsg/in-and-out.nvim
  local function escape_lua_pattern(s)
    local matches = {
      ['^'] = '%^',
      ['$'] = '%$',
      ['('] = '%(',
      [')'] = '%)',
      ['%'] = '%%',
      ['.'] = '%.',
      ['['] = '%[',
      [']'] = '%]',
      ['*'] = '%*',
      ['+'] = '%+',
      ['-'] = '%-',
      ['?'] = '%?',
    }
    return s:gsub('.', matches)
  end
  local targets = { '"', "'", '(', ')', '{', '}', '[', ']', '`', '“', '”' }
  function M.leap()
    local line_nr, col_nr = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()

    local target_col_nr = nil
    for _, char in ipairs(targets) do
      local found_col_nr =
          string.find(line, escape_lua_pattern(char), col_nr + 1)
      if
          found_col_nr and (not target_col_nr or found_col_nr < target_col_nr)
      then
        -- If char is a multibyte character, we need to take into
        -- account the extra bytes.
        target_col_nr = found_col_nr + vim.fn.strlen(char) - 1
      end
    end

    if target_col_nr then
      vim.api.nvim_win_set_cursor(0, { line_nr, target_col_nr })
    end
  end

  vim.api.nvim_create_user_command('Leap', M.leap, {})

  -- go_to_relative_file: ==========================================================================
  function M.go_to_relative_file(n, relative_to)
    return function()
      local this_dir = vim.fs.dirname(vim.fs.normalize(vim.fn.expand('%:p')))
      local files = {}
      for file, type in vim.fs.dir(this_dir) do
        if type == 'file' then
          table.insert(files, file)
        end
      end
      local this_file = relative_to or vim.fs.basename(vim.fn.bufname())
      local this_file_pos = -1
      for i, file in ipairs(files) do
        if file == this_file then
          this_file_pos = i
        end
      end
      if this_file_pos == -1 then
        error(('File `%s` not found in current directory'):format(this_file))
      end
      local new_file = files[((this_file_pos + n - 1) % #files) + 1]
      if not new_file then
        error(('Could not find file relative to `%s`'):format(this_file))
      end
      vim.cmd('edit ' .. this_dir .. '/' .. new_file)
    end
  end

  vim.api.nvim_create_user_command('RelativeFileNext', M.go_to_relative_file(1), {})
  vim.api.nvim_create_user_command('RelativeFilePrev', M.go_to_relative_file(-1), {})

  -- go_to_relative_file: ==========================================================================
  function M.open_file_or_create_new()
    local path = vim.fn.expand('<cfile>')
    if path == nil or path == '' then return end
    local ok = pcall(function() vim.cmd.normal({ args = 'gf', bang = true }) end)
    if ok then return end
    local current_dir = vim.fn.expand('%:p:h')
    local new_path = vim.fn.fnamemodify(current_dir .. '/' .. path, ':p')
    -- If file already has extension → open immediately
    if vim.fn.fnamemodify(new_path, ':e') ~= '' then
      vim.cmd('edit ' .. new_path)
      return
    end
    -- Try suffixesadd
    local suffixes = vim.split(vim.o.suffixesadd, ',', { trimempty = true })
    for _, suf in ipairs(suffixes) do
      local candidate = new_path .. suf
      if vim.fn.filereadable(candidate) == 1 then
        vim.cmd('edit ' .. candidate)
        return
      end
    end
    -- Otherwise create file with the first suffix
    if #suffixes > 0 then
      vim.cmd('edit ' .. new_path .. suffixes[1])
    else
      -- If suffixesadd is empty, just edit the raw path
      vim.cmd('edit ' .. new_path)
    end
  end

  vim.api.nvim_create_user_command('OpenOrCreateFile', M.open_file_or_create_new, {})
end)
