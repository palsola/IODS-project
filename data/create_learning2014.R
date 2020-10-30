# DATA WRANGLING
## Read the full learning2014 data

JYTOPKYS3 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                             sep = "\t", header = TRUE)

## Exploring dimensions and structure of the data: 183 observations, 60 variables

dim(JYTOPKYS3)
str(JYTOPKYS3)

## Combine questions in the learning2014 data

library(dplyr)

## questions related to deep, surface and strategic learning, and attitude towards stats
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

## select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(JYTOPKYS3, one_of(deep_questions))
JYTOPKYS3$deep <- rowMeans(deep_columns)

## select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(JYTOPKYS3, one_of(surface_questions))
JYTOPKYS3$surf <- rowMeans(surface_columns)

## select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(JYTOPKYS3, one_of(strategic_questions))
JYTOPKYS3$stra <- rowMeans(strategic_columns)

## create column 'attitude' by averaging (10 questions in sumvariable)
JYTOPKYS3$attitude <- JYTOPKYS3$Attitude / 10

## create dataset with variables gender, age, attitude, deep, stra, surf and points

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(JYTOPKYS3, one_of(keep_columns))

# lowercase names
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
colnames(learning2014)

# exclude observations where the exam points variable is zero
learning2014 <- filter(learning2014, points > 0)

# set the working directory of your R session the IODS project folder 

setwd("C:/Users/minttu/R projects/IODS-project")
getwd()

# save the analysis dataset to the ‘data’ folder (trying both formats here)

write.csv(learning2014, "C:/Users/minttu/R projects/IODS-project/data/Learning 2014.csv", row.names = F) 
write.table(learning2014, "C:/Users/minttu/R projects/IODS-project/data/Learning 2014.txt") 

# demonstrate that you can also read the data again

learning2014csv <- read.csv("C:/Users/minttu/R projects/IODS-project/data/Learning 2014.csv", header = T)
learning2014 <- read.table("C:/Users/minttu/R projects/IODS-project/data/Learning 2014.txt", header = T)

# make sure that the structure of the data is correct

str(learning2014csv)  
str(learning2014)
head(learning2014csv)
head(learning2014)

