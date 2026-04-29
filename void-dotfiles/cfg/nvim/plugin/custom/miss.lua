-- ============================================================================== #
-- Misspelled:                                                                    #
-- ============================================================================== #
local misspelled_commands = { 'W', 'Wq', 'WQ', 'Q', 'Qa', 'QA', 'Qall', 'QAll', 'Wqa', 'WQa', 'WQA', 'Set', 'SEt', 'SET', 'Bd' }
for _, command in pairs(misspelled_commands) do
  vim.api.nvim_create_user_command(command, function()
    vim.cmd(string.lower(command))
  end, { bang = true })
end
