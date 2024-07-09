import pandas as pd

df = pd.read_csv('/tech_layoffs_csv/tech_layoffs_Q2_2024.csv')

# Display the first few rows of the DataFrame
display(df.head())

# Display the DataFrame information
display(df.info(verbose=True))

# Group by "Location_HQ" and sum the "Laid_off" entries
df_grouped = df.groupby('Location_HQ')['Laid_Off'].sum().reset_index()

# Rename the columns for clarity
df_grouped.columns = ['Location_HQ', 'Total_Laid_off']

print(df_grouped)
