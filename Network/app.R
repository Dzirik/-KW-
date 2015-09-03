## app.R ##
library(shiny)
library(shinydashboard)
library(networkD3)

#
library(RCurl)

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
      
      #Simple Network content
      tabItem(tabName="SimpleNetwork",
        fluidRow(        
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
          ),
          
          box(
            sliderInput("slideSimple","Slider input:",10,10,100)
          )
        ),
        
        fluidRow(
          box(
            simpleNetworkOutput("obrSimple"),
            width=12,
            height=1500
          )
        )
      ),
      
      #Force network content
      tabItem(tabName="ForceNetwork",
        fluidRow(        
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
            ),
                
            box(
              sliderInput("slide","Slider input:",1,10,20),
              height=300
            )
          ),
              
        fluidRow(
          box(
            forceNetworkOutput("obrForce"),
            width=12,
            height=1000
          )      
        )
      )    
    )
  )  
)    
    
### SERVER -----------------------------------------------------------------------------------------
### SERVER -----------------------------------------------------------------------------------------

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

shinyApp(ui, server)