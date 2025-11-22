# Load large wood, river, and bridge data ----
lw_points <- st_read("LargeWood.shp")
river <- st_read("RiverTorridge.shp")
bridges <- st_read("DevonBridgeClipped.shp")

#Convert vectors to CRS 4326
lw_points <- st_transform(lw_points, crs = 4326)
river <- st_transform(river, crs = 4326)
bridges <- st_transform(bridges, crs = 4326)

clusters <- st_read("LW_Clusters.shp")
clusters <- st_transform(clusters, crs = 4326)

# Dynamically generate colours based on number of unique clusters
num_clusters <- length(unique(clusters$CLUSTER_ID))
pal_clusters <- colorFactor(palette = colorRampPalette(brewer.pal(12, "Paired"))(num_clusters), domain = clusters$CLUSTER_ID)

# Load Heatmap
heatmap <- rast("Heatmap.tif")
heatmap <- project(heatmap, crs(river))

# Load slope
slope <- rast("slope.tif")
slope <- project(slope, crs(river))

# Load aspect
aspect <- rast("aspect.tif")
aspect <- project(aspect, crs(river))

# Load nearest distance
nearest_distance <- st_read("NearestDistance.shp")
nearest_distance <- st_transform(nearest_distance, crs = 4326)

# Load large wood catchers
catchers <- st_read("LargeWood_Catchers.shp") 
catchers <- st_transform(catchers, crs = 4326)

pal_heatmap <- colorNumeric(palette = "inferno", domain = na.omit(values(heatmap)), na.color = "transparent")