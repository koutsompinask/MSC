#install.packages('MASS')
#install.packages('ISLR')
library(MASS)
# library(ISLR)
# write.csv(Boston,"C:\\Users\\EEV\\OneDrive - chios.aegean.gr\\My Lecture Notes\\Business & Data Analytics ECON\\Lecture notes - An Introduction to Statistical Learning\\eclass files\\Boston.csv", row.names = F)


###########################################################################
#######                Simple linear regression                 ###########
###########################################################################


View(Boston)
names(Boston)
?Boston
str(Boston)
summary(Boston)
Boston$chas = as.factor(Boston$chas)

plot(medv~lstat,Boston)

fit1=lm(medv~lstat,data=Boston)
fit1
summary(fit1)


# We can use the names() function in order to find out what other pieces
# of information are stored in lm.fit. Although we can extract these quantities
# by name?e.g. lm.fit$coefficients?it is safer to use the extractor
# functions like coef() to access them.
names(fit1)
residuals<-as.data.frame(fit1$residuals)
coef(fit1)
hist(fit1$residuals)

# In order to obtain a confidence interval for the coefficient estimates, we can
# use the confint() command
confint(fit1)

# The predict() function can be used to produce confidence intervals and
# prediction intervals for the prediction of medv for a given value of lstat.
predict(fit1,data.frame(lstat=c(5,10,15)),interval="confidence")
predict(fit1,data.frame(lstat=c(5,10,15)),interval="prediction")
# We will now plot medv and lstat along with the least squares regression
# line using the plot() and abline() functions.
plot(Boston$lstat,Boston$medv)
abline(fit1,col="red")

# Below we experiment with some additional settings for
# plotting lines and points.
attach(Boston)
abline (fit1 ,lwd =3)
abline (fit1 ,lwd =3, col ="red ")
plot(lstat ,medv ,col ="red ")
plot(lstat ,medv ,pch =20)
plot(lstat ,medv ,pch ="+")
plot (seq(0,20,0.1) , seq(0,20,0.1), col=2)
plot (1:20 ,1:20, pch =1:20)




###########################################################################
#######                Multiple linear regression               ###########
###########################################################################


# In order to fit a multiple linear regression model using least squares, we
# again use the lm() function. The syntax lm(y~x1+x2+x3) is used to fit a
# model with three predictors, x1, x2, and x3. The summary() function now
# outputs the regression coefficients for all the predictors.
fit2=lm(medv~lstat+age,data=Boston)
summary(fit2)




# The Boston data set contains 13 variables, and so it would be cumbersome
# to have to type all of these in order to perform a regression using all of the
# predictors. Instead, we can use the following short-hand:
fit3=lm(medv~.,Boston)
summary(fit3)



# We can access the individual components of a summary object by name
# (type ?summary.lm to see what is available). Hence summary(lm.fit)$r.sq
# gives us the R2, and summary(lm.fit)$sigma gives us the RSE
summary(fit3)$r.sq
summary(fit3)$sigma



# The vif() function, part of the car package, can be used to compute variance inflation
# factors. Most VIF?s are low to moderate for this data.

#install.packages('car')
library(car)
vif(fit3)




########################### Variable Selection
# Selecting a subset of predictor variables from a larger set 
# (e.g., stepwise selection) is a controversial topic. You can perform stepwise 
# selection (forward, backward, both) using the stepAIC( ) function from the MASS 
# package. stepAIC( ) performs stepwise model selection by exact AIC.
library(MASS)
step <- stepAIC(fit3, direction="backward")
step$anova # display results


# Alternatively, you can perform all-subsets regression using the leaps( ) 
# function from the leaps package. In the following code nbest indicates the 
# number of subsets of each size to report. Here, the ten best models will be 
# reported for each subset size (1 predictor, 2 predictors, etc.).
# All Subsets Regression
# install.packages('leaps')
library(leaps)
attach(Boston)
leaps<-regsubsets(medv~lstat+age+indus+rad+ptratio,data=Boston,nbest=10)
# view results
summary(leaps)
# plot a table of models showing variables in each model.
# models are ordered by the selection statistic.
par(mfrow=c(1,1))
plot(leaps,scale="r2")
# plot statistic by subset size
library(car)
subsets(leaps, statistic="rsq")


# What if we would like to perform a regression using all of the variables but
# one? For example, in the above regression output, age has a high p-value.
# So we may wish to run a regression excluding this predictor. The following
# syntax results in a regression using all predictors except age.
fit4=update(fit3,~.-age-indus,data=Boston)
summary(fit4)


########################### Relative Importance
# The relaimpo package provides measures of relative importance for each of the 
# predictors in the model. See help(calc.relimp) for details on the four measures 
# of relative importance provided.
fit3b=lm(medv~lstat+age+indus+rad+ptratio,Boston)
# Calculate Relative Importance for Each Predictor
library(relaimpo) #install.packages("relaimpo")
calc.relimp(fit4,type=c("lmg","last","first","pratt"),
            rela=TRUE)

# Bootstrap Measures of Relative Importance (1000 samples)
boot <- boot.relimp(fit4, b = 10, type = c("lmg",
                                            "last", "first", "pratt"), rank = TRUE,
                    diff = TRUE, rela = TRUE)
booteval.relimp(boot) # print result
plot(booteval.relimp(boot,sort=TRUE)) # plot result



########################### Cross-Validation Essentials in R
library(tidyverse) #install.packages("tidyverse")
library(caret) #install.packages("caret")



########################### The Validation set Approach
# Split the data into training and test set
set.seed(123)
training.samples <- Boston$medv %>%
  createDataPartition(p = 0.8, list = FALSE)
train.data  <- Boston[training.samples, ]
test.data <- Boston[-training.samples, ]
# Build the model
fit4=update(fit3,~.-age-indus,data=Boston)
summary(fit4)
# Make predictions and compute the R2, RMSE and MAE
predictions <- fit4 %>% predict(test.data)
data.frame( R2 = R2(predictions, test.data$medv),
            RMSE = RMSE(predictions, test.data$medv),
            MAE = MAE(predictions, test.data$medv))



# Leave one out cross validation - LOOCV
# Define training control
train.control <- trainControl(method = "LOOCV")
# Train the model
model <- train(medv ~.-age-indus, data = Boston, method = "lm",
               trControl = train.control)
# Summarize the results
print(model)



# K-fold cross-validation
# Define training control
set.seed(123) 
train.control <- trainControl(method = "cv", number = 10)
# Train the model
model <- train(medv ~.-age-indus, data = Boston, method = "lm",
               trControl = train.control)
# Summarize the results
print(model)


# Repeated K-fold cross-validation
# Define training control
set.seed(123)
train.control <- trainControl(method = "repeatedcv", 
                              number = 10, repeats = 3)
# Train the model
model <- train(medv ~.-age-indus, data = Boston, method = "lm",
               trControl = train.control)
# Summarize the results
print(model)



#################################################
###     Nonlinear terms and Interactions      ###
#################################################
# It is easy to include interaction terms in a linear model using the lm() function.
# The syntax lstat:black tells R to include an interaction term between
# lstat and black. The syntax lstat*age simultaneously includes lstat, age,
# and the interaction term lstat x age as predictors; it is a shorthand for
# lstat+age+lstat:age.
fit5=lm(medv~lstat*age,Boston)
summary(fit5)


# The lm() function can also accommodate non-linear transformations of the
# predictors. For instance, given a predictor X, we can create a predictor X2
# using I(X^2). The function I() is needed since the ^ has a special meaning
# in a formula; wrapping as we do allows the standard usage in R, which is
# to raise X to the power 2. We now perform a regression of medv onto lstat
# and lstat^2
fit6=lm(medv~lstat +I(lstat^2),Boston); summary(fit6)
attach(Boston)
par(mfrow=c(1,1))
plot(medv~lstat)
points(lstat,fitted(fit6),col="red",pch=20)

# We use the anova() function to further
# quantify the extent to which the quadratic fit is superior to the linear fit
anova(fit1 ,fit6)




# In order to create a cubic fit, we can include a predictor of the form
# I(X^3). However, this approach can start to get cumbersome for higherorder
# polynomials. A better approach involves using the poly() function
# to create the polynomial within lm(). For example, the following command
# produces a fifth-order polynomial fit:
attach(Boston)
fit7=lm(medv~poly(lstat ,5)) ;summary (fit7)


#################################################
###         Qualitative predictors            ###
#################################################
# We will now examine the Carseats data, which is part of the ISLR library.
# We will attempt to predict Sales (child car seat sales) in 400 locations
# based on a number of predictors.
fix(Carseats)
names(Carseats)
summary(Carseats)

# The Carseats data includes qualitative predictors such as Shelveloc, an indicator
# of the quality of the shelving location?that is, the space within
# a store in which the car seat is displayed?at each location. The predictor
# Shelveloc takes on three possible values, Bad, Medium, and Good.
# Given a qualitative variable such as Shelveloc, R generates dummy variables
# automatically. Below we fit a multiple regression model that includes some
# interaction terms.
fit1=lm(Sales~.+Income:Advertising+Age:Price,Carseats)
summary(fit1)

# The contrasts() function returns the coding that R uses for the dummy
# variables.
contrasts(Carseats$ShelveLoc)





########################### Writing R functions
regplot=function(x,y){
  fit=lm(y~x)
  plot(x,y)
  abline(fit,col="red")
}
attach(Carseats)
regplot(Price,Sales)

regplot=function(x,y,...){
  fit=lm(y~x)
  plot(x,y,...)
  abline(fit,col="red")
}
regplot(Price,Sales,xlab="Price",ylab="Sales",col="blue",pch=20)




