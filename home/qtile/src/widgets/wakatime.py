"""Wakatime widget by Drawu."""
import subprocess
import sys

from libqtile import qtile
from libqtile.widget import base


class Wakatime(base.InLoopPollText):
    def __init__(self, **config):
        self.name = "Wakatime widget"
        super().__init__(
            update_interval=600, qtile=qtile, **config
        )

        self.default_string = "[:<]"

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

        raw = stdout.decode("utf-8").strip()

        if raw is not None:
            return self.process_string(raw)

        return self.default_string

    @staticmethod
    def process_string(raw) -> str:
        activities = raw.split(', ')
        out = []

        for ac in activities:
            if ac.count(' ') == 2:
                m, _, ac_name = ac.split(' ')

            elif ac.count(' ') == 4:
                h, _, m, _, ac_name = ac.split(' ')
                m = str(int(m) + (int(h) * 60))

            else:
                continue

            out.append(f"{ac_name[0]}:{m}")

        print("=>", ' '.join(out))
        return ' '.join(out) 
