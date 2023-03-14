from libqtile import widget
from libqtile.lazy import lazy

from utils import Color

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=12,
    background=Color.BG_DARK.with_alpha(0.7),
    foreground=Color.TEXT_LIGHT,
)

extension_defaults = widget_defaults.copy()


def spacer():
    return widget.Spacer(length=4)


def arch_logo():
    return widget.Image(
        margin=6,
        scale=True,
        filename="~/assets/arch_icon.svg",
        mouse_callbacks={"Button1": lazy.spawn("rofi -show drun")},
    )


def memory():
    return widget.Memory(
        format="{MemUsed: .3f}Mb",
        mouse_callbacks={
            "Button1": lazy.spawn(
                "kitty"
                " -o initial_window_width=1720"
                " -o initial_window_height=860"
                " -e bpytop"
            )
        },
    )


def cpu_graph():
    return widget.CPUGraph(type="line", line_width=1, border_width=0)


def seperator():
    return widget.Sep(
        background=Color.BG_DARK.with_alpha(0.7),
        padding=4,
        linewidth=0,
    )


def group_box():
    return widget.GroupBox(
        highlight_method="line",
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
    return widget.TaskList(
        icon_size=0,
        fontsize=12,
        borderwidth=0,
        margin=0,
        padding=4,
        txt_floating="",
        highlight_method = "block",
        title_width_method = "uniform",
        spacing=8,
        foreground=Color.TEXT_LIGHT,
        background=Color.BG_DARK.with_alpha(0.6),
        border=Color.BG_DARK.with_alpha(0.5),
    )


def systray():
    return widget.Systray(padding=4, icon_size=16)


def clock():
    return widget.Clock(format="%d/%m %H:%M")


def quick_exit():
    return widget.QuickExit(
        default_text="⏻",
        countdown_format="{}",
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
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    )


def fix_systray_left():
    return widget.Sep(
        background=Color.BG_DARK.with_alpha(0.8),
        padding=8,
        linewidth=0,
    )


def fix_systray_right():
    return widget.Sep(
        background=Color.BG_DARK.with_alpha(0.8),
        padding=12,
        linewidth=0,
    )
