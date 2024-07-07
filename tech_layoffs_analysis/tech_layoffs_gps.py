import pandas as pd

# Read the CSV file with semicolon as the delimiter
df = pd.read_csv("/tech_layoffs_locations.csv", sep=';')

# Display the first few rows to verify that the file is read correctly
display(df.head())
display(df.info(verbose=True))

import pandas as pd
from geopy.geocoders import Nominatim
from typing import Tuple
from functools import lru_cache
import time

geolocator = Nominatim(user_agent="Python3.12")

@lru_cache(maxsize=None)
def get_coord_lat_lon(location_HQ: str, Country: str = None) -> Tuple[float, float]:
    """ Get coordinates for Cities """
    if Country:
        location = geolocator.geocode(location_HQ + ', ' + Country)
    else:
        location = geolocator.geocode(location_HQ)
    return (location.latitude, location.longitude) if location else (None, None)

# Assuming 'df' is your DataFrame and it has 'location_HQ' and 'Country' columns
# Create empty lists to store latitude and longitude
latitudes = []
longitudes = []

# Iterate over each row in the DataFrame
for index, row in df.iterrows():
    location_HQ = row['location_HQ']
    Country = row.get('Country')  # Use get to avoid KeyError if 'Country' might be missing

    lat, lon = get_coord_lat_lon(location_HQ, Country)
    if lat is not None and lon is not None:
        latitudes.append(lat)
        longitudes.append(lon)
    else:
        latitudes.append(None)
        longitudes.append(None)
    
    # Respect Nominatim's usage policy and avoid making too many requests in a short period
    time.sleep(1)  # Sleep for 1 second

# Add latitude and longitude columns to the DataFrame
df['latitude'] = latitudes
df['longitude'] = longitudes

# Display the DataFrame with latitude and longitude columns
print(df.head())

display(df.head())

df.to_csv('layoffs_location_with_coordinates.csv', index=False)
