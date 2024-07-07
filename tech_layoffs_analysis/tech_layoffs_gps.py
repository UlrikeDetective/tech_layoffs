import pandas as pd

# Read the CSV file with semicolon as the delimiter
df = pd.read_csv("/tech_layoffs_locations.csv", sep=';')

# Display the first few rows to verify that the file is read correctly
display(df.head())
display(df.info(verbose=True))
