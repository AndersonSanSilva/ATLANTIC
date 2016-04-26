#Naive Bayes Classifier
#--------------------------------------------------------
# Prepare Data
mydata <- read.csv("database.csv", sep = ";")
mydata <- na.omit(mydata) # listwise deletion of missing
#mydata <- scale(mydata) # standardize variables 

#classification
library(e1071)
classifier<-naiveBayes(mydata[,1:3], mydata[,4]) #first param: data examples; second param: classes
#table(predict(classifier, mydata[,-4]), mydata[,4], dnn=list('predicted','actual')) #prints the confusion matrix

#mydata[,-4] remove the colum that classifyes, the colum 4
#mydata[4] uses this colum to check the classification
#para ser generico, ao inves de 4 basta usar nrow(x) e colocar sempre a classe
#como ultima coluna

#And how predict flows??? Put them in a file csv without it class
#and run this code (in this case i remove the 4th colum to use the same file used as training set)
data_to_classify <- read.csv("flow_features.csv", sep = ";")
result <- predict(classifier, data_to_classify) #classify new data usinf the classifier generated
result
