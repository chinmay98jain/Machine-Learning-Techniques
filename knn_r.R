data("iris")
use_iris<-head(iris,100)
set.seed(2)
use_iris<- use_iris[sample(nrow(use_iris)),]
train_d <- use_iris[1:as.integer(0.5*50),]
test_d <- use_iris[as.integer(0.5*50 +1):50,]

#euclidien distance
eudis<-function(a,b){
  d = 0
  for(i in c(1:(length(a)-1) ))
  {
    d = d + (a[[i]]-b[[i]])^2
  }
  d = sqrt(d)
  return(d)
}

#knn function
knn_pred<-function(train,test,k){
  classpred<-c()
  for(i in c(1:nrow(test))){
    edis<-c()
    evar<-c()
    s=0
    vc=0
    for(j in c(1:nrow(train))){
      edis=c(edis,eudis(test[i,],train[j,]))
      evar=c(evar,as.character(train[j,][5]))
    }
    #eu dataframe created with eu_char & eu_dist columns
    eu <- data.frame(evar, edis)
    eu <- eu[order(eu$edis),]       #sorting eu dataframe to gettop K neighbors
    eu <- eu[1:k,]               #eu dataframe with top K neighbors
    
    for(m in c(1:nrow(eu))){
      if(as.character(eu[m,"evar"]) == "setosa"){
        s = s + 1
      }
      else
        vc = vc + 1
    }
    
    if(s > vc){          
      classpred <- c(classpred, "setosa")
    }
    else {
      classpred <- c(classpred, "Versicolor")
    }
  }
  return(classpred) 
}

predictions <- knn_pred(train_d, test_d, 5) 
test_d[,6] <- predictions

#accuracy function
accuracy <- function(test_data){
  correct = 0
  for(i in c(1:nrow(test_data))){
    if(!(test_data[i,5] == test_data[i,6])){ 
      correct = correct+1
    }
  }
  accu = correct/nrow(test_data) * 100  
  return(accu)
}
print("Accuracy of model is: ")
print(accuracy(test_d))