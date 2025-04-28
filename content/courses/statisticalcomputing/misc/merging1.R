rm(list = ls())

library(DBI)
library(RSQLite)
library(dplyr)

drv <- dbDriver("SQLite")

con <- dbConnect(drv, dbname = "~/Downloads/baseball.db")

db <- dbGetQuery(con,
                 "SELECT m.nameFirst First, m.nameLast Last, 
                 sum(RBI) as RBI_TOTAL
                 FROM batting b
                 INNER JOIN master m ON b.playerID == m.playerID
                 WHERE yearID >= 2005
                 GROUP BY b.playerID
                 HAVING RBI_TOTAL >= 500
                 ORDER BY -RBI_TOTAL")
nrow(db)

master <- dbGetQuery(con, "SELECT * FROM master")
batting <- dbGetQuery(con, "SELECT * FROM batting")

dbDisconnect(con)

db[1, ]
master[master$nameFirst == "Ryan" & 
         master$nameLast == "Howard", "playerID"]
batting[batting$playerID == "howarry01", 
        c("yearID", "RBI")]
sum(batting[batting$playerID == "howarry01", "RBI"])

master <- master %>% 
  group_by(playerID) %>%
  mutate(nid = n())

table(master$nid)

master %>% filter(nid > 1)

master <- master %>% 
  filter(playerID != "") 

table(master$nid)

master <- master %>%
  select(playerID, nameFirst, nameLast)

batting <- batting %>% 
  group_by(playerID, yearID) %>%
  mutate(nid = n())

table(batting$nid)

batting %>% filter(nid > 1)

batting <- batting %>% 
  group_by(playerID, yearID, stint) %>%
  mutate(nid = n())

table(batting$nid)

batting <- batting %>% 
  filter(yearID >= 2005)

batting <- batting %>% 
  group_by(playerID) %>%
  summarize(RBI_TOTAL = sum(RBI, na.rm = TRUE)) %>%
  filter(RBI_TOTAL >= 500) %>% 
  arrange(desc(RBI_TOTAL))

new <- merge(batting, master, by = "playerID")
new

new <- new %>% 
  rename(First = nameFirst, Last = nameLast) %>%
  select(First, Last, RBI_TOTAL) %>%
  arrange(desc(RBI_TOTAL))

all.equal(new, db)

dim(db)
new <- merge(batting, master, by = "playerID",
             all.y = TRUE)
dim(new)
new <- merge(batting, master, by = "playerID",
             all.x = TRUE)
dim(new)

new <- new %>% 
  rename(First = nameFirst, Last = nameLast) %>%
  select(First, Last, RBI_TOTAL) %>%
  arrange(desc(RBI_TOTAL))

all.equal(new, db)

master <- master %>% rename(playerid = playerID)

new <- merge(batting, master, by.x = "playerID",
             by.y = "playerid")
