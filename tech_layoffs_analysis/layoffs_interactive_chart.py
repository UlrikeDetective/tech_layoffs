# Layoffs interactive chart

import pandas as pd
import dash
from dash import dcc, html
from dash.dependencies import Input, Output
import plotly.express as px

# Load the data
file_path = '/layoffs_Continent_sum_year.csv'
data = pd.read_csv(file_path)

# Initialize the Dash app
app = dash.Dash(__name__)

# App layout
app.layout = html.Div([
    html.H1("Interactive Layoff Chart"),
    dcc.Graph(id='continent-bar-chart'),
    dcc.Graph(id='yearly-bar-chart')
])

# First layer: Total layoffs by continent
@app.callback(
    Output('continent-bar-chart', 'figure'),
    Input('continent-bar-chart', 'clickData')
)
def update_continent_chart(clickData):
    fig = px.bar(data, x='Continent', y='Total_Laid_off', title='Total Layoffs by Continent')
    return fig

# Second layer: Layoffs by year for the clicked continent
@app.callback(
    Output('yearly-bar-chart', 'figure'),
    Input('continent-bar-chart', 'clickData')
)
def update_yearly_chart(clickData):
    if clickData is None:
        return {}
    continent = clickData['points'][0]['x']
    filtered_data = data[data['Continent'] == continent]
    yearly_data = filtered_data.melt(id_vars=['Continent', 'Total_Laid_off'], 
                                     value_vars=['2020', '2021', '2022', '2023', '2024'], 
                                     var_name='Year', value_name='Laid_off')
    fig = px.bar(yearly_data, x='Year', y='Laid_off', title=f'Layoffs in {continent} by Year')
    return fig

# Run the app
if __name__ == '__main__':
    app.run_server(debug=True)
