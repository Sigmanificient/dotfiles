from .groups import groups
from .hooks import autostart
from .keys import keys, mod
from .layouts import floating_layout, layouts
from .mouse import mouse
from .screens import screens
from .widgets import extension_defaults, widget_defaults

__all__ = (
    # Keybindings
    "keys",
    "mod",
    # Hooks
    "autostart",
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
