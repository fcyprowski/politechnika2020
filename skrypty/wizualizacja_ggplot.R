if (!require(ggplot2)) install.packages('ggplot2')
library(ggplot2)

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(aes(color = Species)) +
  geom_text(aes(label = Sepal.Length * Sepal.Width)) +
  theme(panel.background = element_blank(),
        axis.title = element_text(size = 1),
        axis.ticks = element_line(colour = "red")) +
  labs(title = "Testowy wykresik")


