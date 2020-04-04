library("sf")
library("tidyverse")
library("leaflet")
library("tmap")

rivers <- st_read("data/WatercourseLink.shp")

#my_bbox = st_bbox(rivers)
#my_bbox[1:4] =  c(-3.6781, 53.9912, -2.2672, 54.6623)
#my_bbox = st_as_sfc(my_bbox)

box = c(xmin = 0, ymin = 50, xmax = -3, ymax = 100)


#my_rivers_names = c("River Lune", "Wenning", "Leven")

my_rivers = 
  rivers %>%
  st_join(st_as_sf(st_bbox(box)))
 # filter(name1 %in% my_rivers_names) %>%
  st_transform(4326) %>%
  st_zm(drop = T, what = "ZM")

my_bbox = st_bbox(rivers)
my_bbox[1:4] =  c(-3.6781, 53.9912, -2.2672, 54.6623)
my_bbox = st_as_sfc(my_bbox)

tm_shape(my_rivers, bbox = my_bbox) +
  tm_lines()







