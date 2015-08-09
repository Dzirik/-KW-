## app.R ##
library(shiny)
library(shinydashboard)
library(networkD3)

#
library(RCurl)

server <- function(input, output) {
  
  #-------------------------------------------------------------------------------------------------
  # Create fake data
  src <- c("A", "A", "A", "A",
           "B", "B", "C", "C", "D")
  target <- c("B", "C", "D", "J",
              "E", "F", "G", "H", "I")
  networkData <- data.frame(src, target)
  
  # Plot
  output$obrSimple<-renderSimpleNetwork({
    simpleNetwork(networkData, height=NULL,width=NULL)
  })
  
  #-------------------------------------------------------------------------------------------------
  data(MisLinks)
  data(MisNodes)
  output$obrForce <- renderForceNetwork({
    forceNetwork(Links = MisLinks, Nodes = MisNodes,
                 Source = "source", Target = "target",
                 Value = "value", NodeID = "name", zoom=TRUE,
                 Group = "group", opacity = input$opacity, 
                 height=NULL, width=NULL)
  })
}

#shinyApp(ui, server)