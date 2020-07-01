# checkpoint::checkpoint("2020-05-01", R.version = "3.6.3")

setwd("C:/Users/filip.cyprowski/Documents/politechnika2020/aplikacje/test")

if (!require("plumber")) install.packages("plumber")

plumber::plumb('app.R')$run(port = 5000, host = '0.0.0.0')