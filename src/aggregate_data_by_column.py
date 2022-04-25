"""perform a pandas GroupBy on a single column and count unique sr numbers"""

import argparse
import pandas as pd

parser = argparse.ArgumentParser()
parser.add_argument("input_csv_file", type=str, help="complaint-level csv file")
parser.add_argument("agg_column", type=str, help="name of column to aggregate by")
parser.add_argument(
    "--pop_column", type=str, default=None, help="optional column to divide by"
)
parser.add_argument(
    "--pop_size",
    type=int,
    default=1000,
    help="amount to multiply divided column by, i.e. 'per 1000 residents'",
)
args = parser.parse_args()

df = pd.read_csv(args.input_csv_file, low_memory=False)

gb = df.groupby(args.agg_column)

agg = gb.sr_number.nunique().to_frame("unique_service_requests")

if args.pop_column is not None:
    agg = agg.join(gb[args.pop_column].first().to_frame("population"))
    agg[f"per_{args.pop_size}_residents"] = (
        agg.unique_service_requests / agg.population * args.pop_size
    )

print(agg.to_csv(index=True, line_terminator="\n"))
