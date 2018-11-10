library(ggplot2) #must load the ggplot package first
data(diamonds) 

dim(diamonds)

summary(diamonds)

?diamonds

#Scatter plot between price and x
ggplot(aes(x = diamonds$price, y = diamonds$x), data = diamonds) +
  geom_point(alpha = 1/20, position = position_jitter(h = 0)) + 
  ylim(0, 10) 

#Correlation between price and x,y, z
cor.test(diamonds$price, diamonds$x)

cor.test(diamonds$price, diamonds$y)

cor.test(diamonds$price, diamonds$z)

#Simple scatter plot of price and depth
ggplot(aes(x = diamonds$price, y = diamonds$depth), data = diamonds) +
  geom_point()

summary(diamonds$depth)
cor.test(diamonds$price, diamonds$depth)

#Price vs Carat < 99%
price99 <- quantile(diamonds$price, 0.99)
carat99 <- quantile(diamonds$carat, 0.99)

summary(diamonds$carat)
summary(diamonds$price)
summary(carat99)
summary(price99)

ggplot(aes(x = diamonds$carat, y = diamonds$price), 
  data = diamonds) +
  geom_point() +
  xlim(0, carat99) +
  ylim(0, price99)
 
# Price vs. volume (x * y * z)
diamonds$volume <- diamonds$x * diamonds$y * diamonds$z
summary(diamonds$volume)
volume95 <- quantile(diamonds$volume, 0.95)

ggplot(aes(x = price, y = volume), 
       data = diamonds) +
  geom_point(alpha = 1/20, position = position_jitter(h = 0)) +
  ylim(1, volume95) +
  coord_trans(x = "sqrt")

#Correlation on subset with volume greater than 0 and less than or equal to 800
with(subset(diamonds, volume > 0 & volume <= 800), cor.test(price, volume))

# Create a dataframe diamonds by clarity
library(dplyr) #must load the dplyr package first

diamondsByClarity <- diamonds %>%
  group_by(clarity) %>%
  summarise(price_mean = mean(price),
            price_median = median(as.numeric(price)),
            price_min = min(price),
            price_max = max(price),
            n = n()) %>%
  arrange(clarity)

head(diamondsByClarity, 20)

# Your task is to write additional code to create two bar plots
# on one output image using the grid.arrange() function from the package
# gridExtra.
data(diamonds)
library(dplyr)
library(gridExtra)

diamonds_by_clarity <- group_by(diamonds, clarity)
diamonds_mp_by_clarity <- summarise(diamonds_by_clarity, mean_price = mean(price))

summary(diamonds_mp_by_clarity)

diamonds_by_color <- group_by(diamonds, color)
diamonds_mp_by_color <- summarise(diamonds_by_color, mean_price = mean(price))

summary(diamonds_mp_by_color)

p1 <- ggplot(data = diamonds_mp_by_clarity, aes(x = clarity, y = mean_price)) + 
  geom_bar(stat="identity", color="blue", fill="white") 

p2 <- ggplot(data = diamonds_mp_by_color, aes(x = color, y = mean_price)) +
  geom_bar(stat="identity", color="blue", fill="white") 

grid.arrange(p1, p2, ncol = 1)

#We think something odd is going here. These trends seem to go against our intuition.
#Mean price tends to decrease as clarity improves. The same can be said for color.
#We encourage you to look into the mean price across cut.




