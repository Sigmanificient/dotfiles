"""Wakatime widget by drawbu."""
import subprocess

from libqtile import qtile
from libqtile.widget import base


class Wakatime(base.InLoopPollText):
    def __init__(self, **config):
        self.name = "Wakatime widget"
        super().__init__(update_interval=600, qtile=qtile, **config)
        self.default_string = "[:<]"

    def poll(self):
        try:
            proc = subprocess.run(
                ["wakatime-cli", "--today"],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                timeout=1
            )

        except (TimeoutError, FileNotFoundError):
            return self.default_string

        if proc.stderr is not None:
            return self.default_string

        raw = proc.stdout.decode("utf-8").strip()

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

        return ' '.join(out)
