local wezterm = require("wezterm")

local config = wezterm.config_builder()

local windows = false

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	windows = true
end

config.enable_wayland = false

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font({
	family = "Monaspace Neon Var",
	weight = "Bold",
	harfbuzz_features = { "calt", "ss01", "ss03", "ss06", "ss07", "ss08", "liga" },
})

config.font_rules = {
	{
		italic = true,
		font = wezterm.font({
			family = "Monaspace Radon Var",
			weight = "Bold",
			harfbuzz_features = { "calt", "ss01", "ss03", "ss06", "ss07", "ss08", "liga" },
		}),
	},
}

config.font_size = 11.5

config.warn_about_missing_glyphs = false

if windows then
	config.default_prog = { "pwsh", "-noLogo" }
end

config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingBar"

local background_path = "/home/miitto/.config/wezterm/background.png"

if windows then
	background_path = "C:\\Users\\miitto\\.config\\wezterm\\background.png"
end

-- Transparency
config.background = {
	-- {
	-- 	source = {
	-- 		File = background_path,
	-- 	},
	-- 	hsb = {
	-- 		hue = 1.0,
	-- 		saturation = 1.02,
	-- 		brightness = 0.25,
	-- 	},
	-- 	width = "100%",
	-- 	height = "100%",
	-- },
	{
		source = {
			Color = "#1e1e2e",
		},
		width = "100%",
		height = "100%",
		opacity = 0.75,
	},
}

config.window_padding = {
	left = 3,
	right = 3,
	top = 3,
	bottom = 3,
}

config.xcursor_theme = "Bibata-Modern-Ice"
config.xcursor_size = 24


local session_manager = require("wezterm-session-manager/session-manager")
wezterm.on("save_session", function(window) session_manager.save_state(window) end)
wezterm.on("load_session", function(window) session_manager.load_state(window) end)
wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)

config.leader = { key = 'z', mods = 'CTRL', timeout_milliseconds = 1000}


config.keys = {
  {key = "S", mods = "LEADER", action = wezterm.action{EmitEvent = "save_session"}},
  {key = "L", mods = "LEADER", action = wezterm.action{EmitEvent = "load_session"}},
  {key = "R", mods = "LEADER", action = wezterm.action{EmitEvent = "restore_session"}},
  -- Allow CTRL-Z passthrough by pressing CTRL-Z, CTRL-Z
  {key = 'z', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 'z', mods = 'CTRL' },},
}

return config
