local function cmp()
	return require("cmp")
end

local function kind()
	return require("lspkind")
end

local function snip()
	return require("luasnip")
end

--- Return there is a character just before the cursor or not
---@return boolean
local has_words_before = function()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local lines = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)
	return cursor[2] ~= 0 and (lines[1] or ""):sub(cursor[2], cursor[2]):match("%s") == nil
end

--- The handler on `Tab` key pressed
---@param fallback any
local function tab(fallback)
	if cmp().visible() then
		cmp().select_next_item()
	elseif snip().expand_or_locally_jumpable() then
		snip().expand_or_jump()
	elseif has_words_before() then
		cmp().complete()
	else
		fallback()
	end
end

--- The handler on `Shift-Tab` key pressed
---@param fallback any
local function shift_tab(fallback)
	if cmp().visible() then
		cmp().select_prev_item()
	elseif snip().jumpable(-1) then
		snip().jump(-1)
	else
		fallback()
	end
end

local function format_for_tailwind_css(entry, vim_item)
	if vim_item.kind == "Color" and entry.completion_item.documentation then
		local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
		if r then
			local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
			local group = "Tw_" .. color
			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
			end
			vim_item.kind = "●"
			vim_item.kind_hl_group = group
			return vim_item
		end
	end
	vim_item.kind = kind().symbolic(vim_item.kind) and kind().symbolic(vim_item.kind) or vim_item.kind
	return vim_item
end

local function completion()
	local c = cmp()
	c.setup({
		snippet = {
			expand = function(args)
				snip().lsp_expand(args.body)
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered({ border = "single" }),
			documentation = c.config.window.bordered({ border = "single" }),
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = kind().cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				before = function(entry, vim_item)
					vim_item = format_for_tailwind_css(entry, vim_item)
					return vim_item
				end,
			}),
		},
		mapping = c.mapping.preset.insert({
			["<Tab>"] = c.mapping(tab, { "i", "s", "c" }),
			["<S-Tab>"] = c.mapping(shift_tab, { "i", "s", "c" }),
			["<C-n>"] = c.mapping(tab, { "i", "s", "c" }),
			["<C-p>"] = c.mapping(shift_tab, { "i", "s", "c" }),
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
			{ name = "nvim_lsp_signature_help" },
		}),
	})

	c.setup.cmdline(":", {
		sources = c.config.sources({
			{ name = "nvim_lsp_document_symbol" },
			{ name = "cmdline" },
		}),
	})

	c.setup.cmdline({ "/", "?" }, {
		sources = c.config.sources({
			{ name = "path" },
			{ name = "buffer" },
		}),
	})

	vim.api.nvim_set_var("completeopt", "menuone,preview,noinsert,noselect")
	vim.api.nvim_set_hl(0, "CmpItemKind", { link = "CmpItemMenuDefault" })
end

local function lspkind()
	require("lspkind").init({
		mode = "symbol",
		preset = "codicons",
		symbol_map = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "ﰠ",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "ﰠ",
			Unit = "塞",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "פּ",
			Event = "",
			Operator = "",
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
			{ "hrsh7th/cmp-nvim-lsp-signature-help", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-cmdline", event = { "CmdlineEnter" } },
			{ "saadparwaiz1/cmp_luasnip", event = { "InsertEnter" } },
			{ "onsails/lspkind-nvim", config = lspkind, event = { "InsertEnter" } },
		},
		config = completion,
	},
}
