library(dplyr)
library(shiny)
library(plotly)
library(pool)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  conf = config::get(NULL, "default", "config.yaml")$frontend_database
  pool = pool::dbPool(
    RPostgreSQL::PostgreSQL(),
    host = conf$host,
    db = conf$db,
    user = conf$user,
    password = conf$password,
    port = conf$port
  )
  output$markov_results = renderPlotly({
    con = pool::poolCheckout(pool)
    p = tbl(con, "facts_result") %>%
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
    pool::poolReturn(con)
    return(p)
  })
  output$markov_results_longtail = renderPlotly({
    con = pool::poolCheckout(pool)
    p = tbl(con, "facts_result") %>%
      arrange(desc(total_conversions)) %>%
      head(input$channels2) %>%
      collect() %>%
      mutate(channel_name = factor(channel_name, levels = channel_name)) %>%
      plot_ly(y = ~total_conversions, 
              x = ~channel_name) %>% 
      add_bars() %>%
      layout(barmode = "stack")
    pool::poolReturn(con)
    return(p)
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
  
  # onStop(function() DBI::dbDisconnect(con))
})
