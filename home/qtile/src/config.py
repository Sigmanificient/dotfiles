from core import (
    autostart,
    extension_defaults,
    floating_layout,
    groups,
    keys,
    layouts,
    mouse,
    screens,
    widget_defaults,
)

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

__all__ = (
    # Hooks
    "autostart",
    # Keybindings
    "keys",
    # Mouse
    "mouse",
    # Workspaces groups
    "groups",
    # Layouts
    "layouts",
    "floating_layout",
    # Screens
    "screens",
    # Widgets
    "widget_defaults",
    "extension_defaults",
)
