#! /usr/bin/env Rscript

calls <- read.csv("out.txt", sep="\t", col.names=c("date", "length"))

calls$date <- as.factor(calls$date)
calls$length <- as.numeric(calls$length)
attach(calls)

# by(length, date, mean)
tapply(length, date, mean) # simplifies output

#boxplot(length ~ date)


