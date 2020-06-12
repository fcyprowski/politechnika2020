if (!require(readr)) install.packages("readr")
library(readr)

# zapisywanie
getwd()
setwd("C:/Users/filip.cyprowski/Documents/politechnika")
write_csv(iris, "iris.csv")
write_csv2(iris, "iris.csv")
pelna_sciezka = paste(getwd(), "iris.csv", sep = "/")
write_csv(iris, "C:/Users/filip.cyprowski/Documents/politechnika/iris.csv")

# wczytywanie
dane = read_csv("iris.csv", 
                col_names = T, 
                na = c("<NA>", "null"))
dane = read_delim("iris.csv", delim = ";")

# wczytywanie awaryjne
dane_raw = read_lines("iris.csv") %>% 
  lapply(strsplit, split = ";")

if (!require(jsonlite)) install.packages("jsonlite")
# stworzyc jsona
library(dplyr)
toJSON(iris, pretty = T) %>% write("iris.json")
json_parsed = fromJSON("iris.json")

# R-owe formaty
# .RData
x = 5
y = 19
z = 100
save(x, y, z, file = "xyz.RData")

x = 10
y = 100
z = 1001
load("xyz.RData")

# .rds
saveRDS(iris, "iris.rds")
new_iris = readRDS("iris.rds")


