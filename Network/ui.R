shinyUI(fluidPage(
  ##celkový vzhled----------------------------------------------------------------------------------
  skin="yellow",
  
  ## Header content---------------------------------------------------------------------------------
  dashboardHeader(title = "Network Visualization"),
  
  ## Sidebar content--------------------------------------------------------------------------------
  dashboardSidebar(
    sidebarMenu(
      menuItem("About", tabName="About",icon=icon("file")
      ),
      menuItem("Simple Network", tabName = "Partitioning Clustering", icon = icon("arrows-alt") #,
               #menuSubItem("K-means",tabName="K-means",icon=icon("gears"))                      
      ),
      menuItem("Second Vatiant", tabName = "hierarchical clustering", icon = icon("arrows-alt") #,
               #menuSubItem("AGNES",tabName="AGNES",icon=icon("gears")),
               #menuSubItem("DIANA",tabName="DIANA",icon=icon("gears"))
      )
    )
  ),
  
  
  ## Body content-----------------------------------------------------------------------------------
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "Simple Network",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      #
      #tabItem(tabName= "K-means"
      #),
    )
  )  
))