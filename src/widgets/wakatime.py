"""Wakatime widget by Drawu."""
import subprocess

from libqtile import qtile
from libqtile.widget import base


class Wakatime(base.InLoopPollText):
    def __init__(self, **config):
        self.name = "Wakatime widget"
        self.default_string = ""

        super().__init__(
            self.default_string, update_interval=600, qtile=qtile, **config
        )

    def poll(self):
        try:
            proc = subprocess.Popen(
                ["wakatime-cli", "--today"],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
            )

        except FileNotFoundError:
            return self.default_string

        stdout, stderr = proc.communicate()
        if stderr is not None:
            return self.default_string

        return " ".join(stdout.decode("utf-8").split()) or self.default_string
