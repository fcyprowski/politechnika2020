library(dplyr)
library(shiny)
library(plotly)
library(pool)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  con = DBI::dbConnect(
    RPostgreSQL::PostgreSQL(),
    host = 'politechnika.postgres.database.azure.com',
    db = "postgres",
    user = "filipcyprowski@politechnika",
    password = Sys.getenv("PASSWORD"),
    port = 5432
  )
  output$markov_results = renderPlotly({
    tbl(con, "facts_result") %>%
      arrange(desc(total_conversions)) %>%
      head(input$channels) %>%
      collect() %>%
      mutate(channel_name = factor(channel_name, levels = channel_name),
             hover_text = paste(channel_name, total_conversions, paste0("(", round(100 * total_conversions / sum(total_conversions)), "%)"))) %>%
      plot_ly(x = 0, 
              y = ~total_conversions, 
              color = ~channel_name,
              text = ~hover_text) %>% 
      add_bars() %>%
      layout(barmode = "stack")
  })
  output$markov_results_longtail = renderPlotly({
    tbl(con, "facts_result") %>%
      arrange(desc(total_conversions)) %>%
      head(input$channels2) %>%
      collect() %>%
      mutate(channel_name = factor(channel_name, levels = channel_name)) %>%
      plot_ly(y = ~total_conversions, 
              x = ~channel_name) %>% 
      add_bars() %>%
      layout(barmode = "stack")
  })
  # output$removal_effects = renderPlot(
  #   
  # )
  # output$popular_paths = renderPlot(
  #   
  # )
  # output$transition_probabilities = renderPlot(
  #   
  # )
  
  onStop(function() DBI::dbDisconnect(con))
})
