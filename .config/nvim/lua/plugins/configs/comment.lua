local ok, comment = pcall(require, "Comment")
if not ok then
	return
end

comment.setup({
	toggler = {
		line = "<Leader>c",
		block = "<Leader>b",
	},
	opleader = {
		line = "<Leader>c",
		block = "<Leader>b",
	},
})
