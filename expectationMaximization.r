#Expectation Maximization
#-------------------------------------------------------

# Prepare Data
mydata <- read.csv("flow_features.csv", sep = ";")
mydata <- na.omit(mydata) # listwise deletion of missing
mydata <- scale(mydata) # standardize variables 

library(mclust)           # load mclust library
model <- Mclust(mydata) # estimate the number of cluster (BIC), initialize (HC) and clusterize (EM)

#plot(model) #all results regarding all features
#plot(model, what = "BIC")   # plot the Bayesian criterion to choose the cluster
pdf("EM.pdf")
plot(model, what="classification", dimens=c(1,2))   # plot the clustering results using colum 1 and 2
d<- dev.off()

#Differently of k-means that plot the best two features using princiapl factor analysis,
#here EM shows all possibilities and leave the decision of what to plot to user.

model$classification #gets the clustering result

