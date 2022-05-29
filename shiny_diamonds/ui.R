library("shiny")
library("plotly")

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    title = "Diamonds Dashboard",
    tabPanel(
      "Carat vs Price", 
      sidebarLayout(
        sidebarPanel(
          selectInput(
            "cut", "Cut:",
            choices = unique(diamonds$cut),
            selected = "Good"
          ),
          sliderInput(
            "carat", "Carat level:",
            min = min(diamonds$carat),
            max = max(diamonds$carat) + 0.25, 
            value = max(diamonds$carat) + 0.25, 
            step = 0.05
          )
        ),
        mainPanel(
          plotOutput("diamonds_plot1")
        )
      )
    ),
    tabPanel(
      "Plotly",
      plotlyOutput("depth_plot")
    ),
    tabPanel("tab 3", "contents")
  )
  
)
