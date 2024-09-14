import re
import subprocess

from libqtile import bar, widget

from utils import Color
from widgets import (
    Battery,
    Clock,
    CPUGraph,
    GroupBox,
    Memory,
    Mpris2,
    Prompt,
    QuickExit,
    Separator,
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
        Mpris2,
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

    def is_desktop(self):
        machine_info = subprocess.check_output(
            ["hostnamectl", "status"], universal_newlines=True)
        m = re.search(r"Chassis: (\w+)\s.*\n", machine_info)
        chassis_type = "desktop" if m is None else m.group(1)

        return chassis_type == "desktop"

    def _build_widgets(self):
        if self.is_desktop():
            self._widgets = [w for w in self._widgets if w != Battery]

        widgets = [widget_cls() for widget_cls in self._widgets]
        if self.id == 0:
            widgets.insert(13, Systray())

        return widgets

