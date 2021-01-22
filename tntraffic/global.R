library(shiny)
library(tidyverse)
library(ggplot2)
library(shinydashboard)
library(RColorBrewer)
#library(foreign)
library(leaflet)
#library(magrittr)
library(dplyr)
library(plotly)
library(sf)
library(gganimate)

traffic <- read_csv("data/traffic.csv")
#View(traffic)
counties <- read_csv("data/counties_geo.csv")

counties_data <- st_read("data/counties_data.shp")
colnames(counties_data) <- c("county_cd", "county", "lat", "long", "year", "population", "pct_pop_change", "avg_commute_mins", "pct_comm_change", "traffic_growth_rate", "geometry")
#counties_data %<>% st_sf(sf_column_name = 'geometry')
counties_data


# tn_map <- counties_data %>%
#   filter(year == "2018-01-01") %>%
#   ggplot() + geom_sf(color = "black", aes(fill= population))
# tn_map
  