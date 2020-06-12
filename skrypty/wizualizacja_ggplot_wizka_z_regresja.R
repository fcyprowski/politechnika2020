library(ggplot2)

install.packages('ggplot2')
library(ggplot2)

head(iris)

our_theme = theme(
  panel.background = element_blank(), 
  axis.title = element_text(size = 8)
)

ggplot(iris, 
       aes(x = Sepal.Length,
           y = Petal.Length)) +
  geom_point(aes(color = Species)) +
  geom_line(aes(y = predict(lm(Petal.Length~Sepal.Length,
                               data = iris)),
                x = Sepal.Length,
                group = 1)) +
  our_theme +
  labs(title = "Iris plot", 
       subtitle = "example", 
       caption = "Source: R")
