local M = {}

M.show_actions = function()
	local actions = require("CopilotChat.actions")
	require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

return M
