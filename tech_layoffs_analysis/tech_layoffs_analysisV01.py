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

# save as csv
df_grouped.to_csv('layoffs_HQ_sum.csv', index=False)

# dataframe Country and Laid_off
df_country = df.groupby('Country')['Laid_Off'].sum().reset_index()
df_country.columns = ['Country', 'Total_Laid_off']
print(df_country)
df_country.to_csv('layoffs_country_sum.csv', index=False)

# dataframe Continent and Laid_off
df_continent = df.groupby('Continent')['Laid_Off'].sum().reset_index()
df_continent.columns = ['Continent', 'Total_Laid_off']
print(df_continent)
df_continent.to_csv('layoffs_continent_sum.csv', index=False)
