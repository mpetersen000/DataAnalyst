setwd("/Users/michellepetersen/Downloads/eda-course-materials/lesson4")
list.files()

install.packages('lubridate')
install.packages('dplyr')
install.packages('tidyr')

library(lubridate)
library(ggplot2)
library(dplyr)
library(tidyr)

bd <- read.delim('birthdaysExample.csv')

names(bd)

dim(bd)

bd$betterDates <- as.Date(bd$dates,
    format = "%m/%d/%y")

bd$year <- year(bd$betterDates)
bd$month <- month(bd$betterDates)
bd$day <- day(bd$betterDates)

summary(bd)

ggplot(aes(x = month), data = bd) +
  geom_histogram(binwidth = 1, color = 'black', fill = '#099DD9') +
  scale_x_continuous(breaks = seq(1, 12, 1), limits = c(1, 12))
  
ggplot(aes(x = day), data = bd) +
  geom_histogram(binwidth = 1, color = 'black', fill = '#F79420') +
  scale_x_continuous(breaks = seq(1, 31, 1), limits = c(1, 31))

