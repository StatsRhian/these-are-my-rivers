library("sf")
library("tidyverse")
library("leaflet")
library("tmap")

rivers <- st_read("data/WatercourseLink.shp", quietly = TRUE)

my_rivers = c("River Lune")

my_rivers = 
  rivers %>%
  filter(name1 %in% my_rivers) %>%
  st_transform(4326) %>%
  st_zm(drop = T, what = "ZM")

leaflet(my_rivers) %>%
  addTiles() %>%
  addPolylines()

tm_shape(my_rivers) +
  tm_lines()

