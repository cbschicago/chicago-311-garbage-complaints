"""shared utility functions"""


def drop_sjoin_indices(df):
    """delete any preserved index columns resulting from a geopandas spatial join

    Args:
        df (pandas.DataFrame): dataframe to drop from

    Returns:
        pandas.DataFrame: dataframe with columns removed
    """
    for del_col in ["index_left", "index_right"]:
        if del_col in df.columns:
            del df[del_col]
    return df
