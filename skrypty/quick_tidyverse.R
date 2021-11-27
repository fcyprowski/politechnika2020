if (!require("tidyverse")) install.packages("tidyverse") 
library("tidyverse")


iris
as_tibble(iris)


iris %>%
  group_by(Species) %>%
  summarise(
    avg_petal_length = mean(Petal.Length),
    median_petal_length = median(Petal.Length)
  ) %>%
  mutate(
    avg_petal_length_plus = avg_petal_length + 10
  ) %>%
  pivot_longer(
    c("avg_petal_length",
      "median_petal_length",
      "avg_petal_length_plus")
  )

1:10 %>%
  sum() %>%
  sqrt() %>%
  paste("pierwiastek z sumy wektora")
# %>% - ctrl+shift+m