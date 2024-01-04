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

_Group.setup_single_keys()
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
