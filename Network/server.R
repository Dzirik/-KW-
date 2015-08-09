## app.R ##
library(shiny)
library(shinydashboard)
library(networkD3)

#
library(RCurl)

server <- function(input, output) {
  
  #-------------------------------------------------------------------------------------------------
  # Create fake data
  src <- c("A", "A", "A", "A", "A",
           "B", "B", "C", "C", "D",
           "E", "F", "F", "G", "G")
  target <- c("B", "C", "D", "J", "J",
              "E", "F", "G", "H", "I",
              "F", "G", "H", "I", "J")
  networkData <- data.frame(src, target)
  
  # Plot
  output$obrSimple<-renderSimpleNetwork({
    simpleNetwork(networkData, zoom=TRUE, height=NULL,width=NULL,linkDistance=input$sliderSimple)
  })
  
  #-------------------------------------------------------------------------------------------------
  data(MisLinks)
  data(MisNodes)
  output$obrForce <- renderForceNetwork({
    forceNetwork(Links = MisLinks, Nodes = MisNodes,
                 Source = "source", Target = "target",
                 Value = "value", NodeID = "name", zoom=TRUE,
                 Group = "group", opacity = input$sliderOpacity, 
                 height=NULL, bounded=FALSE, width=NULL)
  })
}

#shinyApp(ui, server)