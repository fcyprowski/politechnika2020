library("shiny")
library("tidyverse")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$diamonds_plot1 <- renderPlot({
    diamonds %>%
      filter(
        cut == input$cut,
        carat <= input$carat
      ) %>%
      ggplot(aes(x = carat, y = price)) +
      geom_point()
  })
})
