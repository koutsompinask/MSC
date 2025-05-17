# 1. Create some dummy data
set.seed(123)  # for reproducibility
x <- rnorm(100, mean = 50, sd = 10)  # independent variable
y <- 5 + 0.8 * x + rnorm(100, mean = 0, sd = 3)  # dependent variable with some noise

# 2. Fit a linear model
model <- lm(y ~ x)

# 3. View the summary
summary(model)

# 4. Plot the data and regression line
plot(x, y, main = "Dummy Linear Regression", xlab = "x", ylab = "y", pch = 19, col = "blue")
abline(model, col = "red", lwd = 2)