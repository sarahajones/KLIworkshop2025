###  Getting Started with R and Quarto #########################################
### 1 - Following the convention for activating and installing packages ########

# Option 1 - high friction, low editability/collaboration ease
#Install and library each package across the script one by one, e.g.:
#tidyverse and ggpubr


# Option 2: An alternative and highly portable approach -
# At the start of your script list and load in all pacakges
# Create a list of the required packages e.g.:
list.of.packages <- c(
  #insert packages needed here
  
  #ONLY INCLUDE WHAT YOU NEED AND ALWAYS COMMENT WHY IT IS BEING USED
)


new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])] #check for any uninstalled packages
if(length(new.packages)) install.packages(new.packages) #install missing packages, if any (requires internet access)
lapply(list.of.packages, require, character.only = TRUE) #library all required packages

# tidy your environment
rm()


### 2 - Importing, and exporting data portably #################################
# Set the working directory to help source the files you need from your computer

# Option 1 - high friction and low reproducibility
# Manual setting of the working directory using the menu settings

#Option 2 - high friction and risk of error in collaboration
# Set working directory with a manual file path to a specific folder in you computer
setwd("YOUR PATH GOES HERE")

#Option 3 - low friction, high portability easy collaboration
# Set the working directory to the folder that this R file is in:
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Now it is time to load in data from the repository files
# we are working with the clinical_intervention_data, it's a csv file
# try read.csv()

#Let's talk about why we might want to load from and save to and rds instead... 





### 3 - Data exploration cleaning and processing ######################
# Let's look at our data: 

#manual viewing 

#summary

#plotting

# All good options! 



# Notice that we have a bunch of columns being read as characters
# These should be factors - let's clean them up 

clean_data <- data %>% #hold the original raw data out in case we need it later!
  mutate( # let's clean up some of those columns! 
   
    #cLEAN UP VARIABLES HERE 
    
    
  ) #overwrite these columns directly 

# What about any data transformations? 
# e.g. variables is often skewed in data sets - LOOK AT TRAVELTIME
hist() #view your data, histograms are a great quick view of data spread

# Transformed versions of variables:
# these should be new columns - not overwrite originals, they contain new information
clean_data <- clean_data %>%
  mutate(
   #LOG YOUR DATA COL HERE!
  )

#check that it has worked! 


# does that look better?

### 4 - Run some analyses and plot ############################################
#Now let's do something with it!
# run a quick cor on this tavel time and TransportDiff 
# (a dummy analysis for the sake of completeness)
cor() #find the correlation coef

#have a look at the data again, with some contextulization of geographical region! 
travel_plot <- ggplot(data = clean_data, mapping = aes(x=log_travel_time, y=TransportDiff)) + 
  geom_point(aes(color = Borough)) + 
  theme_bw() + # This is line gives a basic black and white theme to the background.
  ggtitle("") + #Write out the title - clear for you and others
  xlab("") + #Label the x axis, be specific
  ylab(""); travel_plot # Label the y axis, be specific 

# save the plot as a png
ggsave("travel.png", travel_plot) # default to last plot, but can specify the plot directly


