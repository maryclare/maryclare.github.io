rm(list = ls())

t <- seq(2, 14, by = 1)
y <- c(35, 33, 33, 39, 24, 25, 
       18, 20, 23, 13, 14, 20, 18)
plot(t, y, pch = 16)

theta0 <- 1

prod(dpois(y, 50*exp(-theta0*t)))

thetas <- seq(0, 1, length.out = 100)
lls <- rep(NA, length(thetas))
for (i in 1:length(thetas)) {
  lls[i] <- sum(dpois(y, 50*exp(-thetas[i]*t), log = TRUE))
}

ll <- function(theta, y, t) {
  -sum(y*log(50*exp(-theta*t)) - 50*exp(-theta*t)) 
}

opt <- optim(0.2, ll, y = y, t = t)
plot(thetas, lls, type = "l")
abline(v = opt$par, lty = 2, col= "blue")
