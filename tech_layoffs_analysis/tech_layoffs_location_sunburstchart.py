df.to_csv('/layoffs_location_with_coordinates.csv', index=False)

display(df.head())
display(df.info(verbose=True))

gr_cat = df[["Country",
             "location_HQ"]].groupby(["Country",
                                       "location_HQ"], as_index=False).size()
