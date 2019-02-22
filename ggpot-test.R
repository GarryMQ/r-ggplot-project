library (tidyverse)

interviews_plotting <- read_csv("data_output/interviews_plotting.csv")

ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items))
#no we have axis and labels, but there is still no plot
# there is no information about how you want to display
# now we want to add gormetiry - the sort of plot you are looking for
#so, add a geometry

ggplot(data = interviews_plotting,
      aes(x = no_membrs, y = number_items)) +
  geom_point()

# now there is the bASIC OF A plot - geom_point is a scatter plot in ggplot
# this has all been achieved in one command line
# commands can be split to make a fle for the data 

# we want to show the nuymber of households at each point
#make each point slightly transparent - the more points, the darker the point

ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
  geom_point(alpha = 0.5)

# we can also a a nudge/jitter to point, so they are not exactly on top of each other -so we use jitter

ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5)

# so now, not exactly, there is a jitter in the x and y - see better where th household lie - see that there is more than one point at each gid point and can see how much data there is = could there be too much jitter - it was not specified
# if you want to presereve higehr quaility adjust jitter

ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.5, width = 0.15, height = 0.15)

# take each point and move it by .15 units either way - it creates clusters of points

# so this is  decent first dradft of the plot
# so to save the plot - in the R script, to write a command for you and allow to specifiy some details - e.g. resolution - ggsave

ggsave("fig_output/membrs_item.png", interview_plot, width = 15, height = 10,
       dpi = 300)

## Exercise 3 ##

ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.4, size = 2.0, width = 0.20, height = 0.2)

####
ggplot(data=interviews_plotting, aes(x=no_membrs, y=number_items)) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, size = 4)

## keep jitter to a lower number, if it is too high, it will distort the display
#different villages - to add some colour - need to map village values to the colour of the plot - same as the way we handled the x and y coordinates)

ggplot(data=interviews_plotting, aes(x=no_membrs, y=number_items, color=village)) + geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, size = 4)

ggplot(data=interviews_plotting, aes(x=no_membrs, y=number_items)) + geom_jitter(aes(color=village), alpha = 0.5, width = 0.2, height = 0.2, size = 4)

## to add a regression line - geo_smooth

ggplot(data=interviews_plotting, aes(x=no_membrs, y=number_items)) + geom_jitter(aes(color=village), alpha = 0.5, width = 0.2, height = 0.2, size = 4) + geom_smooth(method = "lm")

# this is one line for all of the data, rather than a particular village

ggplot(data=interviews_plotting, aes(x=no_membrs, y=number_items, color=village)) + geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, size = 4) + geom_smooth(method = "lm")

#now we have a line for each, beaause we have placed the color village inthe first aes, not the geom_jitter script

ggsave("fig_output/membrs_item.png", interview_plot, width = 15, height = 10,
       dpi = 300)
