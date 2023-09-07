from libqtile.config import DropDown, Group, Key, ScratchPad
from libqtile.lazy import lazy

from .keys import keys, mod

groups = [Group(f"{i}") for i in "ζδωχλξπσς"]
group_keys = [
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

for g, key in zip(groups, group_keys):
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                key,
                lazy.group[g.name].toscreen(),
                desc="Switch to group {}".format(g.name),
            ),
            Key(
                [mod, "shift"],
                key,
                lazy.window.togroup(g.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    g.name
                ),
            ),
            Key(
                [mod],
                "space",
                lazy.group["scratchpad"].dropdown_toggle("term"),
            ),
        ]
    )


groups.append(
    ScratchPad(
        "scratchpad",
        [
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
)
