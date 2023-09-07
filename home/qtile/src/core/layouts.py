from libqtile import layout
from libqtile.config import Match

from utils import Color

layouts = [
    layout.Columns(
        border_width=2,
        margin=4,
        border_focus=Color.BLUE_DARK,
        border_normal=Color.BG_DARK,
    )
]

floating_layout = layout.Floating(
    border_width=2,
    border_focus=Color.BLUE_DARK,
    border_normal=Color.BG_DARK,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="pavucontrol"),  # gitk
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="splash"),  # .Idea loader
        Match(title="kitty"),
    ],
)
