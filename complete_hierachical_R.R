library(cluster)
hc_complete<-hclust(dist(iris),method="complete")
plot(hc_complete,mean="Hierarchical Clustering complete",cex=0.9)
cut<-cutree(hc_complete,3)
cut
table(cut,iris$Species)