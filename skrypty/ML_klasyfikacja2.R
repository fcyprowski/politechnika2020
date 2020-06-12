library(caret)

# split danych
split_vector = createDataPartition(iris$Species, p = .7)[[1]]
train_set = iris[split_vector, ]
test_set = iris[-split_vector, ]
# funkcja do robienia modeli
train_models = function(methods, ...) {
  lapply(methods, function(single_method) {
    message(single_method)
    train(Species~., 
          data = train_set, 
          method = single_method, 
          trControl = tr_control, 
          ...)
  })
}
methods = c("rpart", "naive_bayes", "svmRadial", "ctree")
models = train_models(methods)

results = resamples(models)
test_set$predictions = predict(models[[2]], test_set)
confusionMatrix(test_set$predictions, test_set$Species)

