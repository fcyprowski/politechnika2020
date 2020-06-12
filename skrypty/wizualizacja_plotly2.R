install.packages('https://cran.r-project.org/bin/windows/contrib/3.3/shiny_1.0.5.zip',
                 repos=NULL, type='win.binary')


library(plotly)

wykres = iris %>%
  plot_ly( 
    x = ~Sepal.Length, 
    y = ~Sepal.Width
  ) %>%
  add_markers(alpha = .2, 
              size = ~(Petal.Length * Petal.Width)) %>%
  add_lines(y = ~predict(lm(Sepal.Width~Sepal.Length, data = iris)))

subplot(
  wykres, 
  plot_ly(mpg, x = ~cty, y = ~hwy) %>% 
    add_markers(alpha = 0.2, name = "alpha")
)

# Plotly

subplot(
  plot_ly(mpg, x = ~cty, y = ~hwy, name = "default"),
  plot_ly(mpg, x = ~cty, y = ~hwy) %>% 
    add_markers(alpha = 0.2, name = "alpha"),
  plot_ly(mpg, x = ~cty, y = ~hwy) %>% 
    add_markers(symbol = I(1), name = "hollow")
)



# przewaga nad ggplot2
txhousing %>%
  filter(city %in% unique(city)[1:10]) %>%
  plot_ly(x = ~date, y = ~median) %>%
  add_lines(color = ~city, alpha = 0.2)

if (!require(broom)) install.packages("broom")
if (!require(dplyr)) install.packages("dplyr")
# bardziej zaawansowany przykład z użyciem 
m <- lm(Sepal.Length~Sepal.Width*Petal.Length*Petal.Width,
        data = iris)
d <- broom::tidy(m) %>% 
  arrange(desc(estimate)) %>%
  mutate(term = factor(term, levels = term))
plot_ly(d, x = ~estimate, y = ~term) %>%
  add_markers(error_x = ~list(value = std.error)) %>%
  layout(margin = list(l = 200))


if (!require(maps)) install.packages("maps")
# polygons - np. do malowania map, ale nie tylko
cities = maps::canada.cities
map_data("world", "canada") %>%
  group_by(group) %>%
  plot_ly(x = ~long, y = ~lat, alpha = 0.2) %>%
  add_polygons(hoverinfo = "none", color = I("black")) %>%
  add_markers(text = ~paste(name, "<br />", pop), hoverinfo = "text", 
              color = I("red"), size = ~pop, data = cities) %>%
  layout(showlegend = FALSE,
         xaxis = list(
           title = "",
           zeroline = FALSE,
           showline = FALSE,
           showticklabels = FALSE,
           showgrid = FALSE
         ),
         yaxis = list(
           title = "",
           zeroline = FALSE,
           showline = FALSE,
           showticklabels = FALSE,
           showgrid = FALSE
         ))


# eventy
library(plotly)
library(htmlwidgets)

mtcars$url <- paste0("http://google.com/#q=", rownames(mtcars))

plot_ly(mtcars, x = ~wt, y = ~mpg) %>%
  add_markers(text = rownames(mtcars), customdata = ~url) %>%
  htmlwidgets::onRender("
           function(el, x) {
           el.on('plotly_click', function(d) {
           var url = d.points[0].customdata;
           window.open(url);
           });
           }
           ")
