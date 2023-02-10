from src.apps.qtile.core.keys import keys, mod
from src.apps.qtile.core.groups import groups
from src.apps.qtile.core.mouse import mouse
from src.apps.qtile.core.hooks import autostart
from src.apps.qtile.core.layouts import layouts, floating_layout
from src.apps.qtile.core.screens import screens
from src.apps.qtile.core.widgets import widget_defaults, extension_defaults

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
