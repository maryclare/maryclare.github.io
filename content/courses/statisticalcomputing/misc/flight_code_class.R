library(nycflights13)
library(dplyr)

flights <- nycflights13::flights

View(filter(flights, is.na(dep_delay)))

flights <- mutate(flights, 
                  cancelled = is.na(dep_delay))
flights |>
  group_by(dest) |>
  summarize("nc" = sum(cancelled),
            "pc" = mean(cancelled),
            "n" = n()) |>
  filter(n > 100) |>
  arrange(desc(pc))

flights |>
  group_by(carrier) |>
  summarize("nc" = sum(cancelled),
            "pc" = mean(cancelled),
            "d" = mean(dep_delay, na.rm = TRUE),
            "n" = n()) |>
  arrange(desc(d))

dec <- flights |>
  filter(month == 7) |>
  group_by(day) |>
  summarize(ddelay = mean(dep_delay, na.rm = TRUE))


summarize(group_by(flights, year, month),
          dep_delay = mean(dep_delay, na.rm = TRUE))

aggregate(flights$dep_delay, 
          list("year" = flights$year, "month" = flights$month),
          mean, na.rm = TRUE)


flights <- flights |>
  group_by(month) |>
  mutate(marr_delay = mean(arr_delay, na.rm = TRUE))
flights <- ungroup(flights)
View(flights |>mutate(adj_arr_delay = arr_delay/marr_delay) |>
  arrange(desc(adj_arr_delay)) |>
  select(adj_arr_delay, everything()))
