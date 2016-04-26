# Classification Tree with rpart
library(rpart)

#training set:
database <- read.csv("database.csv", sep = ";")

# grow tree 
fit <- rpart(database$class ~., method="class", data=database)

# plot tree 
plot(fit)
text(fit, use.n=TRUE, all=TRUE, cex=.8)
