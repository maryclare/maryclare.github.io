rm(list = ls())

x <- seq(1, 9, by = 1)
y <- x + c(2, 2, -3, 0, -1, -2, 2, 3, 1)

z <- NA
w <- NA

for (i in 1:9) {
#   z[i] <- (y[i] + y[i - 1])/2
  z[i] <- mean(y[i:max(i - 1, 1)])
  w[i] <- mean(y[i:max(i - 2, 1)])
}

plot(x, y, pch = 16, col = "black")
abline(a = 0, b = 1, lty = 3)
points(x, z, pch = 16, col = "blue")
points(x, w, pch = 16, col = "red")
