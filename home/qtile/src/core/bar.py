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
    SpotifyNowPlaying,
    Systray,
    TaskList,
)


class Bar(bar.Bar):
    _widgets = [
        GroupBox,
        Separator,
        TaskList,
        Separator,
        Prompt,
        SpotifyNowPlaying,
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
            background=Color.BG_DARK,
            margin=[0, 0, 8, 0]
        )

    def _build_widgets(self):
        widgets_copy = [widget_cls() for widget_cls in self._widgets]

        if self.id == 0:
            widgets_copy.insert(13, Systray())
        return widgets_copy

