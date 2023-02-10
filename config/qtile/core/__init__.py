from .keys import keys, mod
from .groups import groups
from .mouse import mouse
from .hooks import autostart
from .layouts import layouts, floating_layout
from .screens import screens
from .widgets import widget_defaults, extension_defaults

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
    "extension_defaults"
)
