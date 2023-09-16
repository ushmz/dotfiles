---Load and return package `cmp`
local function cmp()
	return require("cmp")
end

---Load and return package `lspkind`
local function lspkind()
	return require("lspkind")
end

---Load and return package `luasnip`
local function luasnip()
	return require("luasnip")
end

---Return there is a character just before the cursor or not
---@return boolean
local function has_words_before()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local lines = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)
	return cursor[2] ~= 0 and (lines[1] or ""):sub(cursor[2], cursor[2]):match("%s") == nil
end

---The handler on `Ctrl-n` key pressed
---@param fallback any
local function ctrl_n(fallback)
	if cmp().visible() then
		cmp().select_next_item({ behavior = "insert" })
	else
		fallback()
	end
end

---The handler on `Ctrl-p` key pressed
---@param fallback any
local function ctrl_p(fallback)
	if cmp().visible() then
		cmp().select_prev_item({ behavior = "insert" })
	else
		fallback()
	end
end

---The handler on `Tab` key pressed
---@param fallback any
local function tab(fallback)
	if cmp().visible() then
		cmp().select_next_item()
	elseif luasnip().expand_or_locally_jumpable() then
		luasnip().expand_or_jump()
	elseif has_words_before() then
		cmp().complete()
	else
		fallback()
	end
end

---The handler on `Shift-Tab` key pressed
---@param fallback any
local function shift_tab(fallback)
	if cmp().visible() then
		cmp().select_prev_item()
	elseif luasnip().jumpable(-1) then
		luasnip().jump(-1)
	else
		fallback()
	end
end

---Set completion menu format
---@param entry table
---@param vim_item table
---@return unknown
local function cmp_format(entry, vim_item)
	local kind = lspkind().cmp_format({
		mode = "symbol_text",
		maxwidth = 50,
		before = function(e, i)
			if i.kind == "Color" and e.completion_item.documentation then
				local _, _, r, g, b = string.find(e.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
				if r then
					local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
					local group = "Tw_" .. color
					if vim.fn.hlID(group) < 1 then
						vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
					end
					i.kind = "●"
					i.kind_hl_group = group
					return i
				end
			end
			i.kind = lspkind().symbolic(i.kind) and lspkind().symbolic(i.kind) or i.kind
			return i
		end,
	})(entry, vim_item)

	local strings = vim.split(kind.kind, "%s", { trimempty = true })
	kind.kind = " " .. (strings[1] or "") .. " "
	kind.menu = "    (" .. (strings[2] or "") .. ")"
	return kind
end

local function completion_config()
	local c = cmp()
	c.setup({
		snippet = {
			expand = function(args)
				luasnip().lsp_expand(args.body)
			end,
		},
		window = {
			completion = {
				side_padding = 0,
				border = "rounded",
			},
			documentation = c.config.window.bordered({ border = "rounded" }),
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = cmp_format,
		},
		mapping = c.mapping.preset.insert({
			["<Tab>"] = c.mapping(tab, { "i", "s", "c" }),
			["<S-Tab>"] = c.mapping(shift_tab, { "i", "s", "c" }),
			["<C-n>"] = c.mapping(ctrl_n, { "i", "s", "c" }),
			["<C-p>"] = c.mapping(ctrl_p, { "i", "s", "c" }),
			["<C-j>"] = c.mapping.scroll_docs(4),
			["<C-k>"] = c.mapping.scroll_docs(-4),
			["<CR>"] = c.mapping.confirm({ select = false }),
			["<C-CR>"] = c.mapping.close(),
		}),
		sources = c.config.sources({
			-- { name = "calc" },
			-- { name = "buffer" },
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			-- { name = "nvim_lsp_signature_help" },
		}),
	})

	c.setup.cmdline(":", {
		sources = c.config.sources({
			-- { name = "nvim_lsp_document_symbol" },
			{ name = "cmdline" },
		}),
	})

	c.setup.cmdline({ "/", "?" }, {
		sources = c.config.sources({
			{ name = "path" },
			{ name = "buffer" },
		}),
	})

	require("plugins.configs.cmp.hl").set()
end

local function lspkind_config()
	lspkind().init({
		mode = "symbol",
		preset = "codicons",
		symbol_map = {
			Text = "",
			Method = "",
			Function = "󰊕",
			Constructor = "",
			Field = "",
			Variable = "󰫧",
			Class = "",
			Interface = "", -- "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "󰷐",
			Keyword = "", -- ""
			Snippet = "",
			Color = "",
			File = "󰈙",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "", -- "󰏿",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	})
end

return {
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		dependencies = {
			{ "hrsh7th/cmp-path", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
			-- { "hrsh7th/cmp-nvim-lsp-signature-help", event = { "InsertEnter" } },
			-- { "hrsh7th/cmp-nvim-lsp-document-symbol", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-cmdline", event = { "CmdlineEnter" } },
			{ "saadparwaiz1/cmp_luasnip", event = { "InsertEnter" } },
			{ "onsails/lspkind-nvim", config = lspkind_config, event = { "InsertEnter" } },
		},
		config = completion_config,
	},
}
