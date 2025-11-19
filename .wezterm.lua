-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Window Settings
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 10
config.color_scheme = 'Cyberdyne'

-- Transparency (no blur)
config.colors = { background = '#000000' }
config.window_background_opacity = 1

-- Darken background image
config.window_background_image_hsb = {
  brightness = 0.1,
  saturation = 1.0,
  hue = 1.0,
}

-- Key Bindings
config.keys = {
  -- Pane Navigation
  {key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left'},
  {key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right'},
  {key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up'},
  {key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down'},

  -- Pane Splitting
  {key = '/', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }},
  {key = '-', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }},

  -- Pane Resizing
  {key = 'H', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 }},
  {key = 'L', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 }},
  {key = 'K', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 }},
  {key = 'J', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 }},

  -- Tab Management
  {key = 'T', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain'},
  {key = 'W', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = false }},

  -- Window Controls
  {key = 'F11', mods = 'NONE', action = wezterm.action.ToggleFullScreen},
  {key = 'Q', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = false }},

  -- Clipboard & Search
  {key = 'C', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard'},
  {key = 'V', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard'},
  {key = 'F', mods = 'CTRL|SHIFT', action = wezterm.action.Search 'CurrentSelectionOrEmptyString'},

  -- Scrollback
  {key = 'G', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode},
  {key = 'PageUp', mods = 'SHIFT', action = wezterm.action.ScrollByPage(-1)},
  {key = 'PageDown', mods = 'SHIFT', action = wezterm.action.ScrollByPage(1)},

  -- Background Image Toggle
  {
    key = 'B',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      if overrides.window_background_image == "" then
        overrides.window_background_image = "C:\\Users\\doruk\\Pictures\\872822c5e50dc71f345416098d29fc3ae5cd26c1-1280x720.jpg"
        overrides.window_background_opacity = 0.3
      else
        overrides.window_background_image = ""
        overrides.window_background_opacity = 1
      end
      window:set_config_overrides(overrides)
    end),
  },

  -- Opacity Toggle
  {
    key = 'Y',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      local current = overrides.window_background_opacity or 1
      overrides.window_background_opacity = (current < 0.5) and 1 or 0.3
      window:set_config_overrides(overrides)
    end),
  },
}

return config