install.packages('https://cran.r-project.org/bin/windows/contrib/3.3/shiny_1.0.5.zip',
                 repos=NULL, type='win.binary')


library(plotly)

plot_ly(iris, 
        x = ~Sepal.Length, 
        y = ~Sepal.Width)

plot_ly(mpg, x = ~cty, y = ~hwy) %>%
  add_markers(alpha = .2, size = ~cyl) 


iris = mutate(
  group_by(iris, Species),
  norm = Sepal.Length - mean(Sepal.Length)
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
plot_ly(txhousing, x = ~date, y = ~median) %>%
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
map_data("world", "canada") %>%
  group_by(group) %>%
  plot_ly(x = ~long, y = ~lat, alpha = 0.2) %>%
  add_polygons(hoverinfo = "none", color = I("black")) %>%
  add_markers(text = ~paste(name, "<br />", pop), hoverinfo = "text", 
              color = I("red"), data = maps::canada.cities) %>%
  layout(showlegend = FALSE)


# eventy
library(plotly)
library(htmlwidgets)

mtcars$url <- paste0("http://google.com/#q=", rownames(mtcars))

p <- plot_ly(mtcars, x = ~wt, y = ~mpg) %>%
  add_markers(text = rownames(mtcars), customdata = ~url) %>%
  htmlwidgets::onRender("
           function(el, x) {
           el.on('plotly_click', function(d) {
           var url = d.points[0].customdata;
           window.open(url);
           });
           }
           ")
