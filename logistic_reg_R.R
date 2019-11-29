data("iris")
use_iris<-head(iris,100)
set.seed(2)
use_iris<- use_iris[sample(nrow(use_iris)),]
train_d <- use_iris[1:as.integer(0.5*50),]
test_d <- use_iris[as.integer(0.5*50 +1):50,]
logitMod <- glm(Species ~ Sepal.Width + Sepal.Length + Petal.Width + Petal.Length,data = train_d, family = binomial)
predictedY <- predict(logitMod, test_d, type="response")
lr_data <- data.frame(predictedY,Species=test_d$Species)

#Accuracy of logistic regression model
acc<-function(lr_data){
  right=0
  for(i in c(1:nrow(lr_data))){
    if(lr_data$predictedY<0 && lr_data$Species=="setosa")
      right=right+1
    else if(lr_data$predictedY>0 && lr_data$Species=="versicolor")
      right=right+1
  }
  acculog = right/nrow(lr_data) * 100  
  return(acculog)
}
lr_data
print("Accuracy of model is: ")
print(acc(lr_data))