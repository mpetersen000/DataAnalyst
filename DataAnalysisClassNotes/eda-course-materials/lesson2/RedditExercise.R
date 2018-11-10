getwd()
setwd("/Users/michellepetersen/Downloads")
reddit <- read.csv("reddit.csv")

str(reddit)

table(reddit$employment.status)

summary(reddit$employment.status)

summary(reddit)

levels(reddit$age.range)

library(ggplot2)
ggplot(data = reddit, aes(x = age.range)) + geom_bar()

reddit$age.range <- ordered(reddit$age.range, levels = c( "Under 18", "18-24", 
  "25-34", "35-44", "45-54", "55-64", "65 or Above"))

reddit$age.range <- factor(reddit$age.range, levels = c( "Under 18", "18-24", 
  "25-34", "35-44", "45-54", "55-64", "65 or Above"), ordered = T)


install.packages('ggplot2', dependencies = T)
library(ggplot2)
 
install.packages('devtools', dependencies = T)
library(devtools)
install_version("colorspace","1.2-4")