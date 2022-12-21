from libqtile.widget.pulse_volume import PulseVolume

from utils import Color


class CustomVolume(PulseVolume):

    def __init__(self, **config):
        super().__init__(
            emoji=True,
            fmt="{}",
            foreground=Color.TEXT_LIGHT,
            padding=12,
            **config
        )

        self.__icons = ('婢', '奔', '墳')

    def _update_drawer(self):
        icon = self.__icons[(self.volume > 1) + (self.volume > 50)]
        self.text = f"{icon} {self.volume: 3d}%"
