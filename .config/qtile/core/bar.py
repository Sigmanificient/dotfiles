from libqtile import widget
from libqtile.bar import Bar, Gap
from utils import Color

from .widgets import (
    prompt,
    chords,
    group_box,
    cpu_graph,
    memory,
    seperator,
    win_name,
    systray,
    clock,
    quick_exit,
)

main_bar_widgets = [
    group_box,
    win_name,
    prompt,
    chords,
    memory,
    cpu_graph,
    seperator,
    widget.Volume,
    systray,
    clock,
    seperator,
    quick_exit,
]

secondary_bar_widgets = [w for w in main_bar_widgets if w not in (systray, quick_exit)]


def create_bar(secondary=False):
    if secondary:
        bar_widgets = secondary_bar_widgets
    else:
        bar_widgets = main_bar_widgets

    return Bar(
        widgets=[BarWidget() for BarWidget in bar_widgets],
        size=24,
        background=Color.BG_DARK.with_alpha(0.7),
        margin=[0, 0, 8, 0],
    )


def gap():
    return Gap(4)
