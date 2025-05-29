# installing and importing libs

#install.packages('MASS')
#install.packages('ggplot')
#install.packages('tidyr')
#install.packages('dplyr')
library(MASS)
library(ggplot2)
library(tidyr)
library(dplyr)

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

par(mfrow = c(1, 3), mar = c(4, 4, 3, 1))  # layout: 1 row, 3 plots

#iii histograms
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

# iv
table(Boston$chas)

summary(Boston$ptratio)['Mean']


