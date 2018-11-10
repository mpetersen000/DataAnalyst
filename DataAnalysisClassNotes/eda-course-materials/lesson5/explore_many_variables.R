library(ggplot2) #must load the ggplot package first
data(diamonds) 

dim(diamonds)
summary(diamonds)
?diamonds

# Create a histogram of diamond prices.
# Facet the histogram by diamond color
# and use cut to color the histogram bars.
p <- ggplot(aes(x = log(price), fill = cut), data = diamonds) +
  geom_histogram() + 
  facet_wrap( ~ diamonds$color)

p + scale_fill_brewer(type = 'qual')

# Create a scatterplot of diamond price vs.
# table and color the points by the cut of
# the diamond.
p2 = ggplot(aes(x = table, y = price), data = diamonds) +
  geom_point( binwidth = 2, aes(color = cut)) +
  scale_x_continuous(breaks = seq(50, 80, 2), limits = c(50, 80)) 

p2 + scale_fill_brewer(type = 'qual')

# Create a scatterplot of diamond price vs.
# volume (x * y * z) and color the points by
# the clarity of diamonds. Use scale on the y-axis
# to take the log10 of price. You should also
# omit the top 1% of diamond volumes from the plot.

# Note: Volume is a very rough approximation of
# a diamond's actual volume.
diamonds$volume <- (diamonds$x * diamonds$y * diamonds$z)
summary(diamonds$volume)

#Volume  < 99%
volume99 <- quantile(diamonds$volume, 0.99)

p3 = ggplot(aes(x = volume, y = price), data = diamonds) +
  geom_point(aes(color = clarity)) +
  scale_y_log10() +
  scale_x_continuous(limits = c(1, quantile(diamonds$volume, 0.99))) 

p3 + scale_fill_brewer(type = 'div', name="Clarity")

# Create a line graph of the median proportion of
# friendships initiated ('prop_initiated') vs.
# tenure and color the line segment by
# year_joined.bucket.

# Recall, we created year_joined.bucket in Lesson 5
# by first creating year_joined from the variable tenure.
# Then, we used the cut function on year_joined to create
# four bins or cohorts of users.

# (2004, 2009]
# (2009, 2011]
# (2011, 2012]
# (2012, 2014]

setwd("/Users/michellepetersen/Downloads/eda-course-materials/lesson5")
pf = read.delim('pseudo_facebook.tsv')
summary(pf)

pf$year_joined <- floor(2014 - pf$tenure/365)
summary(pf$year_joined)

pf$year_joined.bucket <- cut(pf$year_joined, 
                             c(2004, 2009, 2011, 2012, 2014))

table(pf$year_joined.bucket, useNA = 'ifany')
with(subset(pf, tenure > 0), summary(friendships_initiated / tenure))
with(subset(pf, tenure > 0), summary(friendships_initiated))

ggplot(aes(x = tenure, y = friendships_initiated / tenure),
       data = subset(pf, !is.na(year_joined.bucket) & (tenure > 0))) +
  geom_line(aes(color = year_joined.bucket), 
            stat = 'summary', fun.y = median) + 
  scale_y_continuous(breaks = seq(0, 0.75, 0.25), limits = c(0, 0.75)) 

# Smooth the last plot you created of
# of prop_initiated vs tenure colored by
# year_joined.bucket. You can bin together ranges
# of tenure or add a smoother to the plot.

ggplot(aes(x = tenure, y = friendships_initiated / tenure),
       data = subset(pf, !is.na(year_joined.bucket) & (tenure > 0))) +
  geom_smooth(aes(color = year_joined.bucket)) +
  scale_y_continuous(breaks = seq(0, 0.75, 0.25), limits = c(0, 0.75)) 

# Create a scatter plot of the price/carat ratio
# of diamonds. The variable x should be
# assigned to cut. The points should be colored
# by diamond color, and the plot should be
# faceted by clarity.

p4 <- ggplot(aes(x = cut, y = price / carat), data = diamonds) +
  geom_jitter(alpha = 1/2, aes(color = diamonds$color)) + 
  facet_wrap( ~ diamonds$clarity)

p4 + scale_fill_brewer(type = 'div')
