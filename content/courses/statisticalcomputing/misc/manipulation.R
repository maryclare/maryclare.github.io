rm(list = ls())

library(nycflights13)  
library(dplyr)

flights <- nycflights13::flights
flights <- as.data.frame(flights)

firstof <- filter(flights, month == 1, day == 1)
firstof <- flights[flights$month == 1 & flights$day == 1, ]

novdec <- filter(flights, month == 11 | month == 12)
novdec <- filter(flights, month %in% c(11, 12))
novdec <- flights[flights$month == 11 | 
                    flights$month == 12, ]
novdec <- flights[flights$month %in% c(11, 12), ]

notdel <- filter(flights, 
                 !(arr_delay > 120 | dep_delay > 120))
notdel <- flights[!is.na(flights$arr_delay) & 
                    !is.na(flights$dep_delay) & 
                    !(flights$arr_delay > 120 | 
                        flights$dep_delay > 120), ]
notdel <- flights[!is.na(flights$arr_delay) & 
                    !is.na(flights$dep_delay) & 
                    flights$arr_delay <= 120 & 
                    flights$dep_delay <= 120, ]

depdel <- filter(flights, arr_delay <= 120, 
                 between(x = dep_delay, left = 80, right = 120))
depdel <- flights[!is.na(flights$arr_delay) & 
                    !is.na(flights$dep_delay) & 
                    flights$arr_delay <= 120 & 
                    flights$dep_delay >= 80 & 
                    flights$dep_delay <= 120, ]

depdelna <- filter(flights, is.na(arr_delay) | arr_delay <= 120, 
                 between(x = dep_delay, left = 80, right = 120))
depdelna <- flights[!is.na(flights$dep_delay) & 
                    flights$arr_delay <= 120 & 
                    flights$dep_delay >= 80 & 
                    flights$dep_delay <= 120, ]

# Find all flights that:
# - Had an arrival delay of two or more hours
sub <- filter(flights, arr_delay >= 120)
# - Flew to Houston (IAH or HOU)
sub <- filter(flights, dest == "HOU" | dest == "IAH")
sub <- filter(flights, dest %in% c("HOU", "IAH"))
# - Were operated by United, American, or Delta
sub <- filter(flights, carrier %in% c("UA", "AA", "DL"))
# - Departed in summer (July, August, and September)
sub <- filter(flights, month >= 7 & month <= 9)
sub <- filter(flights, month >= 7, month <= 9)
sub <- filter(flights, month %in% c(7:9))
sub <- filter(flights, 
              between(x = month, left = 7, right = 9))
# - Arrived more than two hours late, 
#   but didn’t leave late
sub <- filter(flights, arr_delay > 120, 
              dep_time <= sched_dep_time)
# - Were delayed by at least an hour, 
#   but made up over 30 minutes in flight
sub <- filter(flights, 
              dep_delay >= 60, 
              arr_delay <= 30)
# - Departed between midnight and 6am (inclusive)
sub <- filter(flights, between(x = dep_time, 0, 600) | 
                dep_time == 2400)

sorted <- arrange(flights, year, month, day)
sorted <- flights[order(flights$year, flights$month, flights$day), ]

sortedd <- arrange(flights, desc(dep_delay))
sortedd <- flights[order(flights$dep_delay, decreasing = TRUE), ]

View(arrange(flights, desc(dep_delay)))
View(arrange(flights, dep_time))

subvar <- select(flights, year, month, day)
subvar <- flights[, c("year", "month", "day")]

select(flights, year:day)
select(flights, -(year:day))

View(select(flights, time_hour, air_time, everything()))

renamed <- rename(flights, tail_num = tailnum)

renamed <- flights
renamed$tail_num <- flights$tailnum
renamed$tailnum <- NULL

renamed <- flights
names(renamed)[names(renamed) == "tailnum"] <- "tail_num"

flightsnew <- mutate(flights,
                     gain = dep_delay - arr_delay,
                     speed = distance / air_time * 60)

flightsnew <- flights
flightsnew$gain <- flightsnew$dep_delay - flightsnew$arr_delay
flightsnew$speed <- flightsnew$distance/flightsnew$air_time * 60

flightsnew2 <- mutate(flights,
                      gain = dep_delay - arr_delay,
                      hours = air_time / 60,
                      gain_per_hour = gain / hours)

flightsnew2 <- flights
flightsnew2$gain <- flightsnew2$dep_delay - flightsnew2$arr_delay
flightsnew2$hours <- flightsnew2$air_time/60
flightsnew2$gain_per_hour <-  flightsnew2$gain/flightsnew2$hours

flightsnew3 <- transmute(flights,
                         gain = dep_delay - arr_delay,
                         hours = air_time / 60,
                         gain_per_hour = gain / hour)
flightsnew3 <- flights
flightsnew3$gain <- flightsnew3$dep_delay - flightsnew3$arr_delay
flightsnew3$gain_per_hour <-  flightsnew3$gain/flightsnew3$hour
flightsnew3$speed <- flightsnew3$distance/flightsnew3$air_time * 60
flightsnew3 <- flightsnew3[, c("gain", "gain_per_hour", "speed")]

flightsnew4 <- transmute(flights,
                         dep_time,
                         hour = dep_time %/% 100,
                         minute = dep_time %% 100)

flightsnew4 <- transmute(flights, 
                         dep_time, 
                         dep_time_mins_since_midnight = 60 * (dep_time %/% 100) + dep_time %% 100,
                         sched_dep_time, 
                         sched_time_mins_since_midnight = 60 * (sched_dep_time %/% 100) + sched_dep_time %% 100)

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
mean(flights$dep_delay, na.rm = TRUE)

summarise(group_by(flights, year, month), 
          delay = mean(dep_delay, na.rm = TRUE))
aggregate(flights$dep_delay, 
          list("year" = flights$year, "month" = flights$month), 
          mean, na.rm = TRUE)

summarise(group_by(flights, year, month), 
          delay = mean(dep_delay, na.rm = TRUE),
          dist = mean(distance, na.rm = TRUE),
          count = n())

dep_delaymeans <- aggregate(flights$dep_delay, 
                       list("year" = flights$year, "month" = flights$month), 
                       mean, na.rm = TRUE)
colnames(dep_delaymeans)[ncol(dep_delaymeans)] <- "dep_delay"
distmeans <- aggregate(flights$dist, 
                            list("year" = flights$year, "month" = flights$month), 
                            mean, na.rm = TRUE)
colnames(distmeans)[ncol(distmeans)] <- "dist"
means <- merge(distmeans, dep_delaymeans, by = c("month", "year"))

flightsnew5 <- mutate(group_by(flights, year, month), 
                      n_bymonth = n())

npermonth <- aggregate(flights$month, list("month" = flights$month), length)
npermonth[ncol(npermonth)] <- "n_bymonth"
flightsnew5 <- merge(flights, npermonth, by = "month")

summarise(group_by(flights, year, month), 
          delay = mean(dep_delay, na.rm = TRUE),
          count = n())

by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dest != "HNL")
delay

grouped_flights <- group_by(flights, dest)
unfiltered_summary <- summarise(grouped_flights, count = n(), dist = mean(distance, na.rm = TRUE), delay = mean(arr_delay, na.rm = TRUE))
delays <- filter(unfiltered_summary, count > 20, dest != "HNL")

delays <- 
  flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")


