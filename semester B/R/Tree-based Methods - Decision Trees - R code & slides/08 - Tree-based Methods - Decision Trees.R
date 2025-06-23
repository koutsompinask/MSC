# Lab: Decision Trees




#######################################################################################################
##############                         Fitting Classification Trees                 ###################
#######################################################################################################
# The tree library is used to construct classification and regression trees.

# install.packages("tree")
library(tree)
# install.packages("ISLR")
library(ISLR)


# We first use classification trees to analyze the Carseats data set. In these
# data, Sales is a continuous variable, and so we begin by recoding it as a
# binary variable. We use the ifelse() function to create a variable, called
# High, which takes on a value of Yes if the Sales variable exceeds 8, and
# takes on a value of No otherwise. Finally, we use the data.frame() function 
# to merge High with the rest of the Carseats data

attach(Carseats)
High=as.factor(ifelse(Sales<=8,"No","Yes"))
Carseats=data.frame(Carseats,High)
# View(Carseats)
str(Carseats)

# We now use the tree() function to fit a classification tree in order to predict
# High using all variables but Sales. The syntax of the tree() function is quite
# similar to that of the lm() function

tree.carseats=tree(High~.-Sales,Carseats)
colnames(Carseats)
# The summary() function lists the variables that are used as internal nodes
# in the tree, the number of terminal nodes, and the (training) error rate.

summary(tree.carseats)
summary(Carseats)

# We use the plot() function to display the tree structure,
# and the text() function to display the node labels. The argument
# pretty=0 instructs R to include the category names for any qualitative predictors,
# rather than simply displaying a letter for each category

plot(tree.carseats)
text(tree.carseats,pretty=0)
tree.carseats



# In order to properly evaluate the performance of a classification tree on
# these data, we must estimate the test error rather than simply computing
# the training error. We split the observations into a training set and a test
# set, build the tree using the training set, and evaluate its performance on
# the test data. The predict() function can be used for this purpose. In the
# case of a classification tree, the argument type="class" instructs R to return
# the actual class prediction. This approach leads to correct predictions for
# around 71.5% of the locations in the test data set
set.seed(2)
train=sample(1:nrow(Carseats), 200)
Carseats.test=Carseats[-train,]
tree.carseats=tree(High~.-Sales,Carseats,subset=train)
summary(tree.carseats)
tree.pred=predict(tree.carseats,Carseats.test,type="class")
High.test=High[-train]
table(tree.pred,High.test)
(104 + 50)/200

plot(tree.carseats)
text(tree.carseats,pretty=0)

# The function cv.tree() performs cross-validation in order to
# determine the optimal level of tree complexity; cost complexity pruning
# is used in order to select a sequence of trees for consideration. We use
# the argument FUN=prune.misclass in order to indicate that we want the
# classification error rate to guide the cross-validation and pruning process,
# rather than the default for the cv.tree() function, which is deviance. The
# cv.tree() function reports the number of terminal nodes of each tree considered
# (size) as well as the corresponding error rate and the value of the
# cost-complexity parameter used
set.seed(7)
cv.carseats=cv.tree(tree.carseats,FUN=prune.misclass)
names(cv.carseats)
cv.carseats
par(mfrow=c(1,2))
plot(cv.carseats$size,cv.carseats$dev,type="b")
plot(cv.carseats$k,cv.carseats$dev,type="b")


# We now apply the prune.misclass() function in order to prune the tree to 
# obtain the nine-node tree.
prune.carseats=prune.misclass(tree.carseats,best=9)
summary(prune.carseats)
par(mfrow=c(1,1))
plot(prune.carseats)
text(prune.carseats,pretty=0)

# How well doehttp://127.0.0.1:20063/graphics/plot_zoom_png?width=1508&height=722s this pruned tree perform on the test data set? Once again,
# we apply the predict() function
tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(97+58)/200


# If we increase the value of best, we obtain a larger pruned tree with lower
# classification accuracy
prune.carseats=prune.misclass(tree.carseats,best=19)
summary(prune.carseats)
plot(prune.carseats)
text(prune.carseats,pretty=0)

tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(102+53)/200


#######################################################################################################
##############                         Fitting Regression Trees                 #######################
#######################################################################################################

# Here we fit a regression tree to the Boston data set. First, we create a
# training set, and fit the tree to the training data.

library(MASS)
#View(Boston)
set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston=tree(medv~.,Boston,subset=train)


# Notice that the output of summary() indicates that only three of the variables
# have been used in constructing the tree. In the context of a regression
# tree, the deviance is simply the sum of squared errors for the tree. We now
# plot the tree.
summary(tree.boston)
plot(tree.boston)
text(tree.boston,pretty=0)



# Now we use the cv.tree() function to see whether pruning the tree will
# improve performance
cv.boston=cv.tree(tree.boston)
plot(cv.boston$size,cv.boston$dev,type='b')


# In this case, the most complex tree is selected by cross-validation. However,
# if we wish to prune the tree, we could do so as follows, using the
# prune.tree() function
prune.boston=prune.tree(tree.boston,best=5)
plot(prune.boston)
text(prune.boston,pretty=0)



yhat=predict(tree.boston,newdata=Boston[-train,])
boston.test=Boston[-train,"medv"]
plot(yhat,boston.test)
abline(0,1)
mean((yhat-boston.test)^2)

