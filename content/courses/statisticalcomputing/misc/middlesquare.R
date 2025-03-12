numbers <- 1:99

randseq <- matrix(NA, nrow = length(numbers), ncol = 20)

randseq[, 1] <- numbers
for (c in 2:ncol(randseq)) {
  for (j in 1:nrow(randseq)) {
  randseq[j, c] <- as.numeric(substr(paste(paste(rep("0", 4 - nchar(randseq[j, c - 1]^2)), collapse = "", sep = ""),
                         (randseq[j, c - 1])^2, collapse = "", sep = ""), 2, 3))
                               
  }
}

plot(randseq[1, ], ylim = range(randseq), type = "n", ylab = "Value", 
     xlab = "Iteration")
for (k in 1:nrow(randseq)) {
  lines(randseq[k, ], col = k)
}

for (k in 1:nrow(randseq)) {
  plot(randseq[k, ], ylim = range(randseq), type = "l", main = k, ylab = "Value", 
       xlab = "Iteration")
}
