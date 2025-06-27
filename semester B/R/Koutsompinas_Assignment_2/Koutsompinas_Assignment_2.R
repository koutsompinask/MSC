# install.packages("tree")
library(tree)
# install.packages("ISLR")
library(ISLR)
# install.packages("randomForest")
library(randomForest) 
# install.packages("caret")
library(caret)

# Exercise 3
#?OJ
#a) training and test set
set.seed(42)
train=sample(1:nrow(OJ), 800)
OJ.train=OJ[train,]
OJ.test=OJ[-train,]

#b) fit tree
tree.OJ=tree(Purchase~.,OJ.train)
summary(tree.OJ)

#c) interpret one terminal node
tree.OJ

#d) plotting
plot(tree.OJ)
text(tree.OJ,pretty=0)

#e) test / train conf matrix

#test
pred.tree.test=predict(tree.OJ,OJ.test,type="class")
cm.tree.test <- table(pred.tree.test,OJ.test$Purchase)
cm.tree.test
#Accuracy in test
(cm.tree.test[1] + cm.tree.test[4])/nrow(OJ.test)

#train
pred.tree.train=predict(tree.OJ,OJ.train,type="class")
cm.tree.train <- table(pred.tree.train,OJ.train$Purchase)
cm.tree.train
#Accuracy in train
(cm.tree.train[1] + cm.tree.train[4])/nrow(OJ.train)

#f) cv.tree
set.seed(42)
cv.OJ=cv.tree(tree.OJ,FUN=prune.misclass)

#g) plotting
plot(cv.OJ$size,cv.OJ$dev,type="b")

#h) lowest dev corresponding size
cv.OJ

#i) prune
prune.OJ=prune.misclass(tree.OJ,best=5)

plot(prune.OJ)
text(prune.OJ,pretty=0)

#j) new cond matrix in train 
pred.prune.train=predict(prune.OJ,OJ.train,type="class")
cm.prune.train <- table(pred.prune.train,OJ.train$Purchase)
cm.prune.train
#Accuracy in train
(cm.prune.train[1] + cm.prune.train[4])/nrow(OJ.train)

#k) new cond matrix in test 
pred.prune.test=predict(prune.OJ,OJ.test,type="class")
cm.prune.test <- table(pred.prune.test,OJ.test$Purchase)
cm.prune.test
#Accuracy in test
(cm.prune.test[1] + cm.prune.test[4])/nrow(OJ.test)

#Exercise 4
#a) splitting
set.seed(42)
train=sample(1:nrow(Carseats), (80/100)*nrow(Carseats))
Carseats.train=Carseats[train,]
Carseats.test=Carseats[-train,]

#b) fitting & ploting
tree.carseats=tree(Sales~.,Carseats.train)
summary(tree.carseats)

plot(tree.carseats)
text(tree.carseats,pretty=0)

pred.train=predict(tree.carseats,Carseats.train)
mse.train <- mean((pred.train - Carseats.train$Sales)^2)
mse.train

pred.test=predict(tree.carseats,Carseats.test)
mse.test <- mean((pred.test - Carseats.test$Sales)^2)
mse.test

#c) cross validation
set.seed(42)
cv.Carseats <- cv.tree(tree.carseats)
cv.Carseats

plot(cv.Carseats$size,cv.Carseats$dev,type="b")

# best k is 21 which is original size, so there is no reason to prune
#prune.carseats=prune.tree(tree.carseats,best=<Best K>)

#d) bagging
set.seed(42)
bag.Carseats=randomForest(Sales~.,data=Carseats.train,mtry=10,importance=TRUE)
bag.Carseats

#train
yhat.bag.train = predict(bag.Carseats, newdata=Carseats.train)
plot(yhat.bag.train , Carseats.train$Sales)
abline(0,1)
cat("MSE in train:", mean((yhat.bag.train - Carseats.train$Sales)^2), "\n")

#test
yhat.bag.test = predict(bag.Carseats, newdata=Carseats.test)
plot(yhat.bag.test, Carseats.test$Sales)
abline(0,1)
cat("MSE in test:", mean((yhat.bag.test- Carseats.test$Sales)^2),"\n")

#show importance
importance(bag.Carseats)
varImpPlot(bag.Carseats)

#show number of trees
plot(bag.Carseats)

#e) random forest

#find optimum mtry
set.seed(42)
cv_folds <- createFolds(Carseats.train$Sales, k = 5, returnTrain = TRUE)

ctrl <- trainControl(method = "cv",
                     number = 5,
                     search = 'grid',
                     savePredictions = "final",
                     index = cv_folds)

start.time <- Sys.time()
rf_model <- train(Sales~.,
                  data = Carseats.train,
                  method = "rf",
                  importance=TRUE,
                  tuneGrid = expand.grid(.mtry=1:10), # we include 10 to compare with bagging results
                  trControl = ctrl)
cat("time taken: ", round(Sys.time()-start.time,2))
rf_model
par(mfrow=c(1,3))
plot(rf_model$results$mtry, rf_model$results$RMSE, type = 'b')
plot(rf_model$results$mtry, rf_model$results$Rsquared, type = 'b')
plot(rf_model$results$mtry, rf_model$results$MAE, type = 'b')
par(mfrow=c(1,1)) # reset

# train rf with mtry=9
rf.Carseats=randomForest(Sales~.,data=Carseats.train,mtry=9,importance=TRUE)
rf.Carseats

#train
yhat.rf.train = predict(rf.Carseats, newdata=Carseats.train)
plot(yhat.rf.train, Carseats.train$Sales)
abline(0,1)
cat("MSE in train:",mean((yhat.rf.train- Carseats.train$Sales)^2),"\n")

#test
yhat.rf.test = predict(bag.Carseats, newdata=Carseats.test)
plot(yhat.rf.test, Carseats.test$Sales)
abline(0,1)
cat("MSE in test:",mean((yhat.rf.test- Carseats.test$Sales)^2),"\n")

#show importance
importance(rf.Carseats)
varImpPlot(rf.Carseats)

