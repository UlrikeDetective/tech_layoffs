import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots

# Load the data
file_path = '/Users/ulrike_imac_air/projects/DataScienceProjects/tech_layoffs_project/tech_layoffs_csv/tech_layoffs_Q22024_csv/layoffs_Continent_sum_year.csv'
data = pd.read_csv(file_path)

# First layer: Total layoffs by continent
fig = px.bar(data, x='Continent', y='Total_Laid_off', title='Total Layoffs by Continent')

# Function to create the second layer chart (Layoffs by Year for a specific Continent)
def create_yearly_chart(continent):
    filtered_data = data[data['Continent'] == continent]
    yearly_data = filtered_data.melt(id_vars=['Continent', 'Total_Laid_off'], 
                                     value_vars=['2020', '2021', '2022', '2023', '2024'], 
                                     var_name='Year', value_name='Laid_off')
    return px.bar(yearly_data, x='Year', y='Laid_off', title=f'Layoffs in {continent} by Year')

# Define the click event handler
def handle_click(trace, points, state):
    continent = points.point_inds[0]
    continent_name = data['Continent'].iloc[continent]
    yearly_chart = create_yearly_chart(continent_name)
    fig2 = go.FigureWidget(yearly_chart)
    fig2.show()

# Add click event to the first layer chart
fig.data[0].on_click(handle_click)

# Show the figure
fig.show()
