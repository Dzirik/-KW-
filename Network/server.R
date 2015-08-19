## app.R ##
library(shiny)
library(shinydashboard)
library(networkD3)

#
library(RCurl)

## data---------------------------------------------------------------------------------------------
## -------------------------------------------------------------------------------------------------

MyLinks<-data.frame(source=integer(),
                    target=integer(),
                    value=double(),
                    friends=double())

MyNodes<-data.frame(name=character(),
                    sex=factor(levels=c("male","female")),
                    hobby=factor(levels=c("football","tennis","bike")),
                    size=double(),
                    stringsAsFactors=FALSE)

MyLinks[1,]=c(1,0,10,1)
MyLinks[2,]=c(2,0,10,10)
MyLinks[3,]=c(3,0,10,40)
MyLinks[4,]=c(3,1,10,1)
MyLinks[5,]=c(4,2,10,5)
MyLinks[6,]=c(5,3,10,40)
MyLinks[7,]=c(6,0,10,10)
MyLinks[8,]=c(7,6,10,50)
MyLinks[9,]=c(8,6,10,4)
MyLinks[10,]=c(8,4,10,5)
MyLinks[11,]=c(9,2,10,5)

vel1<-10
vel2<-10
MyNodes[1,]=c("Agnes","female","football",vel1)
MyNodes[2,]=c("Borivoj","male","tennis",vel2)
MyNodes[3,]=c("Ciri","female","tennis",vel1)
MyNodes[4,]=c("Dan","male","football",vel2)
MyNodes[5,]=c("Eva","female","bike",vel1)
MyNodes[6,]=c("Franta","male","football",vel2)
MyNodes[7,]=c("Gustav","male","tennis",vel2)
MyNodes[8,]=c("Honza","male","bike",vel2)
MyNodes[9,]=c("Iva","female","tennis",vel1)
MyNodes[10,]=c("Jirka","male","bike",vel2)

## server-------------------------------------------------------------------------------------------
## -------------------------------------------------------------------------------------------------

server <- function(input, output) {
  
  # Plots ------------------------------------------------------------------------------------------
  output$obrSimple<-renderSimpleNetwork({
    simpleData<-data.frame(Source=MyNodes[MyLinks$source+1,1],Target=MyNodes[MyLinks$target+1,1])
    simpleNetwork(simpleData,linkColour="gray",nodeColour="black",textColour="black",zoom=TRUE,
                  height=50,width=NULL,
                  linkDistance=input$sliderSimpleLength,
                  charge=-20*input$sliderSimpleAttraction,
                  fontSize=input$sliderSimpleFontSize)
  })
  
  output$obrForce <- renderForceNetwork({
    if (input$selectForceGroup=="1"){
      forceNetwork(Links = MyLinks, Nodes = MyNodes,
                   Source = "source", Target = "target",
                   NodeID = "name", zoom=TRUE,
                   Value = "friends", 
                   Group = "hobby", 
                   colourScale=JS("d3.scale.category10()"),
                   height=NULL, bounded=FALSE, width=NULL,legend=TRUE,
                   Nodesize="size",
                   opacity = input$sliderForceOpacity,
                   fontSize=input$sliderForceFontSize,
                   linkDistance=input$sliderForceLength,
                   charge=-20*input$sliderForceAttraction)
    }else{     
      forceNetwork(Links = MyLinks, Nodes = MyNodes,
                   Source = "source", Target = "target",
                   NodeID = "name", zoom=TRUE,
                   Value = "friends", 
                   Group = "sex", 
                   colourScale=JS("d3.scale.category10()"),
                   height=NULL, bounded=FALSE, width=NULL,legend=TRUE,
                   Nodesize="size",
                   opacity = input$sliderForceOpacity,
                   fontSize=input$sliderForceFontSize,
                   linkDistance=input$sliderForceLength,
                   charge=-20*input$sliderForceAttraction)
    }
  })
  
  output$obrForceCollapsible<-renderForceNetwork({
    MyClickScript <- 'Shiny.onInputChange("mydata", d.name);'
    forceNetwork(Links = MyLinks, Nodes = MyNodes,
                 Source = "source", Target = "target",
                 NodeID = "name", zoom=TRUE,
                 Value = "friends", 
                 Group = "sex", 
                 colourScale=JS("d3.scale.category10()"),
                 height=NULL, bounded=FALSE, width=NULL,legend=TRUE,
                 Nodesize="size",
                 clickAction=MyClickScript)
  })
  
  output$results <- renderPrint({
    input$mydata
  })
}

#shinyApp(ui, server)