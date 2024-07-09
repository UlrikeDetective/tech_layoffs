import pandas as pd

df = pd.read_csv('/tech_layoffs_csv/tech_layoffs_Q2_2024.csv')

# Display the first few rows of the DataFrame
display(df.head())

# Display the DataFrame information
display(df.info(verbose=True))

# Group by "Location_HQ" and "Year" and sum the "Laid_Off" entries
df_HQ_Y = df.groupby(['Location_HQ', 'Year'])['Laid_Off'].sum().reset_index()

# Pivot the DataFrame to get years as columns
df_HQ_Y_pivot = df_HQ_Y.pivot(index='Location_HQ', columns='Year', values='Laid_Off').fillna(0)

# Add a 'Total_Laid_off' column
df_HQ_Y_pivot['Total_Laid_off'] = df_HQ_Y_pivot.sum(axis=1)

# Ensure all relevant years are present in the columns
for year in range(2020, 2025):
    if year not in df_HQ_Y_pivot.columns:
        df_HQ_Y_pivot[year] = 0

# Reorder columns to have years first and then 'Total_Laid_off'
columns_order = list(range(2020, 2025)) + ['Total_Laid_off']
df_HQ_Y_final = df_HQ_Y_pivot[columns_order].reset_index()

print(df_HQ_Y_final)

# save as csv
df_HQ_Y_final.to_csv('layoffs_HQ_sum_year.csv', index=False)
