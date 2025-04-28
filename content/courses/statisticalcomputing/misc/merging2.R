rm(list = ls())

library(DBI)
library(RSQLite)
library(dplyr)

drv <- dbDriver("SQLite")

con <- dbConnect(drv, dbname = "~/Downloads/baseball.db")

db <- dbGetQuery(con,
                 "SELECT roy.playerID playerID, roy.yearID year, lgID league, schoolID
                 FROM AwardsPlayers roy
                 LEFT JOIN
                 (SELECT * FROM SchoolsPlayers) c
                 ON c.playerID == roy.playerID
                 WHERE awardID LIKE \"Rookie%\"")
nrow(db)

awards <- dbGetQuery(con, "SELECT * FROM AwardsPlayers")
schools <- dbGetQuery(con, "SELECT * FROM SchoolsPlayers")

dbDisconnect(con)

db[1, ]

head(awards)
table(awards$awardID)

awards <- awards %>% 
  filter(grepl("Rookie", awardID)) %>%
  select(lgID, playerID, yearID)

check <- awards %>% 
  group_by(playerID) %>%
  summarize(n = n()) 
table(check$n)

check <- schools %>% 
  group_by(playerID) %>%
  mutate(n = n()) %>% 
  filter(playerID %in% awards$playerID)
table(check$n)

schools <- schools %>% select(playerID, schoolID)

new <- merge(schools, awards, by = "playerID")
dim(new)
dim(db)
new <- merge(schools, awards, by = "playerID", 
             all.x = FALSE, all.y = TRUE)
dim(new)
dim(db)
new <- rename(new, year = yearID, league = lgID)

db[1, ]
new[1, ]

new <- new %>% 
  select(playerID, year, league, schoolID) %>%
  arrange(year, league)
new

db[1:5, ]
new[1:5, ]
all.equal(new, db)
