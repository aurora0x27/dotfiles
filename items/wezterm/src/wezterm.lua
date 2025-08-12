local wezterm = require("wezterm")
local config = {

	-- default shell
	default_prog = { "zsh" },

	-- font settings
	font_size = 10,
	-- font = wezterm.font_with_fallback{"JetBrainsMonoNL Nerd Font Mono", "LXGWWenKaiMonoLite-Regular"},
	font = wezterm.font_with_fallback({
		"JetBrainsMonoNL Nerd Font",
		"Symbols Nerd Font Mono",
		"LXGWWenKaiMonoLite-Regular",
	}),
	-- font = wezterm.font("Maple Mono NF CN", { weight = "Regular", stretch = "Normal", style = "Normal" }),
	adjust_window_size_when_changing_font_size = false,

	color_scheme = "Catppuccin Mocha",

    underline_thickness = "3px",

	-- window decoration
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	window_decorations = "TITLE|RESIZE",
	window_background_opacity = 0.85,
	show_new_tab_button_in_tab_bar = false,
	text_background_opacity = 0.85,

	initial_cols = 160,
	initial_rows = 45,
	window_padding = {
		left = 10,
		right = 10,
		top = 0,
		bottom = 10,
	},

	-- ensure tmux color
	set_environment_variables = {
		-- This changes the default prompt for cmd.exe to report the
		-- current directory using OSC 7, show the current time and
		-- the current directory colored in the prompt.
		TERM = "xterm-256color",
	},

	-- -- key mappings
	-- keys = {
	-- 	{
	-- 		key = "n",
	-- 		mods = "ALT",
	-- 		action = wezterm.action.SpawnCommandInNewTab({
	-- 			args = { "/usr/bin/bash" },
	-- 		}),
	-- 	},
	-- 	{
	-- 		key = "RightArrow",
	-- 		mods = "ALT",
	-- 		action = wezterm.action({
	-- 			ActivateTabRelative = 1,
	-- 		}),
	-- 	},
	-- 	{
	-- 		key = "LeftArrow",
	-- 		mods = "ALT",
	-- 		action = wezterm.action({
	-- 			ActivateTabRelative = -1,
	-- 		}),
	-- 	},
	-- },
}

return config
