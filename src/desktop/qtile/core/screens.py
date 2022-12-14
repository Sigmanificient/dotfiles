from libqtile.config import Screen

from core.bar import create_bar, gap

screens = [
    Screen(
        top=create_bar(),
        bottom=gap(),
        left=gap(),
        right=gap(),
    ),
    Screen(
        top=create_bar(secondary=True),
        bottom=gap(),
        left=gap(),
        right=gap(),
    )
]
