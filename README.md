![R basic check](https://github.com/franc225/hikingdashboard/actions/workflows/r-script-check.yml/badge.svg)

# Hiking Dashboard – GPX Trail Visualization

This project is a personal hiking dashboard built with R and Leaflet.  
It visualizes hiking and walking routes exported from Strava GPX files and displays them on an interactive map.

The goal of this project is to provide a simple, reliable, and extensible base for exploring personal hiking data, without databases, APIs, or heavy dashboards.

---

## Features (v1.1)

- Loads multiple GPX track files from a local `data/` folder
- Interactive Leaflet map rendered in the RStudio Viewer
- Single trail color for visual consistency
- Frequency of passage shown naturally by line overlap
- Distance computed for each GPX track
- Popups displaying trail name and distance
- Summary table embedded directly in the map:
  - number of passages per trail
  - average distance
  - total cumulative distance
- Optional HTML export of the map

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

- `output/`  
  Contains the generated HTML map (optional).

- `generate_map.R`  
  Main script that loads GPX files, computes distances, and renders the map.

---

## Requirements

- R (recent version)
- R packages:
  - `sf`
  - `leaflet`
  - `stringr`
  - `dplyr`
  - `magrittr`
  - `htmlwidgets`

Packages can be installed with:

```r
install.packages(c("sf", "leaflet", "stringr", "dplyr", "magrittr", "htmlwidgets"))