-- ============================================================================== #
-- Treesitter:                                                                    #
-- ============================================================================== #
Config.now_if_args(function()
  local ts_update = function() vim.cmd('TSUpdate') end
  Config.on_packchanged('tree-sitter', { 'update' }, ts_udpate, 'Update tree-sitter parsers')
  vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main', load = true },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  })
  local ensure_languages = {
    'html',
    'css',
    'markdown',
    'javascript',
    'typescript',
    'prisma',
    'tsx',
    'json',
    'toml',
    'yaml',
    'jq',
    'lua',
  }
  require('nvim-treesitter').install(ensure_languages)
  local filetypes = vim.iter(ensure_languages):map(vim.treesitter.language.get_filetypes):flatten():totable()
  vim.list_extend(filetypes, { 'markdown', 'pandoc' })
  Config.new_autocmd('FileType', { pattern = filetypes, callback = function(ev) vim.treesitter.start(ev.buf) end })
end)
