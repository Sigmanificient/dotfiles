import os

from libqtile.bar import Gap
from libqtile.config import Screen

from core.bar import Bar

_gap = Gap(4)
_screen_attr = dict(
    bottom=_gap, left=_gap, right=_gap,
    wallpaper=os.path.expanduser("~/assets/wallpaper.png"),
    wallpaper_mode="fill")

screens = [Screen(top=Bar(i), **_screen_attr) for i in range(2)]
