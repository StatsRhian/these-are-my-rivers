#Scratch

geom_sf_label(data = my_rivers$osm_lines,
inherit.aes = FALSE,
aes(label = name),
position = position_nudge(x = -0.00)) +


streets =
 lancaster_bb %>%
 opq ()%>%
 add_osm_feature(key = "highway",
                 value = c("motorway", "primary",
                           "secondary", "tertiary")) %>%
 osmdata_sf()

small_streets =
 lancaster_bb %>%
 opq()%>%
 add_osm_feature(key = "highway",
                 value = c("residential", "living_street",
                           "unclassified",
                           "service", "footway")) %>%

cycle =
 lancaster_bb %>%
 opq() %>%
 add_osm_feature(key = "highway", value = "cycleway") %>%
 osmdata_sf()
