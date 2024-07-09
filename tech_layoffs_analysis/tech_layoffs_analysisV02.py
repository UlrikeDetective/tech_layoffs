import pandas as pd

df = pd.read_csv('/tech_layoffs_csv/tech_layoffs_Q2_2024.csv')

# Display the first few rows of the DataFrame
display(df.head())

# Display the DataFrame information
display(df.info(verbose=True))
