# Ed Analytics Microcredential Answer Key
# Module 2-2 Tidy Data

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

# How much missing data is in the data set?

# We can use the describe function from the psych package to get a summary of
# missing data in the dataset including the amount of missing data for each
# variable
describe(hsbclean)

# We can also check the number of missing values for each variable using
colSums(is.na(hsbclean))

# No data are missing in the dataset except for Race which has 4 values missing

# Check to ensure all variables that should be factors are factors (if not, make them factors)
str(hsbclean)

# Perform the following data cleaning tasks:
# Recode the value ‘academic’ in the program variable to ‘advanced’
table(hsbclean$program)

hsbclean$program <- recode(hsbclean$program, "academic" = "advanced")

table(hsbclean$program)

# Recode all values in race as “IDK” as NA
table(hsbclean$race, useNA = "ifany")

hsbclean$race <- na_if(hsbclean$race, "IDK")

table(hsbclean$race, useNA = "ifany")

# Recode values to NA if values are greater than 100 for the academic scores variables
describe(hsbclean)

hsbclean <- hsbclean |> mutate(read = ifelse(read > 100, NA, read),
                               write = ifelse(write > 100, NA, write),
                               math = ifelse(math > 100, NA, math),
                               science = ifelse(science > 100, NA, science),
                               socialst = ifelse(socialst > 100, NA, socialst))


describe(hsbclean)

# Create new variables
# Create a new variable called ‘finalscore’ that sums the read, write, math, science, socst variables for each student
# 2 options to create the final score variable

# Option 1 using summing across variables
hsbclean$finalscore <- hsbclean$read + hsbclean$write + hsbclean$math + hsbclean$science + hsbclean$socialst

# Option 2 using rowSums
hsbclean$finalscore_option2 <- rowSums(select(hsbclean, read, write, math, science, socialst), na.rm = FALSE)


# Perform basic data transformations
# How many Hispanic females are enrolled in public schools?
# There are 8 Hispanic females enrolled in public schools. 
hsbclean |> filter(race == "hispanic" & gender == "female") |> count(schooltype)

table(hsbclean$race, hsbclean$gender, hsbclean$schooltype)

# How many Hispanic females are enrolled in private schools?
# There are 2 Hispanic females enrolled in private schools. Using the same syntax as above

# What’s the difference in the science scores for Hispanic females enrolled in
# public schools vs. Hispanic females enrolled in private schools?

# The average science score for Hispanic females at private schools is 52.5 and
# 43.5 at public schools. The difference is 9 points.

hsbclean |> 
  filter(race == "hispanic" & gender == "female") |> 
  group_by(schooltype) |>
  summarise(mean_science = mean(science, na.rm = TRUE), n = n())

# Create a new data frame called hsbprivate which contains observations of
# students who attend private schools
hsbprivate <- hsbclean |> filter(schooltype == "private")


# Save your data as a new data frame called hsbtransformed
hsbtransformed <- hsbclean

#### NEW CODE BELOW ####

# Load hsb_future data
hsb_future <- read_csv("data/hsb_future.csv")

# Merge hsbtransformed and hsb_future data
hsb_join <- left_join(hsbtransformed, hsb_future, by = "id") 

# Create a long dataseta new column called test and listing all the different
# test subjects under this column (e.g., read, write, etc.) and creating a new
# column called testscore and listing the associated test score for each of
# these tests.
hsb_long <- pivot_longer(hsb_join, cols = c(read, write, math, science, socialst), 
                         names_to = "test", values_to = "testscore")



  

