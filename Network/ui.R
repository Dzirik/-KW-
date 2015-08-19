## app.R ##
library(shiny)
library(shinydashboard)
library(networkD3)

#
library(RCurl)

ui <- dashboardPage(  
  ## -----------------------------------------------------------------------------------------------
  ##celkový vzhled----------------------------------------------------------------------------------
  ## -----------------------------------------------------------------------------------------------
  skin="yellow",
  
  ## -----------------------------------------------------------------------------------------------
  ## Header content---------------------------------------------------------------------------------
  ## -----------------------------------------------------------------------------------------------
  dashboardHeader(title = "Network Visualization"),
  
  ## -----------------------------------------------------------------------------------------------
  ## Sidebar content--------------------------------------------------------------------------------
  ## -----------------------------------------------------------------------------------------------
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
      menuItem("Complicated Network", tabName = "ForceNetwork", icon = icon("arrows-alt") #,
      ),
      menuItem("Collapsible Network", tabName="CollapsibleForceNetwork",icon=icon("arrows-alt")
      )
    )
  ),
  
  ## -----------------------------------------------------------------------------------------------
  ## Body content-----------------------------------------------------------------------------------
  ## -----------------------------------------------------------------------------------------------
  dashboardBody(
    tabItems(
      #About content--------------------------------------------------------------------------------
      tabItem(tabName="About",
        box(
          title="O programu.",
          "Jednoduchá ukázka programu a rozhraní na vizualizaci a práci se sítěmi/grafy.",
          br(),
          "Data jsou mé vlastní \"výroby\".",
          br(),
          "Obrouvskou výhodou je interaktivita - uživatel může pracovat s grafem, vybírat si prvky,
          které ho zajímají.",
          width=12
        )
      ),
      
      #Simple Network content-----------------------------------------------------------------------
      tabItem(tabName="SimpleNetwork",              
        fluidRow(        
          box(
            title="Natavení",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            width=4,
            "Níže můžete nastavit délku hran mezi uzly.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderSimpleLength", label="Délka hran:", 100, min=0, max=300, step=10)
          ),          
          box(
            title="Nastavení",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            width=4,
            "Níže můžete nastavit, jak moc se uzly odpuzují/přitahují.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderSimpleAttraction", label="Míra odpuzení:", 50, min=-100, max=100, step=5)
          ),
          box(
            title="Nastavení",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            width=4,
            "Níže můžete nastavit velikost písma.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderSimpleFontSize", label="Velikost písma:", 20, min=10, max=30, step=1)
          )
        ),
        
        fluidRow(
          box(
            simpleNetworkOutput("obrSimple",width="100%",height="850px"),
            tags$script('
              document.getElementById("obrSimple").onclick = function() {
                var number = Math.random();
                Shiny.onInputChange("mydata", d.index);
              };
            '),
            width=12
          )
        )
      ),
      
      #Force network content------------------------------------------------------------------------
      tabItem(tabName="ForceNetwork",
        fluidRow( 
          box(
            title="Nastevení",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            width=2,
            "Můžete vybrat příslušnost uzlů do skupin.",
            selectInput(inputId="selectForceGroup",label="Skupina:",choices=list("Koníček"=1,"Pohlaví"=2))
          ),
          box(
            title="Natavení",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            width=2,
            "Níže můžete nastavit velikost písma.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderForceFontSize", label="Velikost písma:", 20, min=10, max=30, step=1)
          ),
          box(
            title="Nastavení",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            width=2,
            "Můžete nastavit průhlednost grafu.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderForceOpacity", label="Průhlednost:", 0.75, min=0, max=1, step=0.1)
          ),
          box(
            title="Nastavení",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            width=2,
            "Níže můžete nastavit délku hran mezi uzly.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderForceLength", label="Délka hran:", 100, min=0, max=300, step=10)
          ),
          box(
            title="Nastavení",
            solidHeader=TRUE,
            collapsible=TRUE,
            height=200,
            width=4,
            "Níže můžete nastavit, jak moc se uzly odpuzují/přitahují.", 
            #br(), 
            #"More box content",
            sliderInput(inputId="sliderForceAttraction", label="Míra odpuzení:", 50, min=-100, max=100, step=5)
          )
        ),
        
        fluidRow(
          box(
            forceNetworkOutput("obrForce",width="100%",height="850px"),
            width=12         
          )      
        )
      ),
      
      #Collapsible Force network content------------------------------------------------------------
      tabItem(tabName="CollapsibleForceNetwork",
              verbatimTextOutput("results"),
        fluidRow(
#           singleton(tags$head(
#             #adds the d3 library needed to draw the plot
#             tags$script(src="http://d3js.org/d3.v3.min.js"),
#             
#             #the js script holding the code to make the custom output
#             tags$script(src="d3.js"),
#             
#             #the stylesheet, paste all that was between the <style> tags from your example in the graph_style.css file
#             tags$link(rel = "stylesheet", type = "text/css", href = "graph_style.css")
#           )),
          box(
            #div(id="obrForceCollapsible",class="d3.forceNetwork"),
            height=500,
            forceNetworkOutput("obrForceCollapsible",width="100%",height="850px"),
            width=12
          )
        )
      )
    )
  )  
)    