from .defaults import widget_defaults
from .overides import (
    Battery,
    Clock,
    CPUGraph,
    GroupBox,
    Memory,
    Prompt,
    QuickExit,
    Separator,
    TaskList,
    Systray
)

from .spotify import SpotifyNowPlaying
from .wakatime import Wakatime

__all__ = (
    "widget_defaults",
    "Battery",
    "Clock",
    "CPUGraph",
    "GroupBox",
    "Memory",
    "Prompt",
    "QuickExit",
    "Separator",
    "SpotifyNowPlaying",
    "TaskList",
    "Systray",
    "Wakatime",
)
