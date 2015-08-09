## app.R ##
library(shiny)
library(shinydashboard)
library(networkD3)

ui <- dashboardPage(
  ##celkový vzhled----------------------------------------------------------------------------------
  skin="yellow",
  
  ## Header content---------------------------------------------------------------------------------
  dashboardHeader(title = "Network Visualization"),
   
  ## Sidebar content--------------------------------------------------------------------------------
  dashboardSidebar(
    sidebarMenu(
      #template:
      #menuItem("Popisek Itemu", tabName="názevProKód",icon=icon("jménoIkony"),
      #  menuSubItem("K-means",tabName="K-means",icon=icon("gears")) 
      #)
      menuItem("About", tabName="About",icon=icon("file")
      ),
      menuItem("Simple Network", tabName = "SimpleNetwork", icon = icon("arrows-alt") #,                    
      ),
      menuItem("Force Network", tabName = "ForceNetwork", icon = icon("arrows-alt") #,
      )
    )
  ),
  
  ## Body content-----------------------------------------------------------------------------------
  dashboardBody(
    tabItems(
      #About content
      tabItem(tabName="About",
        h2("tady bude text")
      ),
      
      #Force network content
      tabItem(tabName="ForceNetwork",
        h2("tady bude obsah")
      ),
      
      #Simple Network content
      tabItem(tabName="SimpleNetwork",
        fluidRow(
          box(plotOutput("plot1")
          ),
          
          box(
            title="Nadpis",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=300,
            "Box content here", 
            br(), 
            "More box content",
            sliderInput("slider", "Slider input:", 1, 100, 50),
            textInput("text", "Text input:")
          )
        )
      )      
    )
  )  
)    
    
### SERVER -----------------------------------------------------------------------------------------
### SERVER -----------------------------------------------------------------------------------------

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
   
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)