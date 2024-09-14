class Color(str):
    def with_alpha(self, alpha: float) -> str:
        return f"{self}{int(alpha * 255):02x}"


BG_DARK = Color("#0F0F1C")
BG_LIGHT = Color("#1A1C31")
BG_LIGHTER = Color("#22263F")

RED_DARK = Color("#D22942")
RED_LIGHT = Color("#DE4259")

GREEN_DARK = Color("#17B67C")
GREEN_LIGHT = Color("#3FD7A0")

YELLOW_DARK = Color("#F2A174")
YELLOW_LIGHT = Color("#EED49F")

BLUE_VERY_DARK = Color("#3F3D9E")
BLUE_DARK = Color("#8B8AF1")
BLUE_LIGHT = Color("#A7A5FB")

PURPLE_DARK = Color("#D78AF1")
PURPLE_LIGHT = Color("#E5A5FB")

CYAN_DARK = Color("#8ADEF1")
CYAN_LIGHT = Color("#A5EBFB")

TEXT_INACTIVE = Color("#292C39")
TEXT_DARK = Color("#A2B1E8")
TEXT_LIGHT = Color("#CAD3F5")
