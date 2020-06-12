library(shiny)
library(dplyr)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  tabsetPanel(
    tabPanel(
      "attribution-results",
      numericInput(
        "channels",
        "How many channels should be here?", 
        value = 8
      ),
      plotlyOutput("markov_results"),
      numericInput(
        "channels2",
        "How many channels should be here?", 
        value = 12
      ),
      plotlyOutput("markov_results_longtail")
    ),
    tabPanel(
      "chain"
    )
  )
))

