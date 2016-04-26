#Find the best k value for k-means clustering
#------------------------------------------------------------
mydata <- read.csv("flow_features.csv", sep = ";")
mydata <- na.omit(mydata) # listwise deletion of missing
mydata <- scale(mydata) # standardize variables 

# Determine optimal number of clusters
#convert my data in data frame
data <- unique(as.data.frame(mydata))
wss <- (nrow(data)-1)*sum(apply(data,2,var))
for (i in 2:(nrow(data)-1)) wss[i] <- sum(kmeans(data,centers=i)$withinss)
pdf("wssK.pdf")
plot(1:(nrow(data)-1), wss, type="b", xlab="Number of Clusters",ylab="Within groups sum of squares") 
dev.off()
