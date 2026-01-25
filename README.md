# Hiking Dashboard – GPX Trail Visualization

This project is a personal hiking dashboard built with R and Leaflet. 
It visualizes hiking and walking routes exported from Strava GPX files and displays them on an interactive map.

The goal of this first version is intentionally simple:
- Load GPX tracks from a local folder
- Display all trails on a map
- Visually highlight frequently used paths through line overlap

No database, no API, no automation — just a clean and reliable base.

---

## Features (v1)

- Reads multiple GPX files from a local `data/` folder
- Interactive Leaflet map rendered in RStudio
- Single trail color for visual consistency
- Frequency of passage shown naturally by line overlap
- Minimal, stable R script (no fragile HTML tricks)

---

## Project Structure

hikingdashboard/
├── data/
│ ├── hike_1.gpx
│ ├── hike_2.gpx
│ └── ...
├── generate_map.R
└── README.md

- `data/`  
  Contains GPX files exported from Strava (or Garmin via Strava sync).

- `generate_map.R`  
  Main script that loads GPX files and renders the map.

---

## Requirements

- R (recent version)
- R packages:
  - `sf`
  - `leaflet`
  - `stringr`

Packages can be installed with:

```r
install.packages(c("sf", "leaflet", "stringr"))