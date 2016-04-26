#K-medoids clustering
#------------------------------------------------------------

# Prepare Data
mydata <- read.csv("flow_features.csv", sep = ";")
mydata <- na.omit(mydata) # listwise deletion of missing
mydata <- scale(mydata) # standardize variables 

# K-Medoids Cluster Analysis:best k value
library(fpc)
library(cluster)
asw <- numeric(nrow(mydata)-1)
for (k in 2:(nrow(mydata)-1))
  asw[[k]] <- pam(mydata, k) $ silinfo $ avg.width
k.best <- which.max(asw)

#To get  rerpoducible results, uncomment this line:). R uses random centroids if this line is not defined
#set.seed(1)

#run the k-medoids:
fit <- kmeans(mydata, k.best) # with k cluster 

# get cluster means
ag<- aggregate(mydata,by=list(fit$cluster),FUN=mean)
# append cluster assignment
mydata <- data.frame(mydata, fit$cluster)

#plot the solution

# vary parameters for most readable graph

#clusplot(mydata, fit$cluster, color=TRUE, shade=TRUE,labels=2, lines=0)
pdf("kmedoidsClustering.pdf")
clusplot(mydata, fit$cluster,lines =0,color=TRUE)
d<- dev.off()

fit$cluster

#Comments

