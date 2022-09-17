import logging
import re
import subprocess
import sys
from typing import Optional

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)


def exec_command(*args) -> Optional[str]:
    try:
        output = subprocess.check_output(args)
        return output.decode()

    except subprocess.CalledProcessError:
        return None


def get_disk_list(cmd_out):
    return re.findall(
        re.compile(r"(\w+|\d+)\s+\d+:\d+\s+\d+\s+([0-9.]+G)\s+\d+\s+disk"),
        cmd_out
    )


def ask_disks(disks):
    print(
        '\n'.join(
            f"{c} - {disk_name} | {size}"
            for c, (disk_name, size) in enumerate(disks)
        )
    )

    idx = int(
        validate_input(
            ">> ",
            lambda x: x.isdigit() and len(disks) >= int(x) >= 0
        )
    )

    return disks[idx][0]


def generate_json(filename, key, val):
    print(key, val)
    with (
        open(f'json/{filename}.json') as input_file,
        open(f'out/{filename}.json', 'w+') as output_file
    ):
        output_file.write(input_file.read().replace(f'##{key}##', val))


def validate_input(string, check):
    reply = ''
    while not check(reply):
        try:
            reply = input(string)
        except (EOFError, KeyboardInterrupt):
            return None

    return reply


def main():
    out = exec_command('lsblk')

    if out is None:
        logger.error('Cannot lsblk')
        return 1

    chosen_disk = ask_disks(sorted(get_disk_list(out), key=lambda item: item[1]))
    if chosen_disk is None:
        print("Operation Aborted")
        return 1

    print("Account password")
    password = validate_input(">> ", lambda x: len(x) > 10)
    if password is None:
        print("Operation Aborted")
        return 1

    generate_json('user_configuration', 'disk', chosen_disk)
    generate_json('user_disk_layout', 'disk', chosen_disk)
    generate_json('user_credentials', 'password', password)
    return 0


if __name__ == '__main__':
    sys.exit(main())
