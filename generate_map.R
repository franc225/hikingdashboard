# =====================================================
# Hiking Dashboard - Leaflet Map Generator
# =====================================================

# ---- Packages ----
library(sf)
library(leaflet)
library(stringr)

# ---- Paths ----
DATA_DIR <- "data"

# ---- Load GPX files ----
gpx_files <- list.files(
  DATA_DIR,
  pattern = "\\.gpx$",
  full.names = TRUE
)

if (length(gpx_files) == 0) {
  stop("Aucun fichier GPX trouvé dans le dossier data/")
}

# ---- Read GPX tracks ----
traces <- lapply(gpx_files, function(f) {
  st_read(f, layer = "tracks", quiet = TRUE) %>%
    mutate(
      randonnee = str_remove(basename(f), "\\s*\\(\\d+\\)\\.gpx$") %>%
        str_remove("\\.gpx$")
    )
})

traces_sf <- do.call(rbind, traces)

# ---- Generate Leaflet map (simple & reliable) ----
map <- leaflet() %>%
  addTiles() %>%   # fond OpenStreetMap simple
  addPolylines(
    data = traces_sf,
    color = "#08306B",   # couleur unique
    weight = 6,
    opacity = 0.3        # superposition = fréquence visuelle
  )

# ---- IMPORTANT : display map ----
print(map)

# ---- HTML Export ----
library(htmlwidgets)
saveWidget(map, "output/sentiers.html", selfcontained = FALSE)