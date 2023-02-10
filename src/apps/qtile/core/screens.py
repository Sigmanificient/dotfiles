import os

from libqtile.config import Screen

from core.bar import create_bar, gap

wallpaper_path = os.path.expanduser("~/Pictures/wallpaper.png")
screens = [
    Screen(
        top=create_bar(),
        bottom=gap(),
        left=gap(),
        right=gap(),
        wallpaper=wallpaper_path,
        wallpaper_mode="fill",
    ),
    Screen(
        top=create_bar(secondary=True),
        bottom=gap(),
        left=gap(),
        right=gap(),
        wallpaper=wallpaper_path,
        wallpaper_mode="fill",
    ),
]
