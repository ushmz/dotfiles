local prompts = require("plugins.configs.copilot-chat.prompts")

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		opts = {
			show_help = "yes",
			debug = false,
			disable_extra_info = "no",
			proxy = nil, -- Proxies requests via https or socks.
			allow_insecure = false,
			language = "ja",
			temperature = 0.1,
			prompts = {
				Explain = prompts.Explain,
				Review = prompts.Review,
				Fix = prompts.Fix,
				Optimize = prompts.Optimize,
				Docs = prompts.Docs,
				Tests = prompts.Tests,
				FixDiagnostic = prompts.FixDiagnostic,
				Commit = prompts.Commit,
				CommitStaged = prompts.CommitStaged,
				Rename = prompts.rename,
				ExplainVisual = prompts.explain_visual,
			},
		},
		build = "make tiktoken",
		dependencies = {
			-- { "github/copilot.vim" },
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		event = "VeryLazy",
		keys = {
			{ "<C-g><C-g>", "<cmd>CopilotChat<cr>", desc = "CopilotChat - Chat with Copilot" },
			{ "<C-g>cb", "<cmd>CopilotChatBuffer<cr>", desc = "CopilotChat - Chat with current buffer" },
			{ "<C-g>ce", "<cmd>CopilotChatExplain<cr>", mode = { "n" }, desc = "CopilotChat - Explain code" },
			{ "<C-g>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
			{ "<C-g>cT", "<cmd>CopilotChatVsplitToggle<cr>", desc = "CopilotChat - Toggle Vsplit" }, -- Toggle vertical split
			{ "<C-g>cv", "<cmd>CopilotChatVisual<cr>", mode = { "x" }, desc = "CopilotChat - Open in vertical split" },
			{ "<C-g>cx", "<cmd>CopilotChatInPlace<cr>", mode = { "x" }, desc = "CopilotChat - Run in-place code" },
			{ "<C-g>cf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix diagnostic" }, -- Get a fix for the diagnostic message under the cursor.
			{
				"<C-g>cp",
				function()
					require("plugins.configs.copilot-chat.actions").show_actions()
				end,
				mode = { "n", "x" },
				desc = "CopilotChat - Show actions",
			},
		},
	},
}
