import pathlib
import os
import subprocess

from libqtile import hook


@hook.subscribe.startup_once
def autostart():
    cwd = pathlib.Path(os.path.dirname(os.path.realpath(__file__)))
    autostart_path = str((cwd / ".." / "autostart.sh").absolute())

    subprocess.call([autostart_path])
