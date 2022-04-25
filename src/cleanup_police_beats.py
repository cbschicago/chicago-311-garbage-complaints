"""standardize police beats and fill null values to conform to boundaries file"""

import math
import sys
import pandas as pd


def clean_police_beat(police_beat):
    """get police beat values into a 4-digit zero-padded

    Args:
        police_beat (any): police beat value to clean

    Raises:
        TypeError: if not integer, string or float

    Returns:
        str: cleaned police beat
    """
    if pd.isna(police_beat):
        return "NO BEAT DATA"
    if isinstance(police_beat, (int, float)):
        frac, _ = math.modf(police_beat)
        assert frac == 0, "Found fractional police beat"
    elif isinstance(police_beat, str):
        return clean_police_beat(float(police_beat))
    else:
        raise TypeError(
            f"Expected police beat value of type (int, float, str), not {type(police_beat)}"
        )
    return str(int(police_beat)).zfill(4)


if __name__ == "__main__":
    df = pd.read_csv(sys.stdin, low_memory=False)
    df["police_beat"] = df.police_beat.apply(clean_police_beat)
    print(df.to_csv(index=False, line_terminator="\n"))
