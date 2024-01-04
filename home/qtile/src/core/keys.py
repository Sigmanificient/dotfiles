import os

from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.log_utils import logger

mod = "mod4"

def _toggle(device: int, control: int):
    def wrapper(func):
        state: bool = False


        def wrapped(_):
            nonlocal state

            state = not state
            func(device, control, state)

        return wrapped
    return wrapper


@_toggle(device=12, control=150)
def toggle_keypad(device: int, control: int, state: bool):
    os.system(f"xinput set-prop {device} {control} {int(state)}")


keys = [
    Key([mod], "e", lazy.spawn("thunar")),
    Key([mod], "v", lazy.spawn("kitty -e pulsemixer")),
    Key([mod], "h", lazy.spawn("kitty -e nmtui")),
    Key([mod, "shift"], "v", lazy.spawn("pavucontrol")),
    Key([mod], "l", lazy.spawn("betterlockscreen -l")),
    Key([mod], "f", lazy.window.toggle_floating()),
    Key([mod], "b", lazy.spawn("firefox")),
    Key([], "Print", lazy.spawn("flameshot gui --clipboard")),
    Key([mod], "space", lazy.layout.next()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "Return", lazy.spawn("kitty")),
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([], "XF86TouchpadToggle", lazy.function(toggle_keypad)),
    # Backlight
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
    # Volume
    Key([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 5")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 5")),
    Key(
        [mod, "control"],
        "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key(
        [mod, "control"],
        "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "Up",
        lazy.layout.grow_up(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
]
