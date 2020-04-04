library(tidyverse)
library(osmdata)

#available_tags("bicycle")
#available_features()

area_bb = getbb("Lancaster, U.K") # North England

river =
  area_bb %>%
  opq() %>%
  add_osm_feature(key = "waterway") %>%
  osmdata_sf() 

coast =
  area_bb %>%
  opq() %>%
  add_osm_feature(key = 'natural', value = 'coastline') %>%
  osmdata_sf()

### River Wenning
river_wenning = 
  area_bb %>%
  opq() %>%
  add_osm_feature(key = "waterway", value = "river") %>%
  add_osm_feature(key = 'name', value = 'Wenning', value_exact = FALSE) %>%
  osmdata_sf()

### River Lune
river_lune = 
  area_bb %>%
  opq() %>%
  add_osm_feature(key = "waterway", value = "river") %>%
  add_osm_feature(key = 'name', value = 'Lune', value_exact = FALSE) %>%
  osmdata_sf()

river_lune$osm_multilines = 
  river_lune$osm_multiline %>%
  filter(role == "main_stream")

canal = 
  area_bb %>%
  opq() %>%
  add_osm_feature(key = 'waterway', value = 'canal') %>%
  osmdata_sf()



map =
  ggplot() +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "slateblue4",
          size = .2,
          alpha = 0.4) +
  
  geom_sf(data = canal$osm_lines,
          inherit.aes = FALSE,
          color = "lightsteelblue2",
          size = 1,
          alpha = 1) +
  
  geom_sf(data = river_lune$osm_multilines,
          inherit.aes = FALSE,
          color = "slateblue4",
          size = 1,
          alpha = 1) +
  
  geom_sf(data = river_wenning$osm_multilines,
          inherit.aes = FALSE,
          color = "slateblue4",
          size = 1,
          alpha = 1) +
  
  geom_sf(data = coast$osm_lines,
          inherit.aes = FALSE,
          color = "slateblue4",
          size = .2,
          alpha = 1) +
  
  geom_sf_label(data = river_lune$osm_multilines,
                inherit.aes = FALSE,
                aes(label = name)) + 
  
  geom_sf_label(data = river_wenning$osm_multilines,
                inherit.aes = FALSE,
                aes(label = name)) + 
  

geom_sf_label(data = canal$osm_multilines,
              inherit.aes = FALSE,
              label = "Lancaster Canal") + 
  
  coord_sf(xlim = area_bb[1,], 
           ylim = area_bb[2,],
           expand = FALSE) +
  theme_void()

ggsave(filename = "output/lancaster_rivers.png", map)



