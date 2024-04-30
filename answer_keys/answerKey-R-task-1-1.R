# Ed Analytics Microcredential Answer Key
# Module 1-1 Foundational Skills

# load the tidyverse and psych packages
# Note you need to install the packages first, if you haven't done so please 
# see this video: https://www.youtube.com/watch?v=8m2X9AVtVCg 
library(tidyverse)
library(psych)

# read in the data
hsb <- read_csv("data/hsb.csv")

# Use describe function to get the summary statistics for the data
describe(hsb)

# Notes about the data: 
# The data set contains 200 observations and 11 variables.
# The variables in the dataset include id, gender, race ses, schtyp, prog, read, 
# write, math, science, socst 
# gender, race, ses, schtype, prog has * beside their names to indicate they are
# not numeric variables (they are factors or categorical variables)
# The average/mean reading score (read) is 59.70
