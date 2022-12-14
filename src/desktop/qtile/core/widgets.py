from libqtile import widget
from libqtile.widget.groupbox import GroupBox

from utils import Color

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=2,
    background=Color.BG_DARK,
)

extension_defaults = widget_defaults.copy()


def spacer():
    return widget.Spacer(length=4)


def seperator():
    return widget.Sep(
        foreground=Color.TEXT_LIGHT,
        padding=12,
        linewidth=1,
        size_percent=50
    )


def group_box():
    return GroupBox(
        highlight_method='line',
        disable_drag=True,
        other_screen_border=Color.BLUE_VERY_DARK,
        other_current_screen_border=Color.BLUE_VERY_DARK,
        this_screen_border=Color.BLUE_DARK,
        this_current_screen_border=Color.BLUE_DARK,
        foreground=Color.TEXT_LIGHT,
        background=Color.BG_DARK,
        block_highlight_text_color=Color.TEXT_LIGHT,
        highlight_color=[Color.BG_LIGHT, Color.BG_LIGHT],
        inactive=Color.TEXT_INACTIVE,
        active=Color.TEXT_LIGHT
    )


def win_name():
    return widget.WindowName(
        foreground=Color.TEXT_LIGHT,
        background=Color.BG_DARK
    )


def systray():
    return widget.Systray(
        background=Color.BG_DARK,
        padding=4
    )


def volume():
    return widget.Volume(
        foreground=Color.TEXT_LIGHT,
        background=Color.BG_DARK,
        padding=4
    )


def clock():
    return widget.Clock(
        format="%d/%m %H:%M",
        foreground=Color.TEXT_LIGHT,
        background=Color.BG_LIGHT,
        padding=12,
    )


def quick_exit():
    return widget.QuickExit(
        foreground=Color.TEXT_LIGHT,
        default_text='Quit',
        countdown_format='{:4d}'
    )
