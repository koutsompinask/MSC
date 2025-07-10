###############################################################################################
###                                     Basic UI                                            ###
###############################################################################################
######################################
###       Inputs - Free text       ###
######################################
ui <- fluidPage(
  textInput("name", "What's your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3)
)
server <- function(input, output, session) {
}
shinyApp(ui, server)


######################################
###      Numeric inputs            ###
######################################
ui <- fluidPage(
  numericInput("num", "Number one", value = 0, min = 0, max = 100, step = 1),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100, step = 1),
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100, step = 1)
)
server <- function(input, output, session) {
}
shinyApp(ui, server)


######################################
###      Inputs - Dates            ###
######################################
ui <- fluidPage(
  dateInput("dob", "When were you born?"),
  dateRangeInput("holiday", "When do you want to go on vacation next?")
)
server <- function(input, output, session) {
}
shinyApp(ui, server)


######################################
###     Inputs - Limited Choices   ###
######################################
animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")

ui <- fluidPage(
  selectInput("state", "What's your favourite state?", state.name),
  radioButtons("animal", "What's your favourite animal?", animals)
)
server <- function(input, output, session) {
}
shinyApp(ui, server)

## ----
ui <- fluidPage(
  radioButtons("rb", "Choose one:",
               choiceNames = list(
                 icon("angry"),
                 icon("smile"),
                 icon("sad-tear")
               ),
               choiceValues = list("angry", "happy", "sad")
  )
)
#> This Font Awesome icon ('angry') does not exist:
#> * if providing a custom `html_dependency` these `name` checks can 
#>   be deactivated with `verify_fa = FALSE`
#> This Font Awesome icon ('smile') does not exist:
#> * if providing a custom `html_dependency` these `name` checks can 
#>   be deactivated with `verify_fa = FALSE`
#> This Font Awesome icon ('sad-tear') does not exist:
#> * if providing a custom `html_dependency` these `name` checks can 
#>   be deactivated with `verify_fa = FALSE`
server <- function(input, output, session) {
}
shinyApp(ui, server)

## ----
ui <- fluidPage(
  selectInput(
    "state", "What's your favourite state?", state.name,
    multiple = TRUE
  )
)
server <- function(input, output, session) {
}
shinyApp(ui, server)

## ----
ui <- fluidPage(
  checkboxGroupInput("animal", "What animals do you like?", animals)
)
server <- function(input, output, session) {
}
shinyApp(ui, server)

## ----
ui <- fluidPage(
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?")
)
server <- function(input, output, session) {
}
shinyApp(ui, server)


######################################
###    Inputs - File uploads       ###
######################################
ui <- fluidPage(
  fileInput("upload", NULL)
)
server <- function(input, output, session) {
}
shinyApp(ui, server)


######################################
###    Inputs - Action buttons     ###
######################################
ui <- fluidPage(
  actionButton("click", "Click me!"),
  actionButton("drink", "Drink me!", icon = icon("cocktail"))
)
#> This Font Awesome icon ('cocktail') does not exist:
#> * if providing a custom `html_dependency` these `name` checks can 
#>   be deactivated with `verify_fa = FALSE`
server <- function(input, output, session) {
}
shinyApp(ui, server)

## ----
ui <- fluidPage(
  fluidRow(
    actionButton("click", "Click me!", class = "btn-danger"),
    actionButton("drink", "Drink me!", class = "btn-lg btn-success")
  ),
  fluidRow(
    actionButton("eat", "Eat me!", class = "btn-block")
  )
)
server <- function(input, output, session) {
}
shinyApp(ui, server)



######################################
###       Outputs -  Text          ###
######################################
ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("code")
)
server <- function(input, output, session) {
  output$text <- renderText({ 
    "Hello friend!" 
  })
  output$code <- renderPrint({ 
    summary(1:10) 
  })
}
shinyApp(ui, server)

## ----
server <- function(input, output, session) {
  output$text <- renderText("Hello friend!")
  output$code <- renderPrint(summary(1:10))
}
shinyApp(ui, server)

## ----
ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("print")
)
server <- function(input, output, session) {
  output$text <- renderText("hello!")
  output$print <- renderPrint("hello!")
}
shinyApp(ui, server)


######################################
###       Outputs - Tables         ###
######################################
ui <- fluidPage(
  tableOutput("static"),
  dataTableOutput("dynamic")
)
server <- function(input, output, session) {
  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
}
shinyApp(ui, server)


######################################
###       Outputs - Plots          ###
######################################
ui <- fluidPage(
  plotOutput("plot", width = "400px")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96)
}
shinyApp(ui, server)

