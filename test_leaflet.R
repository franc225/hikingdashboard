library(sf)
library(leaflet)

gpx <- st_read(
  "data/Centre_ville_Mont_Royal_Plateau.gpx",
  layer = "tracks",
  quiet = TRUE
)

gpx <- st_zm(gpx, drop = TRUE, what = "ZM")

map <- leaflet() %>%
  addTiles() %>%
  addPolylines(data = gpx, color = "red", weight = 4)

print(map)