# Library required
library(ggplot2)
library(data.table)
library(dplyr)
library(DT)
library(tidyverse)
library(moments)

#Reading data#
#Please use data set COVID19.csv for next questions.
#This data set is in a raw format. You have to clean this dataset before any analysis.
#Data set is totally raw downloaded from worldmeters today (March 1st 2021) 
#(https://www.worldometers.info/coronavirus/). 
#Hence, data cleaning and manipulation are required. 
#Please also explain your results with numerical summary as well as graphs, wherever it is applicable. 
#Please check your data also, if it is skewed or normally distributed.
#Results should be based on skewness or normal distribution.

# Reading data set
view(COVID19)
COVID19_raw <- read.csv("COVID19.csv",
                        stringsAsFactors = FALSE,
                        na.strings=c("","NA"))
str(COVID19_raw)

datatable(COVID19_raw)

#Data cleaning
#Question 1. Just keep rows containing country information. Remove rest of the rows. 
#Apart from country, you should not be having any other row.
#Next step will only be done after finishing this question.
#Removing unnecessary rows
COVID19_row_cleaning <- COVID19_raw %>%
  slice(9:229) %>% # function to inculde specific rows
  select(3:20)

datatable(COVID19_row_cleaning)

#Question 2. Calculate missing percentage of each column using a function. 
#If any column has missing data more than 5%, please remove it? Do not try it for rows.
#Removing columns with 5% missing data.
#However, it is important t check if it is also excluding important variables.
# Check is we have NA's in dataset
head(is.na(COVID19_row_cleaning))
# Check total number of NAs in each column
colSums(is.na(COVID19_row_cleaning))

# writing function to create percentage
# First step is to write a pseudo code to calculate percentage
# (sum(is.na(x))/length(x))*100
pMiss <- function(x){
  (sum(is.na(x))/length(x))*100
}

missing_perc_col <- apply(COVID19_row_cleaning, 2, pMiss)
missing_perc_col

#When we use 5% threshold, it was excluding some important variables required for further analysis.
#A threshold of 10% is a better choice.
# Removing certain percentage of columns with missing data
COVID19_NA <- COVID19_row_cleaning %>%
  purrr::discard(~ sum(is.na(.x))/length(.x)* 100 >=10)

datatable(COVID19_NA)

#Question 3. Please give a better column names to your data after cleaning it.
#A better column name is not only for researcher is good, it also helps others to understand better.
#Many times column names containing two or more words seperated by space. It may create issuse while reading. Hence, converting them in better format is required.
corona_data_updated <- COVID19_NA  %>% 
  rename(Country = "Country.Other", 
         Tot_Cases_1M_pop = "Tot.Cases.1M.pop", 
         Deaths_1M_pop = "Deaths.1M.pop", 
         Tests_1M_pop  ="Tests.1M.pop" ,
         X1_Caseevery_X_ppl   = "X1.Caseevery.X.ppl", 
         X1_Deathevery_X_ppl  = "X1.Deathevery.X.ppl",
         X1_Testevery_X_ppl  = "X1.Testevery.X.ppl")

datatable(corona_data_updated)
str(corona_data_updated)

#Removing comma from the dataset, as number contains comma
# As there are many columns with comma, hence a function is a better choice.
comma_removal <- function(x){
  gsub(",", "", x)
}

# APPLYING comma_removal function to all applicable columns in the dataset using apply function.
# Converting it into dataframe
corona_data_character <- as.data.frame(apply(corona_data_updated, MARGIN=2, FUN= comma_removal))
str(corona_data_character)
head(corona_data_character)

#Whenever dataset is showing certain columns as factor and we want to convert those into numeric, never ever directly try to convert it into numerics.
#If we use as.numeric first,then level of factor variables will become your numeric data, not your actuall data.
#Hence, first convert factor columns into character and then convert them into numeric.
columns <- c(2:10, 12:14)
corona_data_character[, columns] <- lapply(columns, function(x) as.numeric(as.character(corona_data_character[[x]])))

str(corona_data_character)
datatable(corona_data_character)

#Data analysis
#Question 4. Create plots for total cases, total death and total recovery. Try to explain it also. There will be more than one figure.
#Columns mentiond in questions are quantitative data.
#Hence, histogram or frequency polygon are better option.
ggplot(corona_data_character, aes(x = TotalCases))+
  geom_histogram(bins = 500)

#Created plot is highly skewed.
#If data is highly skewed, we try do log transformation.
ggplot(corona_data_character, aes(x = TotalCases))+
  scale_x_log10()+
  geom_histogram()

ggplot(corona_data_character, aes(x = TotalDeaths))+
  geom_histogram(bins = 500)

ggplot(corona_data_character, aes(x = TotalDeaths))+
  scale_x_log10()+
  geom_histogram()

ggplot(corona_data_character, aes(x = TotalRecovered))+
  geom_histogram(bins = 500)

ggplot(corona_data_character, aes(x = TotalRecovered))+
  scale_x_log10()+
  geom_histogram()

#Question 5. Create a plot to examine correlation between total cases and total population.
#Is there any correlation between it. Explain it.
ggplot(corona_data_character, aes(x = TotalCases, y = Population))+
  geom_point()

skewness(corona_data_character$TotalCases)

skewness(corona_data_character$Population, na.rm = TRUE)

median(corona_data_character$TotalCases)

IQR(corona_data_character$TotalCases)

