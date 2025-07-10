library(shiny)

vars <- names(iris)
vars <- vars[1:4]

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

par(mar = c(5.1, 4.1, 1, 1))

ui <- fluidPage(
  # 
  includeCSS("C:\\Developer\\MSC\\semester B\\R\\shiny\\www\\custom.css"),
  headerPanel("Iris Kmeans clustering"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      sliderInput("k","Select K value for K-means", value=1, min=1, max = 10),
      selectInput("feat","Select features to include in clustering", vars, selected = vars[1], multiple = TRUE),
    ),
  
    # Main panel for displaying outputs ----
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("summary"),
      plotOutput("elbow")
    )
  )
)

server <- function(input, output, session) {
  dataset <- reactive({
    iris[,input$feat]
  })
  clusters <- reactive({
    kmeans(dataset(),input$k)
  })
  output$plot <- renderPlot({
    plot(dataset(),
         col = (clusters())$cluster,
         pch = 20, cex = 3)
    points((clusters())$centers, pch = 4, cex = 4, lwd = 4)
  })
  output$summary <- renderPrint(
    paste("Within cluster sum of squares by cluster:", 
          paste((clusters())$withinss, collapse = " "),
          "between_SS / total_SS = ",
          (clusters())$tot.withinss, 
          collapse = "\n")
  )
  output$elbow <- renderPlot({
    line <- numeric(10)
    for (k in 1:10) {
      line[k] <- kmeans(dataset(), centers = k)$tot.withinss
    }
    plot(1:10, line, type = "b",
         xlab = "Number of Clusters (k)", 
         ylab = "Total Within-Cluster Sum of Squares",
         main = "Elbow Method for Optimal k")
  })
}

shinyApp(ui, server)