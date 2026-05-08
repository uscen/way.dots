-- ============================================================================== #
-- Git:                                                                           #
-- ============================================================================== #
Config.later(function()
  local MiniGit = require('mini.git')
  local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s\%d\ [\%an] --graph --all]]
  MiniGit.setup({ command = { split = 'tab' } })
  Config.minigit_log = function() vim.cmd(git_log_cmd) end
  Config.minigit_log_buf = function() vim.cmd(git_log_cmd .. ' --follow -- %') end
end)
