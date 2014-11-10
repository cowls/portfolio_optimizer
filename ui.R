library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Portfolio Optimizer"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      h3("Configure Portfolio"),
      p("Information calculated using historical data from 2008-01-01 until yesterday"),
      textInput("w0", label="Total Investment $"),
      textInput("asset1", label="Asset 1"),
      textInput("asset2", label="Asset 2"),
      submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h3("Summary"),
        dataTableOutput("data_table"),
        plotOutput("asset1_plotReturns")
    )
  )
))