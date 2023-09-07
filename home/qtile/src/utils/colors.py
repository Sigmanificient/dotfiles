from __future__ import annotations

AlphaColor = str


class _Color(AlphaColor):
    def with_alpha(self, alpha: float) -> AlphaColor:
        return AlphaColor(f"{self}{int(alpha * 255):02x}")


class Color(AlphaColor):
    BG_DARK = _Color("#0F0F1C")
    BG_LIGHT = _Color("#1A1C31")
    BG_LIGHTER = _Color("#22263F")

    RED_DARK = _Color("#D22942")
    RED_LIGHT = _Color("#DE4259")

    GREEN_DARK = _Color("#17B67C")
    GREEN_LIGHT = _Color("#3FD7A0")

    YELLOW_DARK = _Color("#F2A174")
    YELLOW_LIGHT = _Color("#EED49F")

    BLUE_VERY_DARK = _Color("#3F3D9E")
    BLUE_DARK = _Color("#8B8AF1")
    BLUE_LIGHT = _Color("#A7A5FB")

    PURPLE_DARK = _Color("#D78AF1")
    PURPLE_LIGHT = _Color("#E5A5FB")

    CYAN_DARK = _Color("#8ADEF1")
    CYAN_LIGHT = _Color("#A5EBFB")

    TEXT_INACTIVE = _Color("#292C39")
    TEXT_DARK = _Color("#A2B1E8")
    TEXT_LIGHT = _Color("#CAD3F5")
