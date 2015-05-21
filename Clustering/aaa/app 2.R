## app.R ##
library(shiny)
library(shinydashboard)

header <- dashboardHeader(
  ##celkový vzhled----------------------------------------------------------------------------------
  #skin="yellow",
  
  ## Header content---------------------------------------------------------------------------------
  dashboardHeader(title = "Clustering Algorithms")
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Partitioning Clustering", tabName = "Partitioning Clustering", icon = icon("spinner"),
             menuSubItem("K-means",tabName="K-means",icon=icon("gears"))                      
    ),
    menuItem("Hierarchical Clustering", tabName = "hierarchical clustering", icon = icon("spinner"),
             menuSubItem("AGNES",tabName="AGNES",icon=icon("gears")),
             menuSubItem("DIANA",tabName="DIANA",icon=icon("gears"))
    )
  )  
)

body <- dashboardBody(
  tabItems(
    # First tab content
    tabItem(tabName = "Partitioning Clustering",
            fluidRow(
              box(plotOutput("plot1", height = 250)),
              
              box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
              )
            )
    ),
    
    #
    tabItem(tabName= "K-means"
    ),
    
    #
    tabItem(tabName= "Hierarchical Clustering"
    ),
    
    tabItem(tabName="AGNES"
    ),
    
    tabItem(tabName="DIANA"
    )
  )  
)

dashboardPage(header, sidebar, body)


server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)