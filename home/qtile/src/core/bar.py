import os

from libqtile import bar, widget

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


class Bar(bar.Bar):
    instance_count: int = 0

    widgets_checks = {
        battery: lambda: os.uname().nodename == 'Bacon',
        systray: lambda: Bar.instance_count == 1
    }

    widgets = [
        group_box,
        seperator,
        win_name,
        seperator,
        prompt,
        wakatime,
        chords,
        battery,
        memory,
        cpu_graph,
        seperator,
        widget.Volume,
        systray,
        clock,
        seperator,
        quick_exit,
    ]

    def __init__(self):
        super().__init__(
            widgets=self._build_widgets(),
            size=24,
            background=Color.BG_DARK.with_alpha(0.7),
            margin=[0, 0, 8, 0],
        )

        self.instance_count += 1

    def _build_widgets(self):
        return [
            self.widgets_checks.get(widget_builder, lambda: True)
            for widget_builder in self.widgets
        ]

