# Minttu Palsola, 12.11.2020
# This data approach student achievement in secondary education of two Portuguese schools. The data attributes include student grades, demographic, social and school related features) and it was collected by using school reports and questionnaires. 
# Source: Paulo Cortez, University of Minho, GuimarÃ£es, Portugal, http://www3.dsi.uminho.pt/pcortez
# Data available at: https://archive.ics.uci.edu/ml/datasets/Student+Performance

# Read both student-mat.csv and student-por.csv into R
math <- read.csv("C:/Users/minttu/R projects/IODS-project/data/student-mat.csv", ";", header = T)
por <- read.csv("C:/Users/minttu/R projects/IODS-project/data/student-por.csv", ";", header = T)

str(por)

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the datasets
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# Explore the structure and dimensions of the joined data. 
colnames(math_por)
str(math_por)
summary(math_por)
glimpse(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2
alc <-mutate(alc, high_use = alc_use > 2)

# Glimpse at the joined and modified data to make sure everything is in order.
glimpse(alc)

# Save the joined and modified data set

write.csv(alc, "C:/Users/minttu/R projects/IODS-project/data/students.csv", row.names = F)

