# install.packages("tree")
library(tree)
# install.packages("ISLR")
library(ISLR)

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
pred.test=predict(tree.OJ,OJ.test,type="class")
cm.test <- table(pred.test,OJ.test$Purchase)
cm.test
#Accuracy in test
(cm.test[1] + cm.test[4])/nrow(OJ.test)

#train
pred.train=predict(tree.OJ,OJ.train,type="class")
cm.train <- table(pred.train,OJ.train$Purchase)
cm.train
#Accuracy in train
(cm.train[1] + cm.train[4])/nrow(OJ.train)

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
pred.train.5=predict(prune.OJ,OJ.train,type="class")
cm.train.5 <- table(pred.train.5,OJ.train$Purchase)
cm.train.5
#Accuracy in train
(cm.train.5[1] + cm.train.5[4])/nrow(OJ.train)

#k) new cond matrix in test 
pred.test.5=predict(prune.OJ,OJ.test,type="class")
cm.test.5 <- table(pred.test.5,OJ.test$Purchase)
cm.test.5
#Accuracy in test
(cm.test.5[1] + cm.test.5[4])/nrow(OJ.test)

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
