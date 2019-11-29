model<-naiveBayes(Species~.,data = iris_t)
pred<-predict(model,iris_test)
view(pred)
confusionMatrix(pred,iris_test$Species)
