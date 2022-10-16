local home = vim.env.HOME
local state = vim.env.XDG_STATE_HOME

vim.cmd([[let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum']])
vim.cmd([[let &t_8b = '\<Esc>[48;2;%lu;%lu;%lum']])
vim.cmd([[let &t_Cs = '\e[4:3m']])
vim.cmd([[let &t_Ce = '\e[4:0m']])

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.cmd('set mouse=')

vim.api.nvim_set_var('netrw_home', state .. '/vim')

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.guifont = 'Hack Nerd Font:h14:w2'

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
vim.opt.undodir = home .. '/.cache/nvim/undo'
vim.opt.swapfile = false
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'zsh'
vim.opt.background = 'dark'
-- vim.ot.backupskip='/tmp/*,/private/tmp/*'
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
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*/__pycache__/*', '*.pyc', '*/node_modules/*', '*.DS_Store' }
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'

-- vim.opt.ambiwidth = 'double'
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.conceallevel = 0
vim.opt.emoji = true
vim.opt.matchpairs = '(:),{:},[:],<:>'
vim.opt.modelines = 0
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.virtualedit = 'block'
vim.opt.wildmode = 'longest,full'

-- highlight
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.pumblend = 10
vim.opt.wildmenu = true
vim.opt.wildoptions = 'pum'
vim.opt.wildmode = 'list:longest,full'

vim.opt.report = 0
