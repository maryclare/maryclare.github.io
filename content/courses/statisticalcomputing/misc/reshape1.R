rm(list = ls())

library(tidyr)

data <- read.csv("~/Downloads/CESReport.csv",
                 skip = 6, nrow = 170)

months <- c("January", "February", "March",
            "April", "May", "June", "July", 
            "August", "September", "October", 
            "November", "December")
for (month in months) {
  data[, month] <- as.numeric(gsub("\\*", "", gsub(",", "", data[, month])))
}

data <- 
  pivot_longer(data,
    cols = c("January", "February", "March",
             "April", "May", "June", "July", 
             "August", "September", "October", 
             "November", "December"), 
    names_to = "Month", 
    values_to = "Jobs")



