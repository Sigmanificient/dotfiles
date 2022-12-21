from libqtile.bar import Bar, Gap

from utils import Color
from widgets.battery import CustomBattery
from widgets.volume import CustomVolume
from .widgets import (
    prompt,
    chords,
    spacer,
    group_box,
    seperator,
    win_name,
    fix_systray_left,
    fix_systray_right,
    systray,
    clock,
    quick_exit
)

main_bar_widgets = [
    spacer,
    group_box,
    seperator,
    win_name,
    prompt,
    chords,
    seperator,
    fix_systray_left,
    systray,
    fix_systray_right,
    seperator,
    CustomVolume,
    seperator,
    CustomBattery,
    seperator,
    clock,
    seperator,
    quick_exit,
    spacer
]

secondary_bar_widgets = main_bar_widgets[:6] + main_bar_widgets[10:]


def create_bar(secondary=False):
    if secondary:
        bar_widgets = secondary_bar_widgets
    else:
        bar_widgets = main_bar_widgets

    return Bar(
        widgets=[BarWidget() for BarWidget in bar_widgets],
        size=24,
        background=Color.BG_DARK.with_alpha(0.5),
        margin=[8, 8, 8, 8],
    )


def gap():
    return Gap(4)
