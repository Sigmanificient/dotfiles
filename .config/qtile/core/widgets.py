from libqtile import widget

from utils import Color

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=12,
    background=Color.BG_DARK.with_alpha(0.5),
    foreground=Color.TEXT_LIGHT
)

extension_defaults = widget_defaults.copy()


def spacer():
    return widget.Spacer(length=4)


def seperator():
    return widget.Sep(
        background=Color.BG_DARK.with_alpha(0),
        padding=16,
        linewidth=0,
    )


def group_box():
    return widget.GroupBox(
        highlight_method='line',
        disable_drag=True,
        other_screen_border=Color.BLUE_VERY_DARK,
        other_current_screen_border=Color.BLUE_VERY_DARK,
        this_screen_border=Color.BLUE_DARK,
        this_current_screen_border=Color.BLUE_DARK,
        block_highlight_text_color=Color.TEXT_LIGHT,
        highlight_color=[Color.BG_LIGHT, Color.BG_LIGHT],
        inactive=Color.TEXT_INACTIVE,
        active=Color.TEXT_LIGHT,
    )


def win_name():
    return widget.WindowName()


def systray():
    return widget.Systray(padding=4)


def clock():
    return widget.Clock(format="%d/%m %H:%M")


def quick_exit():
    return widget.QuickExit(
        default_text='⏻',
        countdown_format='{}',
    )


def prompt():
    return widget.Prompt(
        prompt=">",
        background=Color.BG_DARK,
        foreground=Color.TEXT_LIGHT,
        padding=8,
    )


def chords():
    return widget.Chord(
        chords_colors={
            'launch': ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    )


def fix_systray_left():
    return widget.Sep(
        background=Color.BG_DARK.with_alpha(0.5),
        padding=8,
        linewidth=0,
    )


def fix_systray_right():
    return widget.Sep(
        background=Color.BG_DARK.with_alpha(0.5),
        padding=12,
        linewidth=0,
    )
