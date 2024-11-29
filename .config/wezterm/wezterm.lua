-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.scrollback_lines = 10000
config.audible_bell = "Disabled"

config.automatically_reload_config = true
config.font = wezterm.font("Ricty", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 19.0
config.use_ime = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

--config.window_decorations = "RESIZE"
--config.hide_tab_bar_if_only_one_tab = true
--config.window_frame = {
--    inactive_titlebar_bg = "none",
--    active_titlebar_bg = "none",
--}

--config.window_background_gradient = {
--    colors = { "#000000" }
--}
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.colors = {
    tab_bar = {
        inactive_tab_edge = "none",
    },
}

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {width=158, height=56})
    window:gui_window():set_position(0,0)
    window:set_inner_size(800, 1020)
end)

wezterm.on("mux-startup", function(cmd)
    --local window = wezterm.mux.spawn_window({})
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {width=158, height=56})
    --local tab, pane, window = wezterm.mux.spawn_window {}
    window:gui_window():set_position(0,0)
    window:set_inner_size(800, 1020)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local background = "#5c6d74"
    local foreground = "#FFFFFF"

    if tab.is_active then
        background = "#ae8b2d"
        foreground = "#FFFFFF"
    end

    local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
    return {
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
    }
end)

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'nord'

-- and finally, return the configuration to wezterm
return config
