rm(list = ls())

x <- seq(1, 9, by = 1)
y <- x + c(2, 2, -3, 0, -1, -2, 2, 3, 1)

plot(x, y)

w <- z <- rep(NA, length(x))

for (i in 1:length(x)) {
  z[i] <- mean(y[max(1, i - 1):min(length(x), i + 1)])
  w[i] <- mean(y[max(1, i - 5):min(length(x), i + 5)])
}

plot(x, y)
points(x, z, col = "blue", pch = 16)
points(x, w, col = "red", pch = 16)
abline(a = 0, b = 1, lty = 2)
