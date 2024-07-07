df.to_csv('/tech_layoffs_csv/layoffs_location_with_coordinates.csv', index=False)

display(df.head())
display(df.info(verbose=True))
