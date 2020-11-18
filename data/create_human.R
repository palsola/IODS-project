# Read the “Human development” and “Gender inequality” datas into R
# Meta file for these datasets: http://hdr.undp.org/en/content/human-development-index-hdi 
# Technical notes: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf 

library(dplyr)

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

#Look at the meta files and rename the variables with (shorter) descriptive names. (1 point)
colnames(hd)
colnames(gii)

colnames(hd)[1:8] <- c("hdirank", "country", "hdi", "lifexp",
                       "expedu", "meanedu", "gni", "gni-rank")
colnames(gii)[1:10] <- c("giirank", "country", "gii", "mmortal",
                         "abirth", "repinparl", "seduf", "sedum",
                         "laborf", "laborm")

# Mutate the “Gender inequality” data and create two new variables. 
# The first one should be the ratio of Female and Male populations with secondary education in each country
# The second new variable should be the ratio of labour force participation of females and males in each country

gii <- mutate(gii, seduratio = seduf / sedum)
gii <- mutate(gii, laboratio = laborf / laborm)

str(gii)

# Join together the two datasets using the variable Country as the identifier.
# Keep only the countries in both data sets (Hint: inner join). 

human <- inner_join(hd, gii, by=c("country"))

# The joined data should have 195 observations and 19 variables. 
dim(human)


# Call the new joined data "human" and save it in your data folder. 

write.csv(human, "C:/Users/minttu/R projects/IODS-project/data/human.csv", row.names = F)
