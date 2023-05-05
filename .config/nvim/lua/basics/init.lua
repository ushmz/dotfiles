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

vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spec = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.load_black = 1
vim.g.loaded_fzf = 1
vim.g.loaded_gtags = 1
vim.g.loaded_gtags_cscope = 1

vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.api.nvim_set_var("netrw_home", home .. ".local/state/vim")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.guifont = "Hack Nerd Font:h14:w2"

vim.opt.secure = true
vim.wo.number = true
vim.opt.ruler = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.undodir = home .. "/.cache/nvim/undo"
vim.opt.swapfile = false
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.background = "dark"
-- vim.opt.inccommand='split'
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.textwidth = 0
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/__pycache__/*", "*.pyc", "*/node_modules/*", "*.DS_Store" })
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = { 100 }
vim.opt.lazyredraw = true
-- vim.opt.ttyfast = true

-- vim.opt.ambiwidth = 'double'
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.conceallevel = 0
vim.opt.emoji = true
vim.opt.matchpairs = "(:),{:},[:],<:>"
vim.opt.modelines = 0
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest,full"

-- highlight
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.pumblend = 10
vim.opt.wildmenu = true
vim.opt.wildoptions = "pum"
vim.opt.wildmode = "list:longest,full"

vim.opt.report = 0

if vim.fn.executable("rg") then
	vim.opt.grepprg = "rg --no-heading --vimgrep"
end
