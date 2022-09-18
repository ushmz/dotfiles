local wt = require 'wezterm'

local LEFT_ARROW = utf8.char(0xff0b3)
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

-- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
-- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local ADMIN_ICON = utf8.char(0xf49c)
local CMD_ICON = utf8.char(0xe62a)
local NU_ICON = utf8.char(0xe7a8)
local PS_ICON = utf8.char(0xe70f)
local ELV_ICON = utf8.char(0xfc6f)
local WSL_ICON = utf8.char(0xf83c)
local YORI_ICON = utf8.char(0xf1d4)
local NYA_ICON = utf8.char(0xf61a)
local VIM_ICON = utf8.char(0xe62b)
local SUP_IDX = {"¹","²","³","⁴","⁵","⁶","⁷","⁸","⁹","¹⁰",
                 "¹¹","¹²","¹³","¹⁴","¹⁵","¹⁶","¹⁷","¹⁸","¹⁹","²⁰"}
local SUB_IDX = {"₁","₂","₃","₄","₅","₆","₇","₈","₉","₁₀",
                 "₁₁","₁₂","₁₃","₁₄","₁₅","₁₆","₁₇","₁₈","₁₉","₂₀"}

local COL_BG = "#252525"
local COL_BG_ALT = "#3E3E3E"
local COL_FG = "#E3E3E3"
local COL_FG_ALT = "#5E81AC"
local COL_ACCENT = "#4F4F4F"

local function strip_home_name(text)
	local username = os.getenv("USER")
	local clean_text = text:gsub("/home/" .. username, "~")
	return clean_text
end

wt.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	local clean_title = strip_home_name(tab.active_pane.title)
	return zoomed .. index .. clean_title
end)

wt.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local edge_background = "#252525"
  local background = "#3E3E3E"
  local foreground = "#1C1B19"
  local dim_foreground = "#3A3A3A"

  if tab.is_active then
    background = "#252525"
    foreground = "#1C1B19"
  elseif hover then
    background = "#FF8700"
    foreground = "#1C1B19"
  end

  local edge_foreground = background
  local shell_cmd, shell_name
  if tab.active_pane.title:find("nvim") then
    shell_cmd = ""
    shell_name = VIM_ICON .. tab.active_pane.title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
  elseif tab.active_pane.title:find("NYAGOS") then
    shell_cmd = tab.active_pane.title
    shell_name = NYA_ICON .. " " .. shell_cmd:gsub(".*: (.+) %- .+", "%1")
  elseif tab.active_pane.title:find("Yori") then
    shell_cmd = tab.active_pane.title:gsub(" %- Yori", "")
    shell_name = YORI_ICON .. " " .. shell_cmd
  else
    shell_cmd, shell_name = tab.active_pane.title:match("^(.*\\(%w+)%.exe)")
  end
  local real_title = tab.active_pane.title:match(".*\\cmd%.exe %- (.+)$") or "CMD"
  local clean_title

  if shell_name == "nu" then
    clean_title = NU_ICON .. " NuShell"
  elseif shell_name == "pwsh" then
    clean_title = PS_ICON .. " PS"
  elseif shell_name == "cmd" then
    clean_title = CMD_ICON .. " " .. real_title
  elseif shell_name == "elvish" then
    clean_title = ELV_ICON .. " Elvish"
  elseif shell_name == "wsl" then
    clean_title = WSL_ICON .. " WSL"
  else
    clean_title = shell_name
  end
  if shell_cmd and shell_cmd:match("Administrator: ") then
	clean_title = clean_title .. " " .. ADMIN_ICON
  end
  local left_arrow = SOLID_LEFT_ARROW
  if tab.tab_index == 0 then
    left_arrow = SOLID_LEFT_MOST
  end
  local id = SUB_IDX[tab.tab_index+1]
  local pid = SUP_IDX[tab.active_pane.pane_index+1]
  local title = " " .. wt.truncate_right(clean_title, max_width-6) .. " "

  return {
    {Attribute={Intensity="Bold"}},
    {Background={Color=edge_background}},
    {Foreground={Color=edge_foreground}},
    {Text=left_arrow},
    {Background={Color=background}},
    {Foreground={Color=foreground}},
    {Text=id},
    {Text=title},
    {Foreground={Color=dim_foreground}},
    {Text=pid},
    {Background={Color=edge_background}},
    {Foreground={Color=edge_foreground}},
    {Text=SOLID_RIGHT_ARROW},
    {Attribute={Intensity="Normal"}},
  }
end)

return {
  color_scheme = 'Hybrid (Gogh)',
  dpi = 96.0,
  font_size = 14.0,
  font = wt.font_with_fallback({
    "Hack Nerd Font",
    "Fira Code"
  }),
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_max_width = 25,
  window_padding = { left = 5, right = 5, top = 0, bottom = 0 },
	adjust_window_size_when_changing_font_size = false,
  colors = {
		background = COL_BG,
		foreground = COL_FG,
		selection_bg = COL_ACCENT,
		tab_bar = {
			background = COL_BG_ALT,
      active_tab = {
        bg_color = COL_BG,
        fg_color = COL_FG,
      },
			new_tab = {
				bg_color = COL_BG,
				fg_color = COL_FG,
			},
		},
	},
	inactive_pane_hsb = {
		saturation = 0.85,
		brightness = 0.85,
	},
  	hyperlink_rules = {
		-- Linkify things that look like URLs
		-- This is actually the default if you don't specify any hyperlink_rules
		{
			regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},

		-- match the URL with a PORT
		-- such 'http://localhost:3000/index.html'
		{
			regex = "\\b\\w+://(?:[\\w.-]+):\\d+\\S*\\b",
			format = "$0",
		},

		-- linkify email addresses
		{
			regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
			format = "mailto:$0",
		},

		-- file:// URI
		{
			regex = "\\bfile://\\S*\\b",
			format = "$0",
		},
	},
}
