library(shiny)

ui <- fluidPage(
  # main title and text
  titlePanel("Clustering Tutorial with Shiny"),
  p("This is a simple tutorial for k-means clustering with Iris data set. 
    You can set the parameters in the left part and then see the changes in the figure."),  
  
  # Sidebar with a number of clusters
  sidebarLayout(
    sidebarPanel(
      p("You can select the number of clusters in following part from 1 to 6. This part is reacting GUI, so you can see immediate
      change in the 'Clustering Plot' on the right side."),
      sliderInput("nOfClusters",
                  "Number of Clusters:",
                  min = 1,
                  max = 6,
                  value = 3),
      
      p("Moreover, you can select the maximal number of iterations here."),
      numericInput("maxNOfIteration", "Maximal Number of Iterations:", value = 1,min = 1, max = 10),
      
      p("When you can rerun the clutering again with the same parameters, please push this button."),
      actionButton("go", "Rerun"),
      strong(div("It is possible that the results will be the same; there is some randomisation in the algorithm. 
        For different resuls try lower number of iteration 
        and/or higher number of clusters. After that the results will change when you push the button.", style = "color:red"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      strong("Clustering Plot"),
      p("It shows the results of clustering with selected parameters 'Number of Clusters' and 'Maximal Number of Iterations'.
        Membeship to the cluster is marked by the same color and there is a centroid of each cluster there too."),
      strong("True Class Plot"),
      p("This plot shows the original class labels for the data set."),
      strong("Table"),
      p("The values for all observations are in this table."),
      tabsetPanel(type="tabs",
                  tabPanel("Clustering Plot",plotOutput("ClusterPlot")),
                  tabPanel("True Classes Plot",plotOutput("TruePlot")),
                  tabPanel("Table",tableOutput("table"))
      )
    )
  )
)  

server <- function(input, output) {
  #true classes plot
  output$TruePlot <- renderPlot({    
    plot(iris[iris[,5]=="setosa",c(1,3)],
         main="Original",
         pch=0,
         xlim=c(min(iris[,1]),max(iris[,1])),
         ylim=c(min(iris[,3]),max(iris[,3])),
         asp=1)
    points(iris[iris[,5]=="virginica",c(1,3)],pch=16)
    points(iris[iris[,5]=="versicolor",c(1,3)],pch=3)
    plotOutput("whatever", height="auto")
  })
  
  #clustering plot with selected parameters
  output$ClusterPlot <-renderPlot({ 
    input$go
    irisClustering<-kmeans(iris[,c(1,3)],centers=input$nOfClusters,iter.max=input$maxNOfIteration)
    plot(iris[,c(1,3)],col=irisClustering$cluster, asp=1)
    points(irisClustering$centers,col=1:input$nOfClusters,pch=8,cex=2)     
  })
  
  #table
  output$table <- renderTable({
    iris[,c(5,1,3)]
  })  
}

shinyApp(ui = ui, server = server)