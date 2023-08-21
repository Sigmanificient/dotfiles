import os

from libqtile.bar import Gap
from libqtile.config import Screen

from core.bar import Bar

gap = Gap(4)
wallpaper_path = os.path.expanduser("~/assets/wallpaper.png")

screens = [
    Screen(
        top=Bar(i),
        bottom=gap,
        left=gap,
        right=gap,
        wallpaper=wallpaper_path,
        wallpaper_mode="fill",
    )
    for i in range(2)
]
