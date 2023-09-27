from functools import partialmethod

from libqtile import widget
from libqtile.lazy import lazy

from utils import Color


def mk_overrides(cls, **conf):
    init_method = partialmethod(cls.__init__, **conf)
    return type(cls.__name__, (cls,), {"__init__": init_method})


Battery = mk_overrides(
    widget.Battery,
    format="⚡{percent:2.0%}",
    background=Color.BG_DARK.with_alpha(0.7),
    foreground=Color.TEXT_LIGHT,
    low_background=Color.RED_DARK.with_alpha(0.7),
    low_percentage=0.1,
)

CPUGraph = mk_overrides(
    widget.CPUGraph, type="line", line_width=1, border_width=0
)

GroupBox = mk_overrides(
    widget.GroupBox,
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

Memory = mk_overrides(
    widget.Memory,
    format="{MemUsed: .3f}Mb",
    mouse_callbacks={
        "Button1": lazy.spawn(
            "kitty"
            " -o initial_window_width=1720"
            " -o initial_window_height=860"
            " -e btop"
        )
    },
)

TaskList = mk_overrides(
    widget.TaskList,
    icon_size=0,
    fontsize=12,
    borderwidth=0,
    margin=0,
    padding=4,
    txt_floating="",
    highlight_method="block",
    title_width_method="uniform",
    spacing=8,
    foreground=Color.TEXT_LIGHT,
    background=Color.BG_DARK.with_alpha(0.8),
    border=Color.BG_DARK.with_alpha(0.9),
)

Separator = mk_overrides(widget.Spacer, length=4)
Clock = mk_overrides(widget.Clock, format="%A, %b %-d %H:%M")


QuickExit = mk_overrides(
    widget.QuickExit, default_text="⏻", countdown_format="{}"
)

Prompt = mk_overrides(
    widget.Prompt,
    prompt=">",
    bell_style="visual",
    background=Color.BG_DARK,
    foreground=Color.TEXT_LIGHT,
    padding=8,
)

Systray = mk_overrides(
    widget.Systray,
    icon_size=14,
    padding=8
)
