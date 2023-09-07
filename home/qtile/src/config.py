from core import (
    autostart,
    floating_layout,
    groups,
    keys,
    layouts,
    mouse,
    screens
)

from widgets import widget_defaults


@lambda f: globals().update(f())
def setup_qtile_globals():
    return dict(
        extension_defaults = widget_defaults.copy(),

        dgroups_key_binder = None,
        dgroups_app_rules = [],

        follow_mouse_focus = True,
        bring_front_click = False,
        cursor_warp = False,

        auto_fullscreen = True,
        focus_on_window_activation = "smart",
        reconfigure_screens = True,

        auto_minimize = False,
        wmname = "Qtile"
    )


__all__ = (
    "autostart",
    "keys",
    "mouse",
    "groups",
    "layouts",
    "floating_layout",
    "screens",
    "widget_defaults",
)
