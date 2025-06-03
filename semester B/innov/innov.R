install.packages("plm")
library(plm)

mydata <- read.csv("C:\\Developer\\MSC\\semester B\\innov\\TM_Exports_Panel.csv")
attach(mydata)

Y <- cbind(lnsfood)
X <- cbind(lnsG_R10_AppTot2931, YY1, YY2, YY3, YY4, YY5, YY6, YY7, YY8, YY9, YY10,
                                 YY11, YY12, YY13, YY14, YY15, YY16, YY17)

pdata <- pdata.frame(mydata, index=c("state","year"))

summary(X)
summary(Y)

pooling <- plm(Y ~ X, data=pdata, model="pooling")
summary(pooling)

fixed <- plm(Y ~ X, data=pdata, model="within")
summary(fixed)

random <- plm(Y ~ X, data=pdata, model="random")
summary(random)

phtest(random, fixed)
