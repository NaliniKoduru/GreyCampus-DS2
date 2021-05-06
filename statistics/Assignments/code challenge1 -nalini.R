mtcars
head(mtcars)
boxplot(cyl ~ mpg, data=mtcars, frame=FALSE)

library(datasets)
hist(mtcars$mpg)

sapply(airquality, function(x) sum(is.na(x)))


print(airquality$Month)
airquality$Month <- as.factor(airquality$Month)
class(airquality$Month)

library(gapminder)
library(dplyr)
library(ggplot2)
View(gapminder %>% 
       group_by(continent) %>%
       summarize(mean(lifeExp),
                 median(lifeExp)))
