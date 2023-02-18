from libqtile.config import Key
from libqtile.lazy import lazy

mod = "mod4"

keys = [
    Key(
        [mod], "e",
        lazy.spawn("thunar")
    ),
    Key(
        [mod], "l",
        lazy.spawn("betterlockscreen -l")
    ),
    Key(
        [mod], "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating"
    ),
    Key(
        [mod], "b",
        lazy.spawn("firefox-developer-edition")
    ),
    Key(
        [mod], "k",
        lazy.spawn("Xephyr -br -ac -noreset -screen 1600x900 :1")
    ),
    Key(
        [], "Print",
        lazy.spawn("flameshot gui --clipboard")
    ),
    Key(
        [mod], "space",
        lazy.layout.next(),
        desc="Move window focus to other window"
    ),
    Key(
        [mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"
    ),
    Key(
        [mod], "n",
        lazy.layout.normalize(),
        desc="Reset all window sizes"
    ),
    Key(
        [mod, "shift"], "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod], "Return",
        lazy.spawn("kitty"),
        desc="Launch terminal"
    ),
    Key(
        [mod], "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts"
    ),
    Key(
        [mod], "w",
        lazy.window.kill(),
        desc="Kill focused window"
    ),
    Key(
        [mod, "control"], "r",
        lazy.reload_config(),
        desc="Reload the config"
    ),
    Key(
        [mod, "control"], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
    ),
    Key(
        [mod], "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"
    ),
    # Backlight
    Key(
        [], "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl set +5%")
    ),
    Key(
        [], "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl set 5%-")
    ),
    # Volume
    Key(
        [], "XF86AudioMute",
        lazy.spawn("pamixer --toggle-mute")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("pamixer --decrease 5")
    ),
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("pamixer --increase 5")
    )
]
