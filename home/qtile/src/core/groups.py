import re

from libqtile.config import DropDown, Group, Key, ScratchPad, Match
from libqtile.lazy import lazy

from .keys import keys, mod


class _Group(Group):

    def __init__(self, name: str, key: str):
        self.name = name
        self.key = key

        super().__init__(name)
        self.setup_keys()

    def setup_keys(self):
        move = Key([mod], self.key, lazy.group[self.name].toscreen())
        switch = Key(
            [mod, "shift"], self.key,
            lazy.window.togroup(self.name, switch_group=True),
        )

        toggle_term = Key(
            [mod], "space",
            lazy.group["scratchpad"].dropdown_toggle("term"),
        )

        toggle_discord = Key(
            [mod, "shift"], "d",
            lazy.group["scratchpad"].dropdown_toggle("discord"),
        )

        keys.extend((move, switch, toggle_term, toggle_discord))


_scratchpads = [
    ScratchPad(
        "scratchpad", [
            DropDown(
                "term",
                "kitty",
                x=0.05,
                y=0.05,
                opacity=0.95,
                height=0.9,
                width=0.9,
                on_focus_lost_hide=False,
            ),
            DropDown(
                "discord",
                "discord",
                x=0.05,
                y=0.05,
                opacity=0.95,
                height=0.9,
                width=0.9,
                on_focus_lost_hide=False,
                match=Match(title=re.compile(".*(d|D)iscord.*"))
            )
        ]
    )
]

groups = _scratchpads + [
    _Group(lb, k) for lb, k in zip(
        "ζπδωλσς", [
            "ampersand",
            "eacute",
            "quotedbl",
            "apostrophe",
            "parenleft",
            "minus",
            "egrave",
            "underscore",
            "agrave",
        ]
    )
]

