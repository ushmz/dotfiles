local M = {}

---Explain the code in the current buffer.
---This is designed to overwrite the default CopilotChatExplain prompt.
M.Explain = {
	prompt = "/COPILOT_EXPLAIN 選択したコードの説明を段落をつけて書いてください。",
}

---Review the code in the current buffer.
---This is designed to overwrite the default CopilotChatReview prompt.
M.Review = {
	prompt = "/COPILOT_REVIEW このコードをレビューしてください。コードの品質、パフォーマンス、セキュリティ、可読性、およびバグについてコメントしてください。",
}

---Fix the code in the current buffer.
---This is designed to overwrite the default CopilotChatFix prompt.
M.Fix = {
	prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。",
}

---Optimize the code in the current buffer.
---This is designed to overwrite the default CopilotChatOptimize prompt.
M.Optimize = {
	prompt = "/COPILOT_OPTIMIZE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
}

---Document the code in the current buffer.
---This is designed to overwrite the default CopilotChatDocs prompt.
M.Docs = {
	prompt = "/COPILOT_DOCS 選択したコードのドキュメントを日本語で書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）",
}

---Generate tests for the code in the current buffer.
---This is designed to overwrite the default CopilotChatTests prompt.
M.Tests = {
	prompt = "/COPILOT_TESTS 選択したコードの詳細な単体テスト関数を書いてください。",
}

---Fix the diagnostic message under the cursor.
---This is designed to overwrite the default CopilotChatFixDiagnostic prompt.
M.FixDiagnostic = {
	prompt = "/COPILOT_FIXDIAGNOSTIC ファイル内の次のような静的解析の問題を解決してください：",
}

---Commit the changes in the repository.
---This is designed to overwrite the default CopilotChatCommit prompt.
M.Commit = {
	prompt = "/COPILOT_COMMIT この変更をコミットしてください。",
}

---Commit the staged changes in the repository.
---This is designed to overwrite the default CopilotChatCommitStaged prompt.
M.CommitStaged = {
	prompt = "/COPILOT_COMMITSTAGED ステージされている内容についてCommitizenの規約に従ったコミットメッセージを書いてください",
	selection = function(source)
		local select = require("copilot-chat.select")
		return select.gitdiff(source, true)
	end,
}

---Explain the selected code.
M.explain_visual = {
	prompt = "/COPILOT_EXPLAIN 選択したコードの説明を段落をつけて書いてください。",
	selection = function(source)
		local select = require("CopilotChat.select")
		return select.visual(source)
	end,
	mapping = "<C-g>cv",
}

---Review the selected code.
M.rename = {
	prompt = "/COPILOT_FIX 選択した関数の名前を変更してください。処理の内容が伝わりやすく、平易な英単語の組み合わせで構成してください。変更の必要性がない場合はその旨を回答してください。",
	selection = function(source)
		local select = require("CopilotChat.select")
		return select.visual(source)
	end,
	mapping = "<C-g>cr",
}

return M
