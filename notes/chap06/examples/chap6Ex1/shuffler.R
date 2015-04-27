#! /usr/bin/env Rscript

calls <- read.csv("out.txt", sep="\t", col.names=c("date", "length"))

calls$date <- as.factor(calls$date)
calls$length <- as.numeric(calls$length)
attach(calls)

# by(length, date, mean)
# tapply(length, date, mean)
# boxplot(length ~ date)

values <- split(length, date)

fileconn <- file("shuffle.txt")
for(i in 1:length(values)){
  writeLines(toString(c(i, values[[i]])), fileconn)
}
close(fileconn)
