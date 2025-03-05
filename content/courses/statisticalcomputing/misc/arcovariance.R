# Creating an AR-1 Covariance Matrix with AR Parameter 0.5

n <- 100

start <- Sys.time()
C <- matrix(NA, nrow = n, ncol = n)
for (i in 1:nrow(C)) {
  for (j in 1:ncol(C)) {
    C[i, j] <- 0.5^abs(i - j)
  }
}
end <- Sys.time()
end - start

start <- Sys.time()
C <- matrix(0, nrow = n, ncol = n)
for (i in 2:nrow(C)) {
  for (j in 1:(i - 1)) {
    C[i, j] <- 0.5^abs(i - j)
  }
}
C <- C + t(C) + diag(n)
end <- Sys.time()
end - start

start <- Sys.time()
C <- matrix(0, nrow = n, ncol = n)
for (i in 1:nrow(C)) {
  for (j in 1:i) {
    C[i, j] <- 0.5^abs(i - j)
  }
}
C <- C + t(C) - diag(n)
end <- Sys.time()
end - start

start <- Sys.time()
C <- diag(n)
for (i in 1:nrow(C)) {
  for (j in 1:(i - 1)) {
    C[i, j] <- 0.5^abs(i - j)
  }
}
C <- C + t(C) - diag(n)
end <- Sys.time()
end - start

start <- Sys.time()
C <- apply(matrix(1:n, nrow = n, ncol = 1), 1, function(x) {0.5^abs(x - 1:n)})
end <- Sys.time()
end - start

start <- Sys.time()
C <- apply(matrix(1:n, nrow = 1, ncol = n), 2, function(x) {0.5^abs(x - 1:n)})
end <- Sys.time()
end - start

start <- Sys.time()
C <- 0.5^abs(rep(1, n)%*%t(1:n) - (1:n)%*%t(rep(1, n)))
end <- Sys.time()
end - start

start <- Sys.time()
ones <- rep(1, n)
a <- 1:n
C <- 0.5^abs(tcrossprod(ones, a) - tcrossprod(a, ones))
end <- Sys.time()
end - start
