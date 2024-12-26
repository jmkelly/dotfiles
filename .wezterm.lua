local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()
local dimmer = { brightness = 0.1 }


local function is_windows()
	return wezterm.target_triple == 'x86_64-pc-windows-msvc'
end

local function set_background_file(path)
	config.background = {
		{
			source = {
				File = path
			},
			hsb = dimmer
		}
	}
end

wezterm.on('update-right-status', function(window)
	local leader = ''
	local date = wezterm.strftime '%H:%M %h %e'
	if window:leader_is_active() then
		leader = 'LEADER'
	end

	window:set_right_status(wezterm.format { { Text = leader .. ' ' .. date  } })
end)

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'

config.use_fancy_tab_bar = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
config.audible_bell = "Disabled"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }

-- rename tab set to CTRL|SHIFT R
config.keys = {
	{
		key = 'R',
		mods = 'CTRL|SHIFT',
		action = act.PromptInputLine {
			description = 'Enter new name for tab',
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		},
	},
	{ key = 'F11',						action = act.ToggleFullScreen },
	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER",       action = act.SendKey { key = "a", mods = "CTRL" } },
	{ key = "c", mods = "LEADER",       action = act.ActivateCopyMode },

	-- Pane keybindings
	{ key = "-", mods = "LEADER",       action = act.SplitVertical { domain = "CurrentPaneDomain"} },
	-- maps | to split horizontal
	{ key = "\\", mods = "LEADER",       action = act.SplitHorizontal { domain = "CurrentPaneDomain"} },
	{ key = "h", mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER",       action = act.CloseCurrentPane { confirm = true } },
	{ key = "z", mods = "LEADER",       action = act.TogglePaneZoomState },
	{ key = "s", mods = "LEADER",       action = act.RotatePanes "Clockwise" },
	-- We can make separate keybindings for resizing panes
	-- But Wezterm offers custom "mode" in the name of "KeyTable"
	{ key = "r", mods = "LEADER",       action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

	-- Tab keybindings
	{ key = "n", mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "[", mods = "LEADER",       action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER",       action = act.ActivateTabRelative(1) },
	{ key = "t", mods = "LEADER",       action = act.ShowTabNavigator },
	-- Key table for moving tabs around
	{ key = "m", mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },

	-- Lastly, workspace
	{ key = "w", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
}

config.inactive_pane_hsb = {
	brightness = 0.4
}

-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1)
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
		{ key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
		{ key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
		{ key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter",  action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h",      action = act.MoveTabRelative(-1) },
		{ key = "j",      action = act.MoveTabRelative(-1) },
		{ key = "k",      action = act.MoveTabRelative(1) },
		{ key = "l",      action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter",  action = "PopKeyTable" },
	}
}
if is_windows() then
	config.default_prog = { 'pwsh' }
	set_background_file("C:/Users/james.kelly/Documents/code/dotfiles/nord.png")
	config.font_size = 10
else
	config.default_prog = { 'bash' }
	set_background_file("/home/james/.config/wezterm/nord.png")
	config.font_size = 11
end
return config
