# Ed Analytics Microcredential Answer Key
# Module 1-2 Nuts and Bolts

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

### NEW CODE BELOW ###

# The names of the variables in the dataset are
# Note: additional information on each variable is provided:
# id = A unique identification number for each student
# gender = student's biological gender coded as "female" or "male"
# race = student's race/ethnicity coded as "african american", "asian", "hispanic", "IDK (I don't know)", "white"
# ses = social economic status coded as "low", "middle", "high"
# schtyp = type of high school coded as "public" or "private"
# prog = type of academic program coded as "academic", "genderal", "vocational"
# read = standardized measure of reading ability 
# write = standardized measure of writing ability 
# math = standardized measure of mathematics ability 
# science = standardized measure of science ability 
# socst = standardized measure of social studies ability 


# Covert variables to factors
hsb$gender <- as.factor(hsb$gender)
hsb$race <- as.factor(hsb$race)
hsb$schtyp <- as.factor(hsb$schtyp)
hsb$prog <- as.factor(hsb$prog)

# set orders for ses levels
hsb$ses <- factor(hsb$ses, levels = c("low", "middle", "high"), ordered = TRUE)

# check internal structure to ensure changes were made
str(hsb)

# rename variables and save to new dataframe
hsbclean <- hsb |> rename(schooltype = schtyp,
                      program = prog,
                      socialst = socst)

