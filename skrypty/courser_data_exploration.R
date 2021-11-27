if (!require("tidyverse")) install.packages("tidyverse") 
library("tidyverse")

coursea_data <- read_csv("coursea_data.csv")

cleaned_data <- coursea_data %>%
  mutate(
    course_students_enrolled_number = str_remove_all(
      course_students_enrolled,
      "[a-z]"
    ) %>% as.numeric(),
    course_students_enrolled_k_or_m = str_extract_all(
      course_students_enrolled,
      "[a-z]"
    ),
    students_enrolled = ifelse(
      course_students_enrolled_k_or_m == "m",
      course_students_enrolled_number * 10^6,
      course_students_enrolled_number * 10^3
    )
  ) %>% 
  select(
    !contains("course_students_enrolled")
  )


# Podsumowanie - z ktorych organizacji sa kursy? --------------------------

cleaned_data %>%
  group_by(course_organization) %>%
  summarise(
    n = n()
  ) %>%
  arrange(desc(n)) %>%
  mutate(
    percent = n / sum(n)
  )

# to samo mozna osiagnac pakietem janitor
install.packages("janitor")
library("janitor")
tabyl(cleaned_data, course_organization)
janitor::tabyl(cleaned_data, course_organization)

# w samym dplyrze tez jest funkcja ktora to robi
count(cleaned_data, course_organization)
cleaned_data %>% count(course_organization)


# Czy poziom kursu wplywa na ocene ----------------------------------------

cleaned_data %>%
  group_by(course_difficulty) %>%
  summarise(
    avg_rating = mean(course_rating),
    median_rating = median(course_rating)
  )

cleaned_data %>%
  ggplot(aes(x = course_rating)) +
  geom_density(
    aes(fill = course_difficulty, 
        color = course_difficulty),
    alpha = .2
  ) +
  # facet_wrap(~course_difficulty, scales = "free") +
  theme_minimal()



# Korelacja oceny kursu z liczba zarejestrowanych -------------------------

cleaned_data %>%
  select(where(is.numeric)) %>%
  cor()

cleaned_data %>%
  ggplot(
    aes(x = course_rating, y = students_enrolled)
  ) +
  geom_point(alpha = .05, 
             aes(color = course_Certificate_type)) +
  facet_wrap(~course_difficulty) +
  theme_minimal() +
  ylim(c(0, 10^5))


# Kursy z data science ----------------------------------------------------

cleaned_data %>%
  filter(course_organization == "Amazon Web Services")
cleaned_data %>%
  filter(students_enrolled > 10^6)

cleaned_data %>%
  filter(
    str_detect(
      course_title,
      "[Dd]ata.[Ss]cience|[Mm]achine.[Ll]earning| [Rr] "
    )
  ) %>%
  View()
  



