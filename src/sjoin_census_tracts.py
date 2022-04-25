"""perform a geopandas spatial join to add census tract data to 311 file"""

import sys
import geopandas as gpd
import pandas as pd
import util
from constants import CRS

df = pd.read_csv(sys.stdin, low_memory=False)
df = gpd.GeoDataFrame(df, geometry=gpd.points_from_xy(df.longitude, df.latitude))
df.crs = CRS

geo = gpd.read_file(sys.argv[1])
assert geo.crs == CRS

df = gpd.sjoin(df, geo, how="left", predicate="within")

df["census_tract"] = df.census_tract.apply(
    lambda t: t if pd.notna(t) else "NO CENSUS TRACT FOUND"
)

df = util.drop_sjoin_indices(df)

print(df.to_csv(index=False, line_terminator="\n"))
