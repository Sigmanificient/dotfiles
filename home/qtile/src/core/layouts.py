from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.config import Match

from utils import Color

layouts = [
    Columns(
        border_width=2,
        margin=4,
        border_focus=Color.BLUE_DARK,
        border_normal=Color.BG_DARK)
]

floating_layout = Floating(
    border_width=2,
    border_focus=Color.BLUE_DARK,
    border_normal=Color.BG_DARK,
    float_rules=[
        *Floating.default_float_rules,
        Match(wm_class="pavucontrol"),
        Match(wm_class="confirmreset"),
        Match(wm_class="ssh-askpass"),
        Match(title="pinentry"),
        Match(title="kitty"),
    ],
)
