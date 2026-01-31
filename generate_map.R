# =====================================================
# Hiking Dashboard - Leaflet Map Generator
# =====================================================

# ---- Packages ----
library(sf)
library(leaflet)
library(stringr)
library(dplyr)
library(magrittr)
library(htmlwidgets)

# ---- Paths ----
DATA_DIR <- "data"
OUTPUT_DIR <- "output"
OUTPUT_FILE <- file.path(OUTPUT_DIR, "sentiers.html")

if (!dir.exists(OUTPUT_DIR)) {
  dir.create(OUTPUT_DIR)
}

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

# ---- Compute distance per GPX (km) ----
traces_sf$distance_km <- as.numeric(st_length(traces_sf)) / 1000

# ---- Build summary table ----
summary_df <- traces_sf %>%
  st_drop_geometry() %>%
  group_by(randonnee) %>%
  summarise(
    passages = n(),
    distance_avg_km = round(mean(distance_km), 2),
    distance_total_km = round(sum(distance_km), 2)
  ) %>%
  arrange(desc(passages))

# ---- Build HTML table ----
table_html <- paste0(
  "<div style='max-height:220px; overflow:auto;'>",
  "<table style='width:100%; border-collapse:collapse; font-size:12px;'>",
  "<tr style='background:#f0f0f0;'>",
  "<th align='left'>Trail</th>",
  "<th>Passages</th>",
  "<th>Avg (km)</th>",
  "<th>Total (km)</th>",
  "</tr>",
  paste0(
    apply(summary_df, 1, function(row) {
      paste0(
        "<tr>",
        "<td>", row["randonnee"], "</td>",
        "<td align='center'>", row["passages"], "</td>",
        "<td align='center'>", row["distance_avg_km"], "</td>",
        "<td align='center'>", row["distance_total_km"], "</td>",
        "</tr>"
      )
    }),
    collapse = ""
  ),
  "</table></div>"
)

# ---- Generate Leaflet map ----
map <- leaflet() %>%
  addTiles() %>%   # fond OpenStreetMap simple et fiable
  addPolylines(
    data = traces_sf,
    color = "#08306B",
    weight = 6,
    opacity = 0.3,
    popup = ~paste0(
      "<b>", randonnee, "</b><br>",
      "Distance: ", round(distance_km, 2), " km"
    )
  ) %>%
  addControl(
    html = table_html,
    position = "bottomright"
  )

# ---- IMPORTANT : display map ----
print(map)

# ---- HTML Export ----
saveWidget(map, OUTPUT_FILE, selfcontained = FALSE)