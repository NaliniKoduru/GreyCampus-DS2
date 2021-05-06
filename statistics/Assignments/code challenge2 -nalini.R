
head(iris)
#
### Question 1: Means of Sepal.length of setosa differs from means of versicolor. Create a 
# graph to examine the difference between two groups.
library(tidyverse)
install.packages("rstatix")
library(rstatix)
install.packages("ggpubr")
library(ggpubr)

iris %>% 
  filter(Species != "virginica") %>% 
  ggplot(aes(x=Species, y=Sepal.Length))+
  geom_boxplot()


### Question 2: Please check, if all assumptions are meeting.
# Identify outliers by groups
iris %>%
  filter(Species != "virginica") %>% 
  group_by(Species) %>%
  identify_outliers(Sepal.Length)


# Normality assumptions
# Compute Shapiro wilk test by groups
iris %>%
  filter(Species != "virginica") %>%
  group_by(Species) %>%
  shapiro_test(Sepal.Length)


# Draw a qq plot by group
iris %>% 
  filter(Species != "virginica") %>%
  group_by(Species) %>%
  ggqqplot(x = "Sepal.Length", facet.by = "Species")


# Check the equality of variances
iris %>% 
  filter(Species != "virginica") %>% 
  levene_test(Sepal.Length ~ Species)


### Question 3: Please use appropriate test to see the difference.
iris %>% 
  filter(Species != "virginica") %>%
  t_test(Sepal.Length  ~ Species, var.equal = FALSE) %>% 
  add_significance()


### Question 4: There are 3 species of plants in iris data set. Please use 
# appropriate test to examine the difference in sepal length, 
md <- aov(Sepal.Length ~ Species, data = iris)
summary(md)

### Question 5: Please create appropriate box plot to compare three groups.
iris %>%
  ggplot(aes(x= Species, y= Sepal.Length))+
  geom_boxplot()


### Question 6: If there is any difference in Sepal.length, which groups are different.

# pst hoc test
t <- TukeyHSD(md)
t

#Pairwise t-test
pairwise.t.test(iris$Sepal.Length, iris$Species, p.adjust.method = "BH")


### Question 7: Please check all assumptions required for the test.

## Conditions of one way ANOVA

## 1) Check the homogeneity of variance assumption
plot(md,1)


### leven's test for homogeneity of variance
iris %>%
  levene_test(Sepal.Length ~ Species)


##2) Normality of residuals.
plot(md,2)


# Extract the residuals

# Run Shapiro-Wilk test
aov_residuals <- residuals(object = md)
shapiro.test(x= aov_residuals)
#errors are normally distributed
