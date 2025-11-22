# Load packages
install.packages("maps")
install.packages("mapproj")
install.packages("gridExtra")
install.packages("dplyr")
install.packages("rosm")
install.packages("plyr")
install.packages("ggspatial")
install.packages("dbscan")
install.packages("geodata")
install.packages("shiny")
install.packages("leaflet")
install.packages("sf")
install.packages("raster")
install.packages("ggplot2")
install.packages("ggiraph")
install.packages("RColorBrewer")
install.packages("terra")
install.packages("leafem")
install.packages("shinylive")
install.packages("httpuv")

# Load libraries
library(shiny)
library(leaflet)
library(sf)
library(raster)
library(ggplot2)
library(ggiraph)
library(RColorBrewer)
library(terra)
library(leafem)
library(shinylive)
library(httpuv)


options(shiny.maxRequestSize = 1000 * 1024^2)

# Run global script containing all your relevant data ----
source("Global.R")

# Define UI for visualisation
source("UI.R")

ui <- navbarPage("Instream Large Wood on the River Torridge", id = 'nav',
                 tabPanel("Map", 
                          div(class="outer",
                              leafletOutput("map", height = "calc(100vh - 70px)")
                          )
                 )
)

# Define the server that performs all necessary operations
server <- function(input, output, session){
  source("Server_Function.R", local = TRUE)
}

# Run the application
shinyApp(ui, server)


