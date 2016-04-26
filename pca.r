#-------------------------------------------------------------------------------------------
#Although most of this has already been stated in comments, I'm turning this into an answer.
#The components of a primary component analysis are linear combinations of your original variables.
#So there is no one-to-one mapping between components and genes.
#Excepting special cases, every component describes multiple genes.
#Some of them with a positive and some with a negative contribution.
#Some with large and some with small absolute values.
#You can see these contributions from the loading matrix: enter loadings(res) and you will see the composition of each component.
#You can find the gene with maximum absolute value in the column for a specific component in the loadings matrix.
#That way you could identify something like a âprimary contributorâ to each component.
#But unless that contribution was very close to one, treating the component as a synonym for the gene would be misleading at best.
#If you want your analysis in terms of individual genes, PCA is not the right tool.
#If you are sure you want the âmain contributorâ despite the above warnings, the following code does that:
#l <- loadings(res)
#rownames(l)[apply(l, 2, function(x) which.max(abs(x)))]
#-------------------------------------------------------------------------------------------
x <- commandArgs(TRUE)

if (x == "a"){
  #mydata <- read.csv("csv_files/train_file.csv", sep = ",")
  mydata <- read.csv("csv_files/train_fileA.csv", sep = ",")
}
if (x == "b"){
  #mydata <- read.csv("csv_files/train_file2.csv", sep = ",")
  mydata <- read.csv("csv_files/train_fileB.csv", sep = ",")
}
if (x == "c"){
  #mydata <- read.csv("csv_files/train_file3.csv", sep = ",")
  mydata <- read.csv("csv_files/train_fileC.csv", sep = ",")
}
if (x == "d"){
  mydata <- read.csv("csv_files/train_file4.csv", sep = ",")
}
mydata <- mydata[,-34]
# Pricipal Components Analysis
# entering raw data and extracting PCs
# from the correlation matrix

#fit <- princomp(mydata)
#summary(fit) # print variance accounted for
#loadings(fit) # pc loadings
#plot(fit,type="lines") # scree plot
#fit$scores # the principal components
#biplot(fit)

#Esse funciona perfeitamente 
# Varimax Rotated Principal Components
# retaining 5 components
library(psych)
fit <- principal(mydata, nfactors=33, rotate="varimax")
fit # print results
