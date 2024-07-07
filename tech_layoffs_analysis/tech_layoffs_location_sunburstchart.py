df.to_csv('/layoffs_location_with_coordinates.csv', index=False)

display(df.head())
display(df.info(verbose=True))

gr_cat = df[["Country",
             "location_HQ"]].groupby(["Country",
                                       "location_HQ"], as_index=False).size()

import plotly.express as px

fig = px.sunburst(gr_cat, width=1280, height=800,
                  path=["Country","location_HQ"], values="size",
                  color="Country",
                  title="<span style='font-size:18px;'><b>Locations of tech layoffs by location HQ and countries (cities in total number)</b></span><b></b>"
                  )
fig.update_layout(font_size=10, margin=dict(l=10, r=10, t=30, b=50))
fig.update_traces(textinfo="label+percent parent")
fig.show()

fig = px.treemap(gr_cat, width=1280, height=800,
                 path=["Country","location_HQ"], values='size',
                 color='Country')
fig.update_traces(textinfo="label+percent parent")
fig.show()
