from libqtile.bar import Bar, Gap

from utils import Color
from .widgets import (
    spacer,
    seperator,
    group_box,
    win_name,
    systray,
    volume,
    clock,
    quick_exit
)

bar_widgets = [
    spacer,
    group_box,
    seperator,
    win_name,
    systray,
    seperator,
    volume,
    seperator,
    clock,
    seperator,
    quick_exit,
    spacer,
]


def create_bar(secondary=False):
    return Bar(
        widgets=[
            BarWidget()
            for BarWidget in bar_widgets
            if (BarWidget != systray or not secondary)
        ],
        size=24,
        background=Color.BG_DARK.with_alpha(0.5),
        margin=[8, 8, 8, 8]
    )


def gap():
    return Gap(4)
