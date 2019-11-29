library(dbscan)
iris_m<- iris[,1:4]
KNNdistplot(iris_m,k=4)
abline(h=0.4,col="red")
db= dbscan(iris_m,0.4,4)
db
hullplot(iris_m,db$cluster)
table(iris$Species,db$cluster)