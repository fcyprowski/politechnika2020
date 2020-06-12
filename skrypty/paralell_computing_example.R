library("parallel")

my_data_frame = ggplot2::diamonds %>%
  select(carat, depth, table, price, x, y, z)
workerFunc = function(nc) {
  set.seed(1234)
  return(sum(kmeans(my_data_frame, centers=nc, iter.max=30)$withinss)) 
}

num_cores = detectCores()
cl = makeCluster(num_cores)
clusterExport(cl, varlist=c("my_data_frame")) 
values = 1:100 # this represents the "nc" variable in the wssplot function
system.time({
  result = parLapply(cl, values, workerFunc)
  })  # paralel execution, with time wrapper
system.time({
  result = lapply(values, workerFunc)
})
stopCluster(cl)