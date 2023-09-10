"""Wakatime widget inspired by drawbu."""
from typing import List
import subprocess

from libqtile import qtile
from libqtile.widget import base


COVER_PATH = "/tmp/spotify-now-playing.png"


def get_stdout(cmd: List[str]) -> str:
    try:
        sub = subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            timeout=2
        )
    except (TimeoutError, FileNotFoundError):
        return ""
    if sub.stderr is not None:
        return ""
    return sub.stdout.decode("utf-8").strip()


class SpotifyNowPlaying(base.InLoopPollText):
    def __init__(self, **config):
        super().__init__("", update_interval=5, qtile=qtile, **config)
        self.name = "Spotify now playing"

    def poll(self) -> str:
        is_playing = get_stdout(["playerctl", "--player=spotify", "status"])
        if is_playing != "Playing":
            return ""
        artist = get_stdout(["playerctl", "--player=spotify", "metadata", "artist"])
        title = get_stdout(["playerctl", "--player=spotify", "metadata", "title"])
        if artist == "" or title == "":
            return ""
        return f" {artist} - {title}"
