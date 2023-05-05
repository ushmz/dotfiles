local g = vim.g
local o = vim.opt
local home = vim.env.HOME

o.termguicolors = true
vim.cmd([[let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum']]) -- foreground
vim.cmd([[let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum']]) -- background
vim.cmd([[let &t_Cs = '\e[4:3m']])
vim.cmd([[let &t_Ce = '\e[4:0m']])

vim.cmd("filetype plugin indent on")
vim.cmd("set mouse=")
vim.cmd("set fo-=co")
vim.cmd("set fo+=rqnM1j")

vim.api.nvim_set_var("netrw_home", home .. ".local/state/vim")

g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logiPat = 1
g.loaded_man = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_remote_plugins = 1
g.loaded_rplugin = 1
g.loaded_rrhelper = 1
g.loaded_shada_plugin = 1
g.loaded_shada_plugin = 1
g.loaded_spec = 1
g.loaded_spellfile_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1

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
o.updatetime = 300
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
o.cursorline = true
o.winblend = 0
o.pumblend = 10
o.wildmenu = true
o.wildoptions = "pum"
o.wildmode = "list:longest,full"

o.report = 0

if vim.fn.executable("rg") then
	o.grepprg = "rg --no-heading --vimgrep"
end
