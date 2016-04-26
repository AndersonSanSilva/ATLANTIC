library(randomForest)
library(miscTools)

# Prepare Data
database <- read.csv("database.csv", sep = ";")

#training
cols <- names(database)[1:length(database)-1] #remove the column of classification
system.time(clf <- randomForest(database$class ~., database, ntree=20, nodesize=5, mtry=9))
#  user  system elapsed
# 0.366   0.006   0.372


#testing
data_to_classify <- read.csv("flow_features.csv", sep = ";")
#table(predict(clf, data_to_classify,type="class"))
predict(clf, data_to_classify,type="class") #returns the classification

#visualizing the classification
plot(clf)

