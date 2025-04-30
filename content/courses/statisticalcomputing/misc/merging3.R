rm(list = ls())

library(DBI)
library(RSQLite)
library(dplyr)

drv <- dbDriver("SQLite")

con <- dbConnect(drv, dbname = "~/Downloads/baseball.db")

awards <- dbGetQuery(con, "SELECT * FROM AwardsPlayers")
schools <- dbGetQuery(con, "SELECT * FROM SchoolsPlayers")

dbDisconnect(con)

dim(awards)
dim(schools)

both <- merge(awards, schools, by = "playerID",
              all.x = TRUE, all.y = TRUE)

dim(both)

pawards <- 
  awards %>% 
  group_by(playerID) %>%
  summarize(nawards = n()) %>%
  arrange(desc(nawards)) %>%
  filter(nawards > 1)

pschools <- 
  schools %>% 
  group_by(playerID) %>%
  summarize(nschools = n()) %>%
  arrange(desc(nschools)) %>%
  filter(nschools > 1)

comb <- merge(pawards, pschools, by = "playerID")
comb

both[both$playerID %in% comb$playerID, ]
