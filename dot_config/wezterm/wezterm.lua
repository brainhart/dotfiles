-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

------------------------------------------------------------
-- Appearance
------------------------------------------------------------

config.color_scheme = "Gruvbox dark, pale (base16)"
config.audible_bell = "Disabled"

-- tmux-like minimal top bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false

------------------------------------------------------------
-- Behavior
------------------------------------------------------------

-- tmux prefix
config.leader = {
	key = "a",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}

-- scrollback ~= tmux history-limit
config.scrollback_lines = 5000

------------------------------------------------------------
-- Keybindings
------------------------------------------------------------

config.keys = {
	----------------------------------------------------------
	-- Splits (same cwd)
	----------------------------------------------------------
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},

	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({
			confirm = true,
		}),
	},

	----------------------------------------------------------
	-- Pane navigation
	-- Ctrl-h/j/k/l intentionally NOT bound (Neovim owns them)
	----------------------------------------------------------

	-- Leader-based (tmux-style)
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},

	-- Alt-based (fast, single-keystroke)
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},

	----------------------------------------------------------
	-- Pane resizing (tmux-style H J K L)
	----------------------------------------------------------
	{
		key = "H",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Left", 2 }),
	},
	{
		key = "J",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Down", 2 }),
	},
	{
		key = "K",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Up", 2 }),
	},
	{
		key = "L",
		mods = "LEADER",
		action = wezterm.action.AdjustPaneSize({ "Right", 2 }),
	},

	----------------------------------------------------------
	-- Copy / Paste (native clipboard)
	----------------------------------------------------------
	{
		key = "Escape",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	----------------------------------------------------------
	-- Tabs (tmux window navigation equivalent)
	----------------------------------------------------------
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},

	----------------------------------------------------------
	-- Reload config (tmux: source-file)
	----------------------------------------------------------
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ReloadConfiguration,
	},
}

------------------------------------------------------------
-- Finalize
------------------------------------------------------------

return config
