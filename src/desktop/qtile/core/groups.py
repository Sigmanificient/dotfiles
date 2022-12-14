from libqtile.config import Group, Key
from libqtile.lazy import lazy

from .keys import keys, mod

groups = [Group(f" {i} ") for i in "ζδωχλξπσς"]

for key, i in enumerate(groups, start=1):
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                str(key),
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                str(key),
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            )
        ]
    )
