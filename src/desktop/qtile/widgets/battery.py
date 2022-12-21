from libqtile.widget.battery import Battery, BatteryState


class CustomBattery(Battery):

    def __init__(self, **config):
        super().__init__(**config)
        self.__discharging_icons = (
            "", "", "", "", "",
            "", "", "", "", ""
        )

    def build_string(self, status) -> str:

        if status.state == BatteryState.FULL:
            icon = ""
        elif status.state == BatteryState.CHARGING:
            icon = ""
        elif status.state == BatteryState.DISCHARGING:
            current = int(status.percent * 10)
            icon = self.__discharging_icons[min(current, 9)]
        else:
            icon = ""
        return f"{icon} {int(status.percent * 100)}"
