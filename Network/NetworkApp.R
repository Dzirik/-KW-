## app.R ##
# 21.05.2015
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
      menuItem("About", tabName="About",icon=icon("file")
      ),
      menuItem("Simple Network", tabName = "SimpleNetwork", icon = icon("arrows-alt") #,
        #menuSubItem("K-means",tabName="K-means",icon=icon("gears"))                      
      ),
      menuItem("Force Network", tabName = "ForceNetwork", icon = icon("arrows-alt") #,
        #menuSubItem("AGNES",tabName="AGNES",icon=icon("gears")),
        #menuSubItem("DIANA",tabName="DIANA",icon=icon("gears"))
      ),
      
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", icon = icon("th"), tabName = "widgets",
               badgeLabel = "new", badgeColor = "green")
    )
  ),
  
  
  ## Body content-----------------------------------------------------------------------------------
  dashboardBody(
    tabItems(
      
            #Simple Network content
            tabItem(tabName="SimpleNetwork",
              fluidRow(
                box(plotOutput("plot1")),
                
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
            ),
            tabItem(tabName = "dashboard",
                    h2("Dashboard tab content")
            ),
            
            tabItem(tabName = "widgets",
                    h2("Widgets tab content")
            )      
    )
    
    
    
#     tabItems(
#       #About content
#       tabItem(tabName="About",
#               h2("tady bude text")
#       ),
#       
#       #Simple Network content
#       tabItem(tabName="SimpleNetwork",
#         fluidRow(
#           box(plotOutput("plot1")),
#           
#           box(
#             title="Nadpis",
#             solidHeader=TRUE,
#             collapsible=TRUE,
#             height=300,
#             "Box content here", 
#             br(), 
#             "More box content",
#             sliderInput("slider", "Slider input:", 1, 100, 50),
#             textInput("text", "Text input:")
#           )
#         )
#       ),
#     
#       #Force network content
#       tabItem(tabName="ForceNetwork",
#         h2("tady bude obsah")
#       ),
#       
#       tabItem(tabName = "dashboard",
#               h2("Dashboard tab content")
#       ),
#       
#       tabItem(tabName = "widgets",
#               h2("Widgets tab content")
#       )
#     )
    
    #tabItems(
      # First tab content
      #tabItem(tabName = "Simple Network",
      #        fluidRow(
#                 box(plotOutput("plot1", height = 250)),
#                 
#                 box(
#                   title = "Controls",
#                   sliderInput("slider", "Number of observations:", 1, 100, 50)
#                 )
#               )
#       ),
      
      #
      #tabItem(tabName= "K-means"
      #),
#     )
#   )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
   
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)