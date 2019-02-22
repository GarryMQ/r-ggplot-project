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

ggsave("fig_output/membrs_item.png", interview_plot, width = 15, height = 10, dpi =72)

### Exercise 7 ##

ggplot(data=interviews_plotting, aes(x=village, y=rooms)) + 
  geom_jitter(aes(color=respondent_wall_type), alpha = 0.5, width = 0.2, height = 0.2, size = 3)

# 3 villages and villages of differnt wall types and rooms = this gives me some sense of what is going on wuth the data

# distribution and how freuenet are some variables - histograms - data points fall into bins - take the continuous rnage and place into bins of different sizes.
# gg plot so that you don't need to do any of the counting 
# looking at household size and how common are households of different sizes

ggplot(interviews_plotting, aes(x=no_membrs)) +
  geom_histogram()

# we know that households will only hold whole numbers, so set the bin widtuh for each possible household size

ggplot(interviews_plotting, aes(x=no_membrs)) +
  geom_histogram(binwidth = 1)

#create border between bins more visible - set the line colour to white

ggplot(interviews_plotting, aes(x=no_membrs)) +
  geom_histogram(binwidth = 1, color="white")

# histogram is improving, but can still improve - colour and more informaiton

#separate data bu village

ggplot(interviews_plotting, aes(x=no_membrs, fill=village)) +
  geom_histogram(binwidth = 1, color="white")

#but this is hard to read - each bin is stacked ontop of one another - so maybe the histogram is not the best plot - so could plot a frequency polygon - that is bars instead of lines

ggplot(interviews_plotting, aes(x=no_membrs, color=village)) +
  geom_freqpoly(binwidth=1)

#so now we can see household size to village, but it is not ideal - one of the problems is that we amay have different levels of observations in differnet villages - is it more common or just more data - so beware of the counts - so instead, the relative frequencey -rather than the total

ggplot(interviews_plotting, aes(x=no_membrs, y=stat(density), color=village)) + geom_freqpoly(binwidth=1)

#now everything is scaled for the amount of data for each plot - which gives you a slightly different picture

#actual deinsity plot - data that is continuous - various nubers some are close together and otehrs are far apart - a smoother plt

ggplot(interviews_plotting, aes(x=no_membrs, fill=village)) +
         geom_density(alpha=0.4)


##Categorical data - after lunch session 
# all you need is one varible

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type)) +
  geom_bar()

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, fill=village)) +
  geom_bar()

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, fill=village)) +
  geom_bar(position = "dodge")

#dodge = side by side bar chart
#split data by wall type and how many respondents

table(interviews_plotting$respondent_wall_type, interviews_plotting$ village)

# question in class about what is the 0 on the chart   

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, fill=village)) +
  geom_bar(position = "dodge") + facet_wrap(~ respondent_wall_type)

ggplot(data = interviews_plotting,
       aes(x = village, fill=village)) +
  geom_bar(position = "dodge") + 
  facet_wrap(~ respondent_wall_type) +
  theme_bw()

# This was the commencement of the code to be able to better chart the data
# We needed to remove the 0 from an earlier plot

counts <- table(interviews_plotting$village, interviews_plotting$respondent_wall_type)
counts

# change colors to change colours

ggplot(data = interviews_plotting,
       aes(x = village, fill=village)) +
  geom_bar(position = "dodge") + 
  facet_wrap(~ respondent_wall_type) +
  scale_fill_brewer() +
  theme_bw()

##### back to where we were ###
ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, fill=village)) +
  geom_bar(position = "dodge")

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, fill=village)) +
  geom_bar(position = "fill")

## y label still says count  so we need to change - now it fits what is being shown

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, fill=village)) +
  geom_bar(position = "fill") +
  ylab("proportion")

#but we have missed the number count
ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, fill=village)) +
  geom_bar(position = "fill") +
  ylab("proportion")+
  stat_count(geom = "text",
             aes(label = stat(count)),
             position = position_fill(vjust = 0.5) , color = "white")

#looked at wall types across villages
# exercise look at in each vilage what is being built
#now we have changed the axis

ggplot(data = interviews_plotting,
       aes(x = village, fill=respondent_wall_type)) +
  geom_bar(position = "fill") +
  ylab("proportion")+
  stat_count(geom = "text",
             aes(label = stat(count)),
             position = position_fill(vjust = 0.5) , color = "white")

## Box plots - splitting up categorical
ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) + 
  geom_boxplot()

# does not really show how mamy buildings are in each
# we need to add a jitter plot on top of the box plot
ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) + 
  geom_boxplot() +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, color = "tomato")

### outlier.shape = NA means that the outlier points are removed
ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, color = "tomato")

#now we can see where each village sits within the box plots - we have added the colour to the geom-jitter srcipt
ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2,
              aes(color = village))


ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = liv_count)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2,
              aes(color = village))


ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = liv_count)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2,
              aes(color = memb_assoc))

# we can split up the box plots, but what is the problem here? jitterer points are not split by member association variable

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = liv_count, fill = memb_assoc,
           color = memb_assoc)) + 
  geom_boxplot(alpha = 0.5) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2)


## now we have separated each of the box plots for each of the categories
ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = liv_count, fill = memb_assoc,
           color = memb_assoc)) + 
  geom_boxplot(alpha = 0.5) +
geom_point(alpha = 0.5, position = position_jitterdodge(jitter.width = 0.1,
                                                        jitter.height = 0.1))

#violin plot - something like a box plot...##
#showing the spread and distributon

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) +
  geom_violin(alpha = 0) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, color = "tomato")

#in the below version, the aesthetic is embedded in the jitter code, so the colours are linked to the villages
ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) +
  geom_violin(alpha = 0) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, aes(color = village))

ggplot(data = interviews_plotting,
       aes(x = village, y = rooms)) +
  geom_violin(alpha = 0) +
  geom_jitter(alpha = 0.5, width = 0.2, height = 0.2, aes(color = respondent_wall_type))


#### Final Session - following afternoon tea #######

#customise plots ##

ggplot(data = interviews_plotting, aes(fill=respondent_wall_type, x = village)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  ylab("Proportion") + xlab("Village")

# Add a title to a plot
ggplot(data = interviews_plotting, aes(fill=respondent_wall_type, x = village)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  ylab("Proportion") + xlab("Village") + ggtitle ("Proportion of Wall Type by Village")

### To combine all label information in one line of code 'labs'
ggplot(data = interviews_plotting, aes(fill=respondent_wall_type, x = village)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  labs(x = "Village", y = "Proportion", title = "Wall type by village")


# plot has label on left - not ideal, so how can it be fixed?
ggplot(data = interviews_plotting, aes(fill=respondent_wall_type, x = village)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  labs(x = "Village", y = "Proportion", title = "Wall type by village") +
  guides(fill=guide_legend(title="Wall Type"))

# it does not change the labels for the wall types. GG plt has scale function and you scale_ and the aesthetic... anything that you can map to data

## now we have changed the names in the legend

ggplot(data = interviews_plotting, aes(fill=respondent_wall_type, x = village)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  labs(x = "Village", y = "Proportion", title = "Wall type by village") +
  guides(fill=guide_legend(title="Wall Type")) +
scale_fill_discrete(labels=c("burnt brick", "cement", "mud daub", "sunbricks"))


##Facet wrap - now 3 for each viallage, but it is messy, so needs improvement
ggplot(data = interviews_plotting, aes(fill=memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  labs(x = "wall type", y = "Proportion") + facet_wrap(~village)


#break up plots over 2 rows
ggplot(data = interviews_plotting, aes(fill=memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  labs(x = "wall type", y = "Proportion") + facet_wrap(~village, nrow = 2) +
  scale_x_discrete(labels=c("burnt brick", "cement", "mud daub", "sunbricks"))

### Rotate labels so that they fit - rotate by 45 degrees - x axis text - we are adjusting the text
ggplot(data = interviews_plotting, aes(fill=memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  labs(x = "wall type", y = "Proportion") + facet_wrap(~village, nrow = 2) +
  scale_x_discrete(labels=c("burnt brick", "cement", "mud daub", "sunbricks")) +
  theme(axis.text.x = element_text(angle=45, hjust = 1))

### background is not grey any more  

ggplot(data = interviews_plotting, aes(fill=memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  labs(x = "wall type", y = "Proportion") + facet_wrap(~village, nrow = 2) +
  scale_x_discrete(labels=c("burnt brick", "cement", "mud daub", "sunbricks"))+
  theme_bw() +
  theme(axis.text.x = element_text(angle=45, hjust = 1))


### many adjustments in this code
# member associaiton , increase in text size, add plot title and centre
ggplot(data = interviews_plotting, aes(fill=memb_assoc, x = respondent_wall_type)) +
  geom_bar(position = "fill")+
  stat_count(geom = "text", aes(label = stat(count)),
             position=position_fill(vjust=0.5), color = "white") +
  labs(x = "wall type", y = "Proportion") + facet_wrap(~village, nrow = 2) +
  scale_x_discrete(labels=c("burnt brick", "cement", "mud daub", "sunbricks"))+
  scale_y_continuous(breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1.0)) +
  theme_bw() +
  guides(fill=guide_legend(title = "Member\nAssociation")) +
  ggtitle("Plot Title") +
  theme(axis.text.x = element_text(angle=45, hjust = 1, size = 12), 
        plot.title = element_text(hjust=0.5))


#### create my theme ###

my_theme <- theme(axis.text.x = element_text(angle=45, hjust = 1, size = 12), 
                  plot.title = element_text(hjust=0.5))

  
