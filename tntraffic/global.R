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

traffic <- read_csv("data/traffic.csv")
#View(traffic)
counties <- read_csv("data/counties_final.csv")

# map_bins <-c(-100, -5, 0, 5, 10, 15, 20, 25, 30, 15000) 
# colors = c("#00b81c", "#fafa00", "#eb0000")
# 
# pal <- colorBin(palette=colors, bins=map_bins)
  
  # ,
  # domain = traffic$pct_change)

#ggplot(traffic %>% filter(pct_change <=100), aes(x=pct_change)) + geom_histogram(bins=100)
#max(traffic$pct_change, na.rm = TRUE)
