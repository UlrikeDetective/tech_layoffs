import pandas as pd

df = pd.read_csv('/tech_layoffs_til_Q2_2024.csv')

# Display the first few rows of the DataFrame
display(df.head())

# Display the DataFrame information
display(df.info(verbose=True))

# Convert latitude and longitude to the correct format
df['latitude'] = df['latitude'].str.replace(',', '.').astype(float)
df['longitude'] = df['longitude'].str.replace(',', '.').astype(float)

import pandas as pd

df1 = pd.read_csv('/tech_layoffs_location.csv', quotechar='"', delimiter=';')

# Display the first few rows of the DataFrame
display(df1.head())

# Display the DataFrame information
display(df1.info(verbose=True))

df1['latitude'] = df1['latitude'].str.replace(',', '.').astype(float)
df1['longitude'] = df1['longitude'].str.replace(',', '.').astype(float)

import folium
from branca.element import Figure

# Create a Figure object
fig = Figure(width=1024, height=600)

# Create a Folium Map object covering the whole world
fmap = folium.Map(location=[0, 0], tiles="openstreetmap", zoom_start=2)

# Filter out rows with NaN latitude or longitude
df1_filtered = df1.dropna(subset=['latitude', 'longitude'])

# Define the path to the custom icon
icon_path = '/Users/ulrike_imac_air/projects/DataScienceProjects/tech_layoffs_project/tech_layoffs_pictures/redsmallpin.png'  # Change this to the correct path to your icon file

# Iterate over each row in the filtered DataFrame
for index, row in df1_filtered.iterrows():
    latitude, longitude = row['latitude'], row['longitude']
    name = row["location_HQ"] 
    
    # Create a custom icon
    icon = folium.CustomIcon(icon_image=icon_path, icon_size=(30, 30))  # Adjust icon_size as needed
    
    # Add marker to the map with the custom icon
    folium.Marker(location=[latitude, longitude], popup=name, icon=icon).add_to(fmap)

# Add the Folium Map object to the Figure
fig.add_child(fmap)

# Display the Figure
display(fig)

import pandas as pd
import plotly.express as px

# Filter the DataFrame for rows where Country is USA
usa_df = gr_cat[gr_cat['Country'] == 'USA']

# Create the treemap using the filtered DataFrame
fig = px.treemap(usa_df, width=1280, height=800,
                 path=["Country", "Location_HQ"], values='size',
                 color='Location_HQ')
fig.update_traces(textinfo="label+percent parent")
fig.show()

st_cat = df[["State",
             "Location_HQ"]].groupby(["State",
                                       "Location_HQ"], as_index=False).size()

import pandas as pd
import plotly.express as px


Ca_df = st_cat[st_cat['State'] == 'California']

# Create the treemap using the filtered DataFrame
fig = px.treemap(Ca_df, width=1280, height=800,
                 path=["State", "Location_HQ"], values='size',
                 color='Location_HQ')
fig.update_traces(textinfo="label+percent parent")
fig.show()

re_cat = df[["Region",
             "Location_HQ"]].groupby(["Region",
                                       "Location_HQ"], as_index=False).size()

import pandas as pd
import plotly.express as px


SF_df = re_cat[re_cat['Region'] == 'San Francisco Bay Area']

# Create the treemap using the filtered DataFrame
fig = px.treemap(SF_df, width=1280, height=800,
                 path=["Region", "Location_HQ"], values='size',
                 color='Location_HQ')
fig.update_traces(textinfo="label+percent parent")
fig.show()
