output$map <- renderLeaflet({
  leaflet() %>% 
    # Set initial view
    setView(lng = -4.200000, lat = 51.050000, zoom = 9.3) %>%
    
    # Base tiles
    addProviderTiles(providers$OpenStreetMap, group = "Colour") %>%
    
    # Add Bridges
    addCircles(
      data = bridges,
      color = "black",
      fillColor = "purple",
      fillOpacity = 0.8,
      weight = 2,
      radius = 50,
      group = "Bridges"
    ) %>%
    
    # Add Large Wood Catchers
    addCircleMarkers(
      data = catchers,
      color = "black",
      fillColor = "orange",
      fillOpacity = 1,
      weight = 1,
      radius = 6,
      group = "LW_Catchers"
    ) %>%
    
    # Add Clusters
    addCircleMarkers(
      data = clusters,
      color = "black",
      fillColor = ~pal_clusters(CLUSTER_ID),
      fillOpacity = 0.6,
      radius = 6,
      group = "LW_Clusters",
      popup = ~paste("Cluster ID:", CLUSTER_ID)
    ) %>%
    
    # Add Nearest Distance lines
    addPolylines(
      data = nearest_distance,
      color = "blue",
      weight = 3,
      opacity = 0.7,
      group = "Nearest Distance"
    ) %>%
    
    # Add Heatmap raster
    addRasterImage(
      heatmap,
      colors = pal_heatmap,
      opacity = 0.7,
      group = "Heatmap"
    ) %>%
    
    # Add Slope raster
    addRasterImage(
      slope,
      colors = colorNumeric("YlOrRd", values(slope), na.color = "transparent"),
      opacity = 0.7,
      group = "Slope"
    ) %>%
    
    # Add Aspect raster
    addRasterImage(
      aspect,
      colors = colorNumeric("viridis", values(aspect), na.color = "transparent"),
      opacity = 0.7,
      group = "Aspect"
    ) %>%
    
    # Add Layer control
    addLayersControl(
      baseGroups = c("Open Street Map"),
      overlayGroups = c(
        "Bridges",
        "River",
        "LW_Clusters",
        "Heatmap",
        "LW_Catchers",
        "Nearest Distance",
        "Aspect",
        "Slope"
      ),
      options = layersControlOptions(collapsed = FALSE)
    ) %>%
    
    # Hide all overlay groups except bridges initially when loaded until they are ticked
    hideGroup(c(
      "River",
      "LW_Clusters",
      "Heatmap",
      "LW_Catchers",
      "Nearest Distance",
      "Aspect",
      "Slope"
    ))
})