median(corona_data_character$Population, na.rm = TRUE)

IQR(corona_data_character$Population, na.rm = TRUE)

#Data is mostly centered at one point. Hence any assumption of correlation is difficult.
#Skewness also suggested that data is highly skewed.
#Hence, to visualize data, transform it.
ggplot(corona_data_character, aes(x = TotalCases, y = Population))+
  scale_x_log10()+
  scale_y_log10()+
  geom_point()

#After log transformation, it seems there is correlation between two variables.

#6. Create a plot to examine correlation between Tot Cases/1M pop and total population. 
#Is there any correlation between it.
ggplot(corona_data_character, aes(x = Tot_Cases_1M_pop, y = Population))+
  geom_point()

skewness(corona_data_character$Tot_Cases_1M_pop, na.rm = TRUE)
## [1] 1.525221
skewness(corona_data_character$Population, na.rm = TRUE)
## [1] 8.845929
median(corona_data_character$Tot_Cases_1M_pop, na.rm = TRUE)
## [1] 11278
IQR(corona_data_character$Tot_Cases_1M_pop, na.rm = TRUE)
## [1] 38337
median(corona_data_character$Population, na.rm = TRUE)
## [1] 6595118
IQR(corona_data_character$Population, na.rm = TRUE)
## [1] 23667577
ggplot(corona_data_character, aes(x = Tot_Cases_1M_pop, y = Population))+
  scale_x_log10()+
  scale_y_log10()+
  geom_point()

#Question 7. Which column do you feel is better for comparison purpose, total cases or TotCases/1M pop. Explain it.
#TotalCases/1M pop is better for comparison purpose. Original numbers in this type of cases can be superficial. Rates will be better to compare countries or continent.
#Question 8. Create a plot to examine correlation between total cases and total death. Explain the figure
ggplot(corona_data_character, aes(x = TotalCases, y = TotalDeaths))+
  geom_point()

ggplot(corona_data_character, aes(x = TotalCases, y = TotalDeaths))+
  scale_x_log10()+
  scale_y_log10()+
  geom_point()

#Question 9. Create a plot to examine correlation between total cases and Deaths/1M pop. 
#Explain the figure. Again, which column is more suitable to compare the result, total death or Death/1Mpop?
ggplot(corona_data_character, aes(x = TotalCases, y = Deaths_1M_pop))+
geom_point()
  
#There is correlation between two variables, as Total cases are increasng, total number of death is also increasing
ggplot(corona_data_character, aes(x = TotalCases, y = Deaths_1M_pop))+
    scale_x_log10()+
    scale_y_log10()+
    geom_point()

#There seems some correlation between two variables, as Total cases are increasng, death per million is also increasing
#Question 10. Compare TotCases/1M pop by continent, and explain your result.
corona_data_character %>% 
  group_by(Continent) %>%
  na.omit(Continent) %>% 
  ggplot(aes(x = Continent, y = Tot_Cases_1M_pop))+
  geom_boxplot()

corona_data_character %>% 
  group_by(Continent) %>%
  na.omit(Continent) %>% 
  summarize(median_Totalcases_M = median(Tot_Cases_1M_pop, na.rm = TRUE))

#Question 11. Compare Deaths/1M pop by continent, and explain your result.
corona_data_character %>% 
  group_by(Continent) %>%
  na.omit(Continent) %>% 
  ggplot(aes(x = Continent, y = Deaths_1M_pop))+
  geom_boxplot()

corona_data_character %>% 
  group_by(Continent) %>%
  na.omit(Continent) %>% 
  summarize(median_Deaths_M = median(Deaths_1M_pop, na.rm = TRUE))

#Question 12. Which country is best among testing the COVID19 and which country is worst? There are two columns total test vs test/M. Choose appropriate column.
summary(corona_data_character$Tests_1M_pop)

corona_data_character %>% 
  filter(Tests_1M_pop == 575)

corona_data_character %>% 
  filter(Tests_1M_pop == 5540672)

#Question 13. Compare your COVID19 test results by continent? There are two columns total test vs test/M. Choose appropriate column.
corona_data_character %>% 
  group_by(Continent) %>% 
  ggplot(aes(x = Continent, y = Tests_1M_pop))+
  geom_boxplot()

corona_data_character %>% 
  group_by(Continent) %>% 
  summarize(median_test_M = median(Tests_1M_pop, na.rm = TRUE))

#To compare it by continent, test/M is better to compare results.
#There is NA in continent section. Hence, we have to remove it.
corona_data_character %>% 
  group_by(Continent) %>%
  na.omit(Continent) %>% 
  ggplot(aes(x = Continent, y = Tests_1M_pop))+
  geom_boxplot()

corona_data_character %>% 
  group_by(Continent) %>% 
  na.omit(Continent) %>% 
  summarize(median_test_M = median(Tests_1M_pop, na.rm = TRUE))

#Results suggest that european continent has better testing
#African continent was worst in testing

#Question 14. Check if Tests/1M pop is skewed or normally distributed.
skewness(corona_data_character$Tests_1M_pop, na.rm = TRUE)

#As skewness is > 3, it means data is highly skewed.
#Question 14. Check if Tests/1M pop is skewed or normally distributed.
data_skew <- corona_data_character %>% 
  group_by(Continent) %>%
  na.omit(Continent) 

skewness(data_skew$Tests_1M_pop)

#END