from functools import partial

import os
from libqtile.bar import Gap
from libqtile.config import DropDown, Group, Key, Match, Screen, ScratchPad
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.lazy import lazy

from bar import Bar, widget_defaults
from controls import mod, keys

import colors


_gap = Gap(4)
Screen = partial(
    Screen,
    bottom=_gap, left=_gap, right=_gap,
    wallpaper=os.path.expanduser("~/assets/wallpaper.png"),
    wallpaper_mode="fill"
)

screens = [Screen(top=Bar(i)) for i in range(2)]

layouts = [
    Columns(
        border_width=2,
        margin=4,
        border_focus=colors.BLUE_DARK,
        border_normal=colors.BG_DARK
    )
]

floating_layout = Floating(
    border_width=2,
    border_focus=colors.BLUE_DARK,
    border_normal=colors.BG_DARK,
    float_rules=[
        *Floating.default_float_rules,
        Match(wm_class="pavucontrol"),
        Match(wm_class="confirmreset"),
        Match(wm_class="ssh-askpass"),
        Match(title="pinentry"),
        Match(title="kitty"),
    ],
)

class _Group(Group):

    def __init__(self, name: str, key: str):
        self.name = name
        self.key = key

        super().__init__(name)
        self.setup_keys()

    @classmethod
    def setup_single_keys(cls):
        toggle_term = Key(
            [mod, "shift"], "space",
            lazy.group["scratchpad"].dropdown_toggle("term"),
        )

        keys.append(toggle_term)

    def setup_keys(self):
        move = Key([mod], self.key, lazy.group[self.name].toscreen())
        switch = Key(
            [mod, "shift"], self.key,
            lazy.window.togroup(self.name, switch_group=True),
        )

        keys.extend((move, switch))

_scratchpad_defaults = dict(
    x=0.05,
    y=0.05,
    opacity=0.95,
    height=0.9,
    width=0.9,
    on_focus_lost_hide=False
)

_scratchpads = [
    ScratchPad(
        "scratchpad",
        [DropDown("term", "kitty", **_scratchpad_defaults)]
    )
]

_Group.setup_single_keys()
groups = _scratchpads + [_Group(lb, k) for lb, k in zip("ζπδωλσς", "1234567")]

extension_defaults = widget_defaults.copy()

dgroups_key_binder = None
dgroups_app_rules = []

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = False
wmname = "Qtile"
