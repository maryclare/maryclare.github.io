rm(list = ls())

library(DBI)
library(RSQLite)
library(dplyr)
library(tidyr)

drv <- dbDriver("SQLite")

con <- dbConnect(drv, dbname = "~/Downloads/baseball.db")

awards <- dbGetQuery(con, "SELECT * FROM AwardsPlayers")

dbDisconnect(con)

awards$awarded <- 1

uawards <- unique(awards$awardID)

awards <- 
  pivot_wider(awards, 
              id_cols = c("playerID", "yearID", "lgID", "tie", "notes"), 
              names_from = awardID,
              values_from = awarded)

for (award in uawards) {
  awards[is.na(awards[, award]), award] <- 0
}
