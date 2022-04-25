"""add the names of neighborhoods to census tracts"""

import sys
import geopandas as gpd
import pandas as pd
import util
from constants import CRS

df = pd.read_csv(sys.stdin, low_memory=False)
df = gpd.GeoDataFrame(
    df, geometry=gpd.points_from_xy(df.longitude, df.latitude), crs=CRS
)

geo = gpd.read_file(sys.argv[1])
assert geo.crs == CRS

df = gpd.sjoin(df, geo, how="left", predicate="within")

df = util.drop_sjoin_indices(df)

print(df.to_csv(index=False, line_terminator="\n"))
