#library(NeuralNetTools)

# create model
#library(nnet)
#library(neuralnet)
#data <- read.csv("database.csv", sep = ";")
#output <- rep(0, length(data[,1]))
#output[5] <- 1
#data <- cbind(output,data)
#fmla <- as.formula(data[-length(data)])

#mod <- neuralnet(as.formula(data[-length(data)]), data,  hidden = c(6, 12, 8), rep = 10, err.fct = 'ce', linear.output = FALSE)
#mod <- neuralnet(fmla, data,  hidden = 10, rep = 10, err.fct = 'ce', linear.output = FALSE)
#mod <- nnet(fmla, data,  size = 3)

# plotnet
#par(mar = numeric(4), family = 'serif')
#plotnet(mod, alpha = 0.6)


#how to classify with it?
#data_to_classify <- read.csv("flow_features.csv", sep = ";")
#result <- predict(mod, data_to_classify) #classify new data usinf the classifier generated
#result


#new version:
#learn step
library(nnet)
database <- read.csv("database.csv", sep = ";")
#output <- class.ind(database$class)[,1] #transforms classes in numbers, ie, M and B should turns 0 and 1
#database <- cbind(output, database[-length(database)]) #inserts the output in the beginning of the database
mod <- nnet( database$class ~., database,  size = 0)

#plot the information
par(mar = numeric(4), family = 'serif')
plotnet(mod, alpha = 0.6)


#classify
data_to_classify <- read.csv("flow_features.csv", sep = ";")
predict(mod, data_to_classify, type="class")


