library(cluster)
results<-kmeans(iris[,1:4],3)
results
table(iris$Species,results$cluster)
plot(iris[,-5],col=results$cluster)