local status1, cmp = pcall(require, "cmp")
if not status1 then
	return
end

local status2, luasnip = pcall(require, "luasnip")
if not status2 then
	return
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
	if cmp.visible() then
		cmp.select_next_item()
	elseif luasnip.expand_or_locally_jumpable() then
		luasnip.expand_or_jump()
	elseif has_words_before() then
		cmp.complete()
	else
		fallback()
	end
end

--- The handler on `Shift-Tab` key pressed
---@param fallback any
local function shift_tab(fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	elseif luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		fallback()
	end
end

local function config()
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered({ border = "single" }),
			documentation = cmp.config.window.bordered({ border = "single" }),
		},
		mapping = cmp.mapping.preset.insert({
			["<Tab>"] = cmp.mapping(tab, { "i", "s", "c" }),
			["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "s", "c" }),
			["<C-n>"] = cmp.mapping(tab, { "i", "s", "c" }),
			["<C-p>"] = cmp.mapping(shift_tab, { "i", "s", "c" }),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<C-CR>"] = cmp.mapping.close(),
		}),
		sources = cmp.config.sources({
			-- { name = "calc" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
		}),
	})

	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "nvim_lsp_document_symbol" },
			{ name = "cmdline", keyword_length = 2 },
		}),
	})

	cmp.setup.cmdline({ "/", "?" }, {
		sources = cmp.config.sources({
			{ name = "path" },
			{ name = "buffer" },
		}),
	})

	vim.api.nvim_set_var("completeopt", "menuone,preview,noinsert,noselect")
	vim.api.nvim_set_hl(0, "CmpItemKind", { link = "CmpItemMenuDefault" })
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-path", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-nvim-lsp-signature-help", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-nvim-lsp-document-symbol", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-calc", event = { "InsertEnter" } },
		{ "hrsh7th/cmp-cmdline", event = { "CmdlineEnter" } },
		{ "saadparwaiz1/cmp_luasnip", event = { "InsertEnter" } },
	},
	config = config,
}
