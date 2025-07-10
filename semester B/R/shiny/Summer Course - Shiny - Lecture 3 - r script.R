library(shiny) #install.packages("shiny")
library(bslib) #install.packages("bslib")
library(ISLR)
library(tree)


attach(Carseats)
# View(Carseats)
# str(Carseats)
vars <- names(Carseats)
# expvars <- setdiff(names(Carseats), "Sales")



# Define UI for the app ----
ui <- fluidPage(
  theme = bs_theme(bootswatch = "minty"),
  # 
  headerPanel("Decision Trees"),
  # App title ----
  titlePanel("Plot the variables, train a model and truncate the model"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      selectInput('ycol', 'Y Variable', vars, selected = vars[[1]]),
      selectInput('xcol', 'X Variable', vars, selected = vars[[2]]),
      
      selectInput(
        "dep", "Select the dependent variable", vars, selected = vars[[1]],
      ),
      
      selectInput(
        "ind", "Select the explanatory variables", vars, selected = vars[[2]],
        multiple = TRUE
      ),
      
      
      # actionButton(
      #   inputId = "createModel",
      #   label = "Create Model",
      #   class = "btn-primary"  # makes it blue!
      # ),
      
      
      # # Input: Slider for the number of bins ----
      # numericInput(inputId = "nodes",
      #              label = "Number of terminal nodes:",
      #              value = 2,
      #              min = 1,
      #              max = 50,
      #              step = 1),
      
      
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "nodes",
                  label = "Number of terminal nodes:",
                  value = 2,
                  min = 1,
                  max = 50,
                  step = 1)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: ScatterPlot ----
      plotOutput(outputId = "scatterplot"),
      
      # Output: TreeSummary ----
      verbatimTextOutput("treesummary"),
      
      # Output: Plot the Tree ----
      plotOutput(outputId = "dtree"),
      
      # Output: TreeSummary ----
      verbatimTextOutput("treebreakdown"),
      
      # # Output: CV Plot ----
      # plotOutput(outputId = "cvplot")
      
      # Output: Plot the Pruned Tree ----
      plotOutput(outputId = "pdtree")
      
    )
  )
)




# Define server logic required ----
server <- function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    Carseats[, c(input$xcol, input$ycol)]
  })
  
  
  # Combine the modeling variables into a new data frame
  #not needed
  #ModelingData <- reactive({
  #  Carseats[, c(input$dep, input$ind)]
  #})
  
  # Create the formula of the model
  form <- reactive({
    f = paste(input$dep, "~", paste(input$ind, collapse = " + "))
  })
  
  # Train the model
  trainedmodel <- reactive({
    tree(as.formula(form()),Carseats)
  })
  
  # cvedmodel <- reactive({
  #   cv.tree(trainedmodel())
  # })
  
  prunedtree <- reactive({
    prune.tree(trainedmodel(),best=input$nodes)
  })

  
  output$scatterplot <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(oma=c(3,0,0,0))
    par(mar = c(4, 4, 3, 3))
    plot(selectedData(),main = "Scatter Plot",
         xlab = input$xcol, ylab = input$ycol,
         pch = 19, frame = TRUE
         )
    abline(lm(get(input$ycol) ~ get(input$xcol), data = selectedData()), col = "#E41A1C")
  })
  
  
  output$treesummary <- renderPrint({ 
    summary(trainedmodel()) 
  })
  
  
  
  output$dtree <- renderPlot({
    plot(trainedmodel())
    text(trainedmodel(),pretty=0)
  })
  
  
  output$treebreakdown <- renderPrint({ 
    trainedmodel() 
  })
  
  
  # output$cvplot <- renderPlot({
  #   plot(cvedmodel()$size,cvedmodel()$dev,type='b')
  # })
  

  output$pdtree <- renderPlot({
    plot(prunedtree())
    text(prunedtree(),pretty=0)
  })
  
}

shinyApp(ui = ui, server = server)
