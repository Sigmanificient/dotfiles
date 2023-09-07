import os

from libqtile import bar, widget

from utils import Color
from widgets import (
    Battery,
    Clock,
    CPUGraph,
    GroupBox,
    Memory,
    Prompt,
    QuickExit,
    Separator,
    TaskList,
    Wakatime,
)


class Bar(bar.Bar):
    instance_count: int = 0

    widgets_checks = {
        Battery: lambda _: os.uname().nodename == "Bacon",
    }

    _widgets = [
        GroupBox,
        Separator,
        TaskList,
        Separator,
        Prompt,
        Wakatime,
        Battery,
        Memory,
        CPUGraph,
        Separator,
        widget.Volume,
        Clock,
        Separator,
        QuickExit,
    ]

    def __init__(self, id_):
        self.id = id_

        super().__init__(
            widgets=self._build_widgets(),
            size=24,
            background=Color.BG_DARK.with_alpha(0.7),
            margin=[0, 0, 8, 0],
        )

    def _build_widgets(self):
        return [
            widget_builder()
            for widget_builder in self._widgets
            if self.widgets_checks.get(widget_builder, bool)(self)
        ]
