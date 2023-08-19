from .groups import groups
from .hooks import autostart
from .keys import keys, mod
from .layouts import floating_layout, layouts
from .mouse import mouse
from .screens import screens

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
)
