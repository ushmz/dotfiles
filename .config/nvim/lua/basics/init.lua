local g = vim.g
local o = vim.opt
local home = vim.env.HOME

o.termguicolors = true

vim.cmd("filetype plugin indent on")
vim.cmd("set mouse=")
vim.cmd("set fo-=co")
vim.cmd("set fo+=rqnM1j")

vim.api.nvim_set_var("netrw_home", home .. ".local/state/vim")

g.load_black = 1
g.loaded_fzf = 1
g.loaded_gtags = 1
g.loaded_gtags_cscope = 1
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

vim.scriptencoding = "utf-8"
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.guifont = "FiraCode Nerd Font:h14:w2"
o.secure = true
o.number = true
o.ruler = true
o.title = true
o.autoindent = true
o.smartindent = true
o.hlsearch = true
o.backup = false
o.writebackup = false
o.undofile = true
o.undodir = home .. "/.cache/nvim/undo"
o.swapfile = false
o.backupskip = { "/tmp/*", "/private/tmp/*" }
o.showcmd = true
o.cmdheight = 1
o.laststatus = 3
o.expandtab = true
o.scrolloff = 10
o.shell = "zsh"
o.background = "dark"
-- o.inccommand='split'
o.ignorecase = true
o.smarttab = true
o.breakindent = true
o.textwidth = 0
o.shiftwidth = 4
o.shiftround = true
o.tabstop = 4
o.softtabstop = 4
o.wrap = false
o.backspace = { "start", "eol", "indent" }
o.path:append({ "**" })
o.wildignore:append({ "*/__pycache__/*", "*.pyc", "*/node_modules/*", "*.DS_Store" })
o.updatetime = 200
o.signcolumn = "yes"
o.colorcolumn = { 100 }
o.lazyredraw = true
-- o.ttyfast = true
-- o.ambiwidth = 'double'

o.completeopt = "menuone,noinsert,noselect"
o.conceallevel = 0
o.emoji = true
o.matchpairs = "(:),{:},[:],<:>"
o.modelines = 0
o.smartcase = true
o.splitright = true
o.virtualedit = "block"
o.wildmode = "longest,full"

-- highlight
o.cursorline = false
o.winblend = 0
o.pumblend = 10
o.wildmenu = true
o.wildoptions = "pum"
o.wildmode = "list:longest,full"

o.report = 0

if vim.fn.executable("rg") then
	o.grepprg = "rg --no-heading --vimgrep"
end

-- Create missing directories when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		local dir = vim.fn.expand("<afile>:p:h")

		if dir:find("%l+://") == 1 then
			return
		end

		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})
