library(ggplot2) #must load the ggplot package first
data(diamonds) 

dim(diamonds)

summary(diamonds)

?diamonds

data(DATA_SET_NAMES)

qplot(x = price, data = diamonds)

dim(diamonds[diamonds$price < 500, ])

dim(diamonds[diamonds$price < 250, ])

dim(diamonds[diamonds$price >= 15000, ])

#There are no diamonds that cost $1500.
#For diamonds that cost less than $2,000, the most common price of a diamond is around 
#$700 with the mode being $605 (binwidth = 1).

ggplot(aes(x = price), data = diamonds) +
  geom_histogram(binwidth = 1) +

# define individual plots
qplot(x = price, data = diamonds, binwidth = 1) +
  scale_x_continuous(limits = c(0, 15000), breaks = seq(0, 15000, 250)) +
  facet_grid(cut ~ .)

by(diamonds$price, diamonds$cut, summary)

qplot(x = price, data = diamonds) + facet_wrap(~cut, scales="free_y")

qplot(x = price, data = diamonds) + facet_wrap(~cut, scales="free_y")

ggplot(aes(x = price/carat), data = diamonds) +
  geom_histogram(binwidth = .01) +
  scale_x_log10() + 
  facet_wrap(~cut, scales="free_y")

ggplot(aes(x = clarity, y = price), 
  data = subset(diamonds)) +
  geom_boxplot(aes(color = price)) +
  coord_cartesian(ylim = c(0, 10000))

by(diamonds$price, diamonds$clarity, summary)

ggplot(aes(x = color, y = price), 
       data = subset(diamonds)) +
  geom_boxplot(aes(color = price)) +
  coord_cartesian(ylim = c(0, 10000))

by(diamonds$price, diamonds$color, summary)

ggplot(aes(x = cut, y = price), 
       data = subset(diamonds)) +
  geom_boxplot(aes(color = price)) +
  coord_cartesian(ylim = c(0, 10000))

by(diamonds$price, diamonds$cut, summary)

IQR(subset(diamonds, price < max(price) & color == "D")$price)

IQR(subset(diamonds, price < max(price) & color == "J")$price)

ggplot(aes(x = color, y = price/carat), data = diamonds) +
  geom_boxplot() +
  coord_cartesian(ylim = c(0, 7500))

ggplot(aes(x = carat),
       data = subset(diamonds)) +
  geom_freqpoly(binwidth=.1) +
  scale_x_continuous(limits = c(0, 3.5), breaks = seq(0, 3.5, .2)) +
  xlab('Carats') +
  ylab('Proportion of diamonds with that weight')



