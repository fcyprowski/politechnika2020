library("shiny")
library("tidyverse")
library("plotly")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  diamonds_filtered <- reactive({
    diamonds %>%
      filter(
        cut == input$cut,
        carat <= input$carat
      )
  })
  output$diamonds_plot1 <- renderPlot({
    diamonds_filtered() %>%
      ggplot(aes(x = carat, y = price)) +
      geom_point()
  })
  output$depth_plot <- renderPlotly({
    diamonds_filtered() %>%
      plot_ly(x = ~depth, y = ~price) %>%
      add_markers(color = ~clarity, size = ~carat, alpha = .2)
  })
})

