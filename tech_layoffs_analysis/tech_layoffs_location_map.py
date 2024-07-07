df.to_csv('/layoffs_location_with_coordinates.csv', index=False)

display(df.head())
display(df.info(verbose=True))

import folium
from branca.element import Figure

# Create a Figure object
fig = Figure(width=1024, height=600)

# Create a Folium Map object covering the whole world
fmap = folium.Map(location=[0, 0], tiles="openstreetmap", zoom_start=2)

# Filter out rows with NaN latitude or longitude
df_filtered = df.dropna(subset=['latitude', 'longitude'])

# Define the path to the custom icon
icon_path = '/Users/ulrike_imac_air/projects/DataScienceProjects/tech_layoffs_project/tech_layoffs_pictures/redsmallpin.png'  # Change this to the correct path to your icon file

# Iterate over each row in the filtered DataFrame
for index, row in df_filtered.iterrows():
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
