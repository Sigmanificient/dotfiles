import os

from libqtile import widget
from libqtile.bar import Bar, Gap

from utils import Color

from .widgets import (
    battery,
    chords,
    clock,
    cpu_graph,
    group_box,
    memory,
    prompt,
    quick_exit,
    seperator,
    systray,
    wakatime,
    win_name,
)

main_bar_widgets = (
    [group_box, seperator, win_name, seperator, prompt, wakatime, chords]
    + ([battery] if os.uname().nodename == "Bacon" else [])
    + [
        memory,
        cpu_graph,
        seperator,
        widget.Volume,
        systray,
        clock,
        seperator,
        quick_exit,
    ]
)

secondary_bar_widgets = [
    w for w in main_bar_widgets if w not in (systray, quick_exit)
]


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
