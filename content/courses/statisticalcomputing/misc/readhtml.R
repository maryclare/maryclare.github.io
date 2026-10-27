lines <- 
  readLines("https://www.basketball-reference.com/teams/BOS/2024.html#all_per_minute_stats")

grep("Per 36", lines) 
lines[1235]
lines[2410]
lines[2414]
lines[2425]
lines[2464]

obs <- strsplit(lines[2464], 
                split= "data-append-csv")[[1]]
fields <- strsplit(obs[[2]], " data-stat=")[[1]]
vnames <- substr(fields, 2, regexpr(" ", fields) - 2)
vnames[1] <- "id"

vvals <- substr(fields, regexpr(" ", fields), 
                nchar(fields))

data <- matrix("", 
               nrow = length(obs) - 1, 
               ncol = length(vnames))
colnames(data) <- vnames

for (i in 2:length(obs)) {
  fields <- strsplit(obs[[i]], " data-stat=")[[1]]
  vnames <- substr(fields, 2, regexpr(" ", fields) - 2)
  vnames[1] <- "id"
  
  vvals <- substr(fields, regexpr(" ", fields), 
                  nchar(fields))
  vvals[1] <- substr(vvals[1], 3, nchar(vvals[1]) - 1)
  vvals[grepl("csk", vvals)] <- 
    substr(vvals[grepl("csk", vvals)], 7, 
           regexpr(">", vvals[grepl("csk", vvals)]) - 3)
  if (length(vvals[grepl("<a href", vvals)]) > 0) {
  aws <- substr(strsplit(vvals[grepl("<a href", vvals)], "</a")[[1]],
                unlist(lapply(gregexpr(">", strsplit(vvals[grepl("<a href", vvals)], "</a")[[1]]), max)) + 1,
                nchar(strsplit(vvals[grepl("<a href", vvals)], "</a")[[1]]))
  vvals[grepl("<a href", vvals)] <- paste(aws[1:(length(aws) - 1)], collapse = ",")
  } else {
    vvals[vnames == "awards"] <- ""
  }
  vvals[grepl("<td class", vvals)] <- 
    substr(vvals[grepl("<td class", vvals)], 
           regexpr(">", vvals[grepl("<td class", vvals)]) + 1, 
           regexpr("<td class", vvals[grepl("<td class", vvals)]) - 7)
  data[i - 1, 1:(ncol(data) - 1)] <- vvals[1:(ncol(data) - 1)]
  }

