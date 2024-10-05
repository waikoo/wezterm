local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

config.term = 'wezterm'
config.automatically_reload_config = true
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font('UbuntuMono Nerd Font')
config.font_size = 20.0
config.window_close_confirmation = 'NeverPrompt'
config.line_height = 1.2

config.window_padding = {
  left = 16,
  right = 16,
  top = 0,
  bottom = 0
}

config.window_decorations = "RESIZE"

config.leader = { mods = 'CTRL', key = '<', timeout_milliseconds = 500 }

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
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = "CTRL|SHIFT",
    key = "l",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    mods = "CTRL|SHIFT",
    key = "j",
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
    mods = "ALT",
    key = "j",
    action = wezterm.action.ActivatePaneDirection "Down"
  },
  {
    mods = "ALT",
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

return config
