# installing and importing libs

#install.packages('MASS')
#install.packages('ggplot')
#install.packages('tidyr')
#install.packages('dplyr')
#install.packages('ISLR') 

library(MASS)
library(ggplot2)
library(tidyr)
library(dplyr)
library(ISLR)

################################## EX 1 ########################################
#i) loading and viewing

View(Boston)
?Boston

#ii) pairploting

#pairplot -> not very practical too small graphs
pairs(Boston)

#better plotting 
df_long <- Boston %>%
  pivot_longer(cols = -crim, names_to = "feature", values_to = "value")

ggplot(df_long, aes(x = value, y = crim)) +
  geom_point(alpha = 0.6, color = "#2c3e50") +
  facet_wrap(~ feature, scales = "free_x") +
  labs(x = "Τιμή χαρακτηριστικού", y = "Crim (εγκληματικότητα)", title = "Scatter plots: Χαρακτηριστικά vs Crim") +
  theme_minimal(base_size = 12)

#iii) histograms
par(mfrow = c(1, 3), mar = c(4, 4, 3, 1))  # layout: 1 row, 3 plots

hist(Boston$crim, 
     breaks = 25, 
     col = "#3498db", 
     main = "Κατανομή Εγκληματικότητας (crim)", 
     xlab = "crim", 
     ylab = "Συχνότητα")

hist(Boston$tax, 
     breaks = 25, 
     col = "#2ecc71", 
     main = "Κατανομή Φορολογίας (tax)", 
     xlab = "tax", 
     ylab = "Συχνότητα")

hist(Boston$ptratio, 
     breaks = 25, 
     col = "#e74c3c", 
     main = "Κατανομή Λόγου Μαθητών/Δασκάλων (ptratio)", 
     xlab = "ptratio", 
     ylab = "Συχνότητα")

par(mfrow=c(1,1)) #reset layout

# iv) chas values
table(Boston$chas)

# v) ptration mean
summary(Boston$ptratio)['Mean']

# vi) lowest medv subset
min_medv <- min(Boston$medv)
subset_medv_lowest <- Boston[Boston$medv == min_medv, ]
subset_medv_rest <- Boston[Boston$medv > min_medv, ]
summary(subset_medv_lowest)[,1:13]
summary(subset_medv_rest)[,1:13]

# vii) >8 rm subset
subset_g8rm <- Boston[Boston$rm > 8, ]
subset_le8rm <- Boston[Boston$rm <= 8, ]
summary(subset_g8rm)[,c(1:5, 7:14)] # exclude rm
summary(subset_le8rm)[,c(1:5, 7:14)]

################################## EX 2 ########################################
?Carseats

#i) lm with all the vars
fitAll <- lm(Sales~., Carseats)

#ii) summary
summary(fitAll)

#iii) confint of coefficients
confint(fitAll)

#iv) prediction
str(Carseats)

#get the mean for numeric vars
num_vars <- sapply(Carseats, is.numeric)
xForPred <- as.data.frame(t(colMeans(Carseats[, num_vars])))

#factor are ShelveLoc, Urban, US
xForPred["ShelveLoc"] <- as.factor(names(sort(table(Carseats$ShelveLoc), decreasing = TRUE)[1]))
xForPred["Urban"] <- as.factor(names(sort(table(Carseats$Urban), decreasing = TRUE)[1]))
xForPred["US"] <- as.factor(names(sort(table(Carseats$US), decreasing = TRUE)[1]))

predict(fitAll, xForPred)
predict(fitAll, xForPred, interval = "confidence")
predict(fitAll, xForPred, interval = "prediction")

# v) STEPAIC
step <- stepAIC(fitAll, direction="backward")
summary(step)
