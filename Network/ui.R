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
        box(
          title="About this program.",
          "This is an example of visualization graphs using shiny and network3D.",
          br(),
          "I used only simple data, which I personaly generated or taken from RCurl package from R.
          The reason for this was that I wanted only easily obtained small data sets and spent much 
          time with plaing with their visualization.",
          br(),
          "The advantage of this approach is interactivity, just play with nodes, edges, and network using a mouse.",
          width=12
        )
      ),
      
      #Simple Network content
      tabItem(tabName="SimpleNetwork",
        fluidRow(        
          box(
            title="Settings",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            "You can choose distance of edges in the graph below.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderSimple", label="Edge distance:", 150, min=0, max=300, step=10)
          )
        ),
        
        fluidRow(
          box(
            simpleNetworkOutput("obrSimple"),
            width=12
          )
        )
      ),
      
      #Force network content
      tabItem(tabName="ForceNetwork",
        fluidRow(        
          box(
            title="Settings",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            "You can choose opacity for the graph below.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderOpacity", label="Opacity:", 0.5, min=0, max=1, step=0.1)
          ),
          
          box(
            title="Data Description",
            solidHeader=TRUE,
            collapsing=TRUE,
            height=200,
            "A data file of links from Knuth's Les Miserables characters data base.",
            br(),
            "A data set with 254 observations of 3 variables."
          )
        ),
        
        fluidRow(
          box(
            forceNetworkOutput("obrForce"),
            width=12
          )      
        )
      )
    )
  )  
)    