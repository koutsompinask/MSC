# Lab: Bagging, RF & Boosting



#######################################################################################################
##############                         Bagging and Random Forests                 #####################
#######################################################################################################
# Here we apply bagging and random forests to the Boston data, using the
# randomForest package in R. The exact results obtained in this section may
# depend on the version of R and the version of the randomForest package
# installed on your computer. Recall that bagging is simply a special case of
# a random forest with m = p. Therefore, the randomForest() function can
# be used to perform both random forests and bagging. We perform bagging 
# as follows:

library(MASS)
View(Boston)
set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)



library(randomForest) # install.packages("randomForest")
set.seed(1)
bag.boston=randomForest(medv~.,data=Boston,subset=train,mtry=13,importance=TRUE)
bag.boston$mse



# The argument mtry=13 indicates that all 13 predictors should be considered
# for each split of the tree-in other words, that bagging should be done. How
# well does this bagged model perform on the test set?
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
boston.test=Boston[-train,"medv"]
plot(yhat.bag, boston.test)
abline(0,1)
mean((yhat.bag-boston.test)^2)




# The test setMSE associated with the bagged regression tree is 13.16, almost
# half that obtained using an optimally-pruned single tree. We could change
# the number of trees grown by randomForest() using the ntree argument:
bag.boston=randomForest(medv~.,data=Boston,subset=train,mtry=13,ntree=25)
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)




# Growing a random forest proceeds in exactly the same way, except that
# we use a smaller value of the mtry argument. By default, randomForest()
# u???ses p/3 variables when building a random forest of regression trees, and
# p variables when building a random forest of classification trees. Here we
# use mtry = 6.
set.seed(1)
rf.boston=randomForest(medv~.,data=Boston,subset=train,mtry=5,importance=TRUE)
yhat.rf = predict(rf.boston,newdata=Boston[-train,])
mean((yhat.rf-boston.test)^2)
boston.test=Boston[-train,"medv"]
plot(yhat.rf, boston.test)
abline(0,1)



# Using the importance() function, we can view the importance of each variable.
importance(rf.boston)

# Two measures of variable importance are reported. The former is based
# upon the mean decrease of accuracy in predictions on the out of bag samples
# when a given variable is excluded from the model. The latter is a measure
# of the total decrease in node impurity that results from splits over that
# variable, averaged over all trees. In the
# case of regression trees, the node impurity is measured by the training
# RSS, and for classification trees by the deviance. Plots of these importance
# measures can be produced using the varImpPlot() function
par(mfrow=c(1,1))
varImpPlot(rf.boston)
plot(rf.boston)



###########################################################################
# How to tune the rf parameters jointly
###########################################################################
# create predefined folds:
library(caret) 
library(mlbench)

train_data <- Boston[train, ]
test_data <- Boston[-train, ]




set.seed(1234)
cv_folds <- createFolds(train_data$medv, k = 5, returnTrain = TRUE)

ctrl <- trainControl(method = "cv",
                     number = 5,
                     search = 'grid',
                     
                     savePredictions = "final",
                     index = cv_folds
                    ) 


##########    rf    ##################
# create tune control:
tuneGrid <- expand.grid(.mtry = c(3,5,7)
)

# define other parameters to tune. I will use just a few combinations to limit the train time of the example:
ntrees <- c(50,10) #it depends on the number of train observation   
nodesize <- c(1, 5, 10)

params <- expand.grid(ntrees = ntrees,
                      nodesize = nodesize)


# train:
store_maxnode <- vector("list", nrow(params))
start.time <- Sys.time()
for(i in 1:nrow(params)){
  nodesize <- params[i,2]
  ntree <- params[i,1]
  set.seed(65)
  rf_model <- train(medv~.,
                    data = train_data,
                    method = "rf",
                    importance=TRUE,
                    tuneGrid = tuneGrid,
                    trControl = ctrl,
                    ntree = ntree,
                    nodesize = nodesize)
  store_maxnode[[i]] <- rf_model
}



end.time <- Sys.time()
time.taken <- round(end.time - start.time,2)
time.taken


# In order to avoid generic model names - model1, model2 ... we can name the resulting list with the corresponding parameters:
# names(store_maxnode) <- paste("ntrees:", params$ntrees,
#                               "nodesize:", params$nodesize)
names(store_maxnode) <- paste("ntrees:", params$ntrees, "nodesize:", params$nodesize)

#results
store_maxnode$`ntrees: 50 nodesize: 1`$results
trellis.par.set(caretTheme())
plot(store_maxnode$`ntrees: 50 nodesize: 1`)  


# combine results:
results_mtry <- resamples(store_maxnode)
summary(results_mtry)
results_mtry$timings
dotplot(results_mtry)


# To get the best mtry for each model:
lapply(store_maxnode, function(x) x$best)


# or alternatively to get the best average performance for each model
lapply(store_maxnode, function(x) x$results[x$results$RMSE == min(x$results$RMSE),])




###########################################################################
# 5.8 Exploring and Comparing Resampling Distributions
###########################################################################



##############################
# 5.8.1 Within-Model
##############################
trellis.par.set(caretTheme())
densityplot(store_maxnode$`ntrees: 50 nodesize: 1`, pch = "|")
histogram(store_maxnode$`ntrees: 50 nodesize: 1`)



##############################
# 5.8.2 Between-Models
##############################
resamps <- resamples(list(model1 = store_maxnode$`ntrees: 50 nodesize: 1`,
                          model2 = store_maxnode$`ntrees: 50 nodesize: 5`,
                          model3 = store_maxnode$`ntrees: 50 nodesize: 10`))
resamps

summary(resamps)


theme1 <- trellis.par.get()
theme1$plot.symbol$col = rgb(.2, .2, .2, .4)
theme1$plot.symbol$pch = 16
theme1$plot.line$col = rgb(1, 0, 0, .7)
theme1$plot.line$lwd <- 2
trellis.par.set(theme1)
bwplot(resamps, layout = c(3, 1))


trellis.par.set(caretTheme())
dotplot(resamps, metric = "RMSE")








#######################################################################################################
##############                         Boosting                 #######################################
#######################################################################################################


# Here we use the gbm package, and within it the gbm() function, to fit boosted
# regression trees to the Boston data set. We run gbm() with the option
# distribution="gaussian" since this is a regression problem; if it were a binary
# classification problem, we would use distribution="bernoulli". The
# argument n.trees=5000 indicates that we want 5000 trees, and the option
# interaction.depth=4 limits the depth of each tree.
library(gbm) # install.packages("gbm")
set.seed(1)
boost.boston=gbm(medv~.,data=Boston[train,],distribution="gaussian",n.trees=5000,interaction.depth=4)



# The summary() function produces a relative influence plot and also outputs
# the relative influence statistics.
summary(boost.boston)




# We see that lstat and rm are by far the most important variables. We can
# also produce partial dependence plots for these two variables. These plots
# illustrate the marginal effect of the selected variables on the response after
# integrating out the other variables. In this case, as we might expect, median
# house prices are increasing with rm and decreasing with lstat.
par(mfrow=c(1,2))
plot(boost.boston,i="rm")
plot(boost.boston,i="lstat")
plot(boost.boston,i="zn")




# We now use the boosted model to predict medv on the test set:
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=5000)
mean((yhat.boost-boston.test)^2)




# The test MSE obtained is 11.8; similar to the test MSE for random forests
# and superior to that for bagging. If we want to, we can perform boosting
# with a different value of the shrinkage parameter ??. The default
# value is 0.001, but this is easily modified. Here we take ?? = 0.2.
boost.boston=gbm(medv~.,data=Boston[train,],distribution="gaussian",n.trees=5000,interaction.depth=4,shrinkage=0.2,verbose=F)
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=5000)
mean((yhat.boost-boston.test)^2)

