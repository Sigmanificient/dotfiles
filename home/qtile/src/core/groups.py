from libqtile.config import DropDown, Group, Key, ScratchPad
from libqtile.lazy import lazy

from .keys import keys, mod


class _Group(Group):

    def __init__(self, label: str, key: str):
        self.label = label
        self.key = key

        super().__init__(label)
        self.setup_keys()

    def setup_keys(self):
        move = Key([mod], self.key, lazy.group[self.label].toscreen())
        switch = Key(
            [mod, "shift"], self.key,
            lazy.window.togroup(self.label, switch_group=True),
        )

        toggle_scratchpad = Key(
            [mod], "space",
            lazy.group["scratchpad"].dropdown_toggle("term"),
        )

        keys.extend((move, switch, toggle_scratchpad))


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
            )
        ],
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

