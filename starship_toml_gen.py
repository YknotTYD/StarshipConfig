#!/usr/bin/env python3
#starship_toml_gen.py

import sys
from typing import TextIO, Tuple

"""
Made to be used by install_starship_config.sh.
"""

Color = Tuple[int, int, int]
GRADIENT_SCALING: float = 0.85
GRADIENT: Tuple[Color, Color] = (
    (255, 255, 0), #gradient base  color (1%   battery)
    (0,   255, 0), #gradient final color (100% battery)
)

BATTERY_DISPLAY: str = """
[[battery.display]]
threshold = {}
style = "bold {}"
"""

def output_starship_toml(filepath: str = "starship.toml", out: TextIO = sys.stdout) -> None:

    """
    **`output_starship_toml`**

    **Args**:

        `filepath (str, optional)`:
            The starship configuration file's path.
            Defaults to 'starship.toml'.

        `out (TextIO, optional)`:
            The stream to ouput to.
            Defaults to sys.stdout.
    """

    with open(filepath, "r") as file:
        file_content = file.read().split("\n")

    replacement_index = file_content.index("#PYTHONANCHOR_REPLACE")
    file_content[replacement_index] = ""

    for i in range(0, 100):

        color = [(f * (i / 100) + b * (1 - i / 100)) for b, f in zip(*GRADIENT)] #(255, 255, 0) to (0, 255, 0)
        color = [int(i * GRADIENT_SCALING) for i in color]                       #reduce all channel values by 15%
        color = [hex(i).removeprefix("0x") for i in color]                       #e.g. (255, 11, 0)       to ('ff', 'b', '0')
        color = [f"{i:0>2}" for i in color]                                      #e.g. ('ff', 'b', '0')   to ('ff', '0b', '00')
        color = "#" + "".join(color)                                             #e.g. ('ff', '0b', '00') to '#ff0b00'

        file_content[replacement_index] += BATTERY_DISPLAY.format(i + 1, color)

    for line in file_content:
        out.write(line)

if __name__ == '__main__':
    output_starship_toml()
