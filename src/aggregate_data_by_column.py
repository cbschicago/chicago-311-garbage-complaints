"""perform a pandas GroupBy on a single column and count unique sr numbers"""

import sys
import pandas as pd

df = pd.read_csv(sys.argv[1], low_memory=False)

print(
    df.groupby(sys.argv[2])
    .sr_number.nunique()
    .to_frame("unique_service_requests")
    .to_csv(index=False, line_terminator="\n")
)
