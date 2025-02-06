local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

config.term = 'wezterm'
config.automatically_reload_config = true
config.window_background_image = "/home/waikoo/.images/leonardo_awesome2.jpg"
config.window_background_opacity = 0.9
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font_with_fallback({ 'Hasklug Nerd Font', "Noto Color Emoji" })
config.font_size = 13.5
config.line_height = 1.2
config.window_background_image = nil
config.window_background_gradient = nil
config.window_close_confirmation = 'NeverPrompt'
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.window_padding = {
  left = 16,
  right = 16,
  top = 0,
  bottom = 0
}

config.window_decorations = "RESIZE"
config.max_fps = 120

config.leader = { mods = 'CTRL', key = 'z', timeout_milliseconds = 500 }

config.keys = {
  {
    mods = "ALT",
    key = "n",
    action = wezterm.action.SpawnTab "CurrentPaneDomain",
  },
  {
    mods = "ALT",
    key = "q",
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    mods = "CTRL|SHIFT",
    key = "|",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    mods = "CTRL|SHIFT",
    key = "_",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    mods = "ALT",
    key = "h",
    action = wezterm.action.ActivatePaneDirection "Left"
  },
  {
    mods = "ALT",
    key = "l",
    action = wezterm.action.ActivatePaneDirection "Right"
  },
  {
    mods = "ALT|SHIFT",
    key = "j",
    action = wezterm.action.ActivatePaneDirection "Down"
  },
  {
    mods = "ALT|SHIFT",
    key = "k",
    action = wezterm.action.ActivatePaneDirection "Up"
  },
  {
    mods = "LEADER",
    key = "K",
    action = wezterm.action.AdjustPaneSize { "Up", 5 }
  },
  {
    mods = "LEADER",
    key = "J",
    action = wezterm.action.AdjustPaneSize { "Down", 5 }
  },
  {
    mods = "LEADER",
    key = "H",
    action = wezterm.action.AdjustPaneSize { "Left", 5 }
  },
  {
    mods = "LEADER",
    key = "L",
    action = wezterm.action.AdjustPaneSize { "Right", 5 }
  },
  {
    key = 'M',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    mods = "ALT|SHIFT",
    key = "{",
    action = wezterm.action.MoveTabRelative(-1)
  },
  {
    mods = "ALT|SHIFT",
    key = "}",
    action = wezterm.action.MoveTabRelative(1)
  },
}

-- Leader + 0-9
for i = 0, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i)
  })
end

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

-- No padding inside nvim
wezterm.on("update-right-status", function(window, pane)
  local process_name = pane:get_foreground_process_name()
  if process_name and process_name:find("nvim") then
    window:set_config_overrides({ window_padding = { left = 0, right = 0, top = 0, bottom = 0 } })
  else
    window:set_config_overrides({
      window_padding = { left = 16, right = 16, top = 0, bottom = 0 }
    })
  end
end)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Background = { Color = '#20ce97' } },
        { Foreground = { Color = '#000000' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
    return title
  end
)

config.warn_about_missing_glyphs = false
return config
