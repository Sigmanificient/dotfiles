"""Wakatime widget by drawbu."""
import subprocess

from libqtile import qtile
from libqtile.widget import base


class Wakatime(base.InLoopPollText):
    def __init__(self, **config):
        super().__init__(update_interval=600, qtile=qtile, **config)
        self.default_string = "[:<]"

    def poll(self) -> str:
        try:
            proc = subprocess.run(
                ["nix", "run", "nixpkgs#wakatime", "--", "--today"],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                timeout=5
            )

        except (TimeoutError, FileNotFoundError):
            return self.default_string

        if proc.stderr is not None:
            return self.default_string

        return (
            proc.stdout.decode("utf-8").strip("\n")
            or self.default_string
        )
