local ok, colorizer = pcall(require, "colorizer")
if not ok then
	return
end

colorizer.setup({
	"*",
	css = { css = true, RRGGBBAA = true },
	html = { names = false },
})
