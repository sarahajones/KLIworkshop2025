###  Getting Started with R and Quarto #########################################
### 1 - Following the convention for activating and installing packages ########

# Option 1 - high friction, low editability/collaboration ease
#Install and library each package across the script one by one, e.g.:
install.packages("tidyverse")
library(tidyverse)

# Option 2: An alternative and highly portable approach -
# At the start of your script list and load in all pacakges
# Create a list of the required packages e.g.:
list.of.packages <- c(
  #for data wrangling/cleaning
  "tidyverse", #handles data wrangling
  "ggpubr" #for correlation work
)
#ONLY INCLUDE WHAT YOU NEED AND ALWAYS COMMENT WHY IT IS BEING USED

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])] #check for any uninstalled packages
if(length(new.packages)) install.packages(new.packages) #install missing packages, if any (requires internet access)
lapply(list.of.packages, require, character.only = TRUE) #library all required packages
rm(list.of.packages, new.packages)

### 2 - Importing, and exporting data portably #################################
# Set the working directory to help source the files you need from your computer

# Option 1 - high friction and low reproducibility
# Manual setting of the working directory using the menu settings

#Option 2 - high friction and risk of error in collaboration
# Set working directory with a manual file path to a specific folder in you computer
setwd("C:/Users/sa4422/OneDrive - Columbia University Irving Medical Center/Desktop/Teaching/AU_2025s")

#Option 3 - low friction, high portability easy collaboration
# Set the working directory to the folder that this R file is in:
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Now it is time to load in data from the repository files
data <- read.csv("clinical_intervention_data.csv")

#Let;s talk about why we might want to load from and save to and rds instead... 
data$Attend <- as.factor(data$Attend) #change values in column to a factor
write_csv(data, "clinical_intervention_data.csv" ) #save a version as a csv
write_rds(data,"clinical_intervention_data.rds") # save a version as an rds file 

data <- read.csv("clinical_intervention_data.csv") # this does not have the factoring
data <- read_rds("clinical_intervention_data.rds") # this holds the factor levels


### 3 - Data exploration cleaning and processing ######################
# Let's look at our data: 

summary(data) # a bunch of columns are being read as unhelpful data types

clean_data <- data %>% #hold the original raw data out in case we need it later!
  mutate( # let's clean up some of those columns! 
    Intervention = as.factor(Intervention),
    AttendCat = as.factor(AttendCat),
    Arrival = as.factor(Arrival),
    Insurance = as.factor(Insurance),
    BSexCat = as.factor(BSexCat)
  ) #overwrite these columns directly 

# What about any data transformations? 
# e.g. variables is often skewed in data sets
hist(clean_data$TravelTime) #view your data

# Transformed versions of variables:
# these should be new columns - not overwrite originals, they contain new information
clean_data <- clean_data %>%
  mutate(
    log_travel_time = log(TravelTime) #log transform your data 
  )

hist(clean_data$log_travel_time) #check that it has worked! 
# that looks better! 

### 4 - Run some analyses and plot ############################################
#Now let's do something with it!
cor(clean_data$log_travel_time, clean_data$TransportDiff) #find the correlation coef

#have a look at the data again, with some contextulization of geographical region! 
travel_plot <- ggplot(data = clean_data, mapping = aes(x=log_travel_time, y=TransportDiff)) + 
  geom_point(aes(color = Borough)) + 
  theme_bw() + # This is line gives a basic black and white theme to the background.
  ggtitle("Travel time and travel difficulty") + #Write out the title - clear for you and others
  xlab("Log transformed Travel Time") + #Label the x axis, be specific
  ylab("Sel-reported Transport Difficulty"); travel_plot # Label the y axis, be specific 
# save the plot as a png
ggsave("travel.png", travel_plot) # default to last plot, but can specify


