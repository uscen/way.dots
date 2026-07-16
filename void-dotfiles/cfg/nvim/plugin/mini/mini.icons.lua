-- ============================================================================== #
-- Icons:                                                                         #
-- ============================================================================== #
Config.now(function()
  local MiniIcons = require('mini.icons')
  MiniIcons.setup({
    use_file_extension = function(ext, _)
      local suf3, suf4 = ext:sub(-3), ext:sub(-4)
      return suf3 ~= 'scm' and suf3 ~= 'txt' and suf3 ~= 'yml' and suf4 ~= 'json' and suf4 ~= 'yaml'
    end,
    -- Default: ==================================================================================
    default = {
      ['file'] = { glyph = '󰪷', hl = 'MiniIconsYellow' },
      ['filetype'] = { glyph = '󰪷', hl = 'MiniIconsYellow' },
      ['extension'] = { glyph = '󰪷', hl = 'MiniIconsYellow' },
    },

    -- Files: ====================================================================================
    file = {
      ['init.lua'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['README.md'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['pre-commit'] = { glyph = '󰊢', hl = 'MiniIconsYellow' },
      ['Brewfile'] = { glyph = '󱄖', hl = 'MiniIconsYellow' },
      ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
      ['.ignore'] = { glyph = '󰈉', hl = 'MiniIconsGrey' },
      ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
      ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
      ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['.gitignore'] = { glyph = '', hl = 'MiniIconsRed' },
      ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['.dockerignore'] = { glyph = '󰡨', hl = 'MiniIconsBlue' },
      ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
      ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['vite.config.ts'] = { glyph = '', hl = 'MiniIconsYellow' },
      ['pnpm-lock.yaml'] = { glyph = '', hl = 'MiniIconsYellow' },
      ['pnpm-workspace.yaml'] = { glyph = '', hl = 'MiniIconsYellow' },
      ['react-router.config.ts'] = { glyph = '', hl = 'MiniIconsRed' },
      ['bun.lockb'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['bun.lock'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    },

    -- Filetypes: ================================================================================
    filetype = {
      ['lua'] = { glyph = '󰢱', hl = 'MiniIconsBlue' },
      ['css'] = { glyph = '', hl = 'MiniIconsCyan' },
      ['vim'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['sh'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['elvish'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['bash'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['dotenv'] = { glyph = '', hl = 'MiniIconsYellow' },
      ['gotmpl'] = { glyph = '󰟓', hl = 'MiniIconsGrey' },
    },

    -- Extension: ================================================================================
    extension = {
      ['d.ts'] = { glyph = '', hl = 'MiniIconsRed' },
      ['applescript'] = { glyph = '󰀵', hl = 'MiniIconsGrey' },
      ['log'] = { glyph = '󱂅', hl = 'MiniIconsGrey' },
      ['gitignore'] = { glyph = '', hl = 'MiniIconsRed' },
      ['adblock'] = { glyph = '', hl = 'MiniIconsRed' },
      ['add'] = { glyph = '', hl = 'MiniIconsGreen' },
    },

    -- Directory: ================================================================================
    directory = {
      ['.vscode'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['app'] = { glyph = '󰀻', hl = 'MiniIconsRed' },
      ['routes'] = { glyph = '󰑪', hl = 'MiniIconsGreen' },
      ['config'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['configs'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['server'] = { glyph = '󰒋', hl = 'MiniIconsCyan' },
      ['api'] = { glyph = '󰒋', hl = 'MiniIconsCyan' },
      ['web'] = { glyph = '󰖟', hl = 'MiniIconsBlue' },
      ['client'] = { glyph = '󰖟', hl = 'MiniIconsBlue' },
      ['database'] = { glyph = '󰆼', hl = 'MiniIconsOrange' },
      ['db'] = { glyph = '󰆼', hl = 'MiniIconsOrange' },
      ['cspell'] = { glyph = '󰓆', hl = 'MiniIconsPurple' },
    },

    -- Lsp: ================================================================================
    lsp = {
      ['text'] = { glyph = '' },
      ['method'] = { glyph = '󰆦' },
      ['function'] = { glyph = '󰊕' },
      ['constructor'] = { glyph = '' },
      ['field'] = { glyph = '󰇽' },
      ['variable'] = { glyph = '' },
      ['boolean'] = { glyph = '◩' },
      ['class'] = { glyph = '󰠱' },
      ['interface'] = { glyph = '' },
      ['module'] = { glyph = '' },
      ['property'] = { glyph = '󰜢' },
      ['unit'] = { glyph = '󰪚' },
      ['value'] = { glyph = '󰔌' },
      ['enum'] = { glyph = '' },
      ['keyword'] = { glyph = '󰌆' },
      ['snippet'] = { glyph = '󰬚' },
      ['color'] = { glyph = '󰏘' },
      ['file'] = { glyph = '󰈙' },
      ['reference'] = { glyph = '󰬲' },
      ['folder'] = { glyph = '󰉋' },
      ['enumMember'] = { glyph = '' },
      ['constant'] = { glyph = '󰐀' },
      ['struct'] = { glyph = '' },
      ['event'] = { glyph = '' },
      ['operator'] = { glyph = '󰙴' },
      ['typeParameter'] = { glyph = '󰬛' },
    },
  })
  Config.later(MiniIcons.mock_nvim_web_devicons)
  Config.later(MiniIcons.tweak_lsp_kind)
end)
