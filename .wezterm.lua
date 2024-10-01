local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local dimmer = { brightness = 0.1 }
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13
config.background = {
	{
		source = {
			File = "/home/james/.config/wezterm/nord.png",
		},
		hsb = dimmer
	}
}
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
return config
