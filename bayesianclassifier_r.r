library(e1071)
library(caret)
library(naivebayes)
s=sample(150,100)
iris_train=iris[s,]
iris_test=iris[-s,]
model<-naiveBayes(Species~.,data = iris_train)
pred<-predict(model,iris_test)
View(pred)
confusionMatrix(pred,iris_test$Species)