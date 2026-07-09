local pickers = require("plugins.configs.telescope.pickers")

local function load_neoconf()
  local ok, neoconf = pcall(require, "neoconf")
  if not ok then
    return {}
  end

  local ok_get, defaults = pcall(neoconf.get, "telescope.defaults")
  if not ok_get then
    return {}
  end

  return defaults or {}
end

local function config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local fb_actions = require("telescope").extensions.file_browser.actions
  local preview_maker = require("plugins.configs.telescope.preview_maker")
  local egrep_actions = require("telescope._extensions.egrepify.actions")

  local local_conf = load_neoconf()
  local trouble = require("trouble.sources.telescope")

  telescope.setup({
    defaults = vim.tbl_extend("force", {
      sorting_strategy = "ascending",
      selection_strategy = "closest",
      scroll_strategy = "cycle",
      layout_strategy = "flex",
      buffer_previewer_maker = preview_maker.create(100000),
      mappings = {
        i = {
          ["<C-o>"] = trouble.open,
        },
        n = {
          ["q"] = actions.close,
          ["<C-o>"] = trouble.open,
        },
      },
      file_ignore_patterns = {
        ".DS_Store",
        "*.pyc",
        ".cargo/",
        -- ".git/",
        ".npm/",
        ".ssh/",
        "node_modules/",
        "site_packages/",
        "__pycache__/",
      },
    }, local_conf),
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      },
      git_files = {
        git_command = { "git", "ls-files", "--exclude-standard", "--cached", "--others" },
      },
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
        hijack_netrw = true,
        git_status = false,
        mappings = {
          ["i"] = {
            -- ["<C-a>"] = function()
            -- 	vim.cmd("normal 0")
            -- end,
            ["<C-w>"] = function()
              vim.cmd("normal vbd")
            end,
          },
          ["n"] = {
            ["h"] = fb_actions.goto_parent_dir,
            ["H"] = fb_actions.toggle_hidden,
            ["N"] = fb_actions.create,
            ["r"] = fb_actions.rename,
            ["D"] = fb_actions.remove,
            ["/"] = function()
              vim.cmd("startinsert")
            end,
          },
        },
      },
      egrepify = {
        AND = true,
        permutations = true,
        lnum = true,
        lnum_hl = "EgrepifyLnum",
        col = true,
        col_hl = "EgrepifyCol",
        title = true,
        filename_hl = "Normal",
        directory_hl = "Directory",
        prefixes = {
          ["!"] = {
            flag = "invert-match",
          },
        },
        mappings = {
          i = {
            -- To override the default mappings
            ["<C-a>"] = function()
              vim.cmd("normal 0")
            end,
            ["<C-z>"] = egrep_actions.toggle_prefixes,
            -- [""] = egrep_actions.toggle_and,
            ["<C-r>"] = egrep_actions.toggle_permutations,
          },
        },
      },
    },
  })

  require("plugins.configs.telescope.hl").set()
end

return {
  "nvim-telescope/telescope.nvim",
  pin = true,
  commit = "cfb85dcf7f822b79224e9e6aef9e8c794211b20b",
  cmd = { "Telescope" },
  dependencies = {
    { "nvim-lua/plenary.nvim", pin = true, commit = "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },
    { "nvim-telescope/telescope-fzf-native.nvim", pin = true, commit = "b25b749b9db64d375d782094e2b9dce53ad53a40", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim", pin = true, commit = "3610dc7dc91f06aa98b11dca5cc30dfa98626b7e" },
    -- { "fdschmidt93/telescope-egrepify.nvim" },
    { "ushmz/telescope-egrepify.nvim", pin = true, commit = "e486598389308131008715d064708531368919f5" },
  },
  keys = {
    { "<leader><leader>", pickers.resume, mode = "n", desc = "Telescope: Resume latest search" },
    { "<leader>b", pickers.buffers, mode = "n", desc = "Telescope: Search [B]uffers" },
    { "<leader>c", pickers.commands, mode = "n", desc = "Telescope: Search [C]ommands" },
    { "<leader>d", pickers.file_browser, mode = "n", desc = "Telescope: [D]irectory & File Browser" },
    { "<leader>e", pickers.diagnostics, mode = "n", desc = "Telescope: Search diagnostics ([E]rrors)" },
    { "<leader>f", pickers.find_files, mode = "n", desc = "Telescope: Search [F]iles" },
    { "<leader>G", pickers.live_grep, mode = "n", desc = "Telescope: Live [G]rep" },
    { "<leader>g", pickers.egrepify, mode = "n", desc = "Telescope: Search with e[G]repify" },
    { "<leader>h", pickers.help_tags, mode = "n", desc = "Telescope: Search [H]elps" },
    { "<leader>k", pickers.keymaps, mode = "n", desc = "Telescope: Search [K]eymaps" },
    { "<leader>sc", pickers.grep_string, mode = "n", desc = "Telescope: Search word under the [C]ursor" },
    {
      "<leader>si",
      function()
        pickers.grep_string(vim.fn.input("Search: "))
      end,
      mode = "n",
      desc = "Telescope: Search word from [I]nput",
    },
    { "<leader>o", pickers.oldfiles, mode = "n", desc = "Telescope: Search [O]ldfiles" },
    {
      "<leader>/",
      pickers.current_buffer_fuzzy_find,
      mode = "n",
      desc = "Telescope: Fuzzily search in current buffer",
    },
    { "<leader>sd", pickers.document_symbols, mode = "n", desc = "Telescope: [S]ymbols in [D]ocument" },
    { "<leader>sw", pickers.workspace_symbols, mode = "n", desc = "Telescope: [S]ymbols in [W]orkspace" },
    { "gi", pickers.implementations, mode = "n", desc = "LSP: [G]oto [I]mplementations" },
    { "gr", pickers.references, mode = "n", desc = "LSP: [G]oto [R]eferences" },
    { "gt", pickers.type_definitions, mode = "n", desc = "LSP: [G]oto [T]ype definitions" },
  },
  config = config,
}
