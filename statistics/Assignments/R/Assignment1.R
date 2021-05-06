##vector is a basic data structure in R. It contains element of the same data type(can be integer, logical, double, character or complex).
#Matrix is a two dimensional data structure in R programming, contains the elements of the same datatype like vector.
#The main difference between vector and matrix is dimension attribute, is itself an integer vector of length 2 (nrow, ncol)
#Matrix is similar to vector but additionally contains the dimension attribute.
#Matrices can also be created directly from vectors by adding a dimension attribute.##


##Data frame is a two dimensional data structure in R, similar as Matrix.
#data frame is a special case of a list( of vector of equal length) which has each component of equal length.It's a generalized matrix.
#Data frame is used for different types of variables, unlike Matrix.
#data frame has variable number of columns and rows, unlike Matrix.
#The data stored in columns can be only of same data type in Matrix but in data frame,the data stored must be numeric, character or factor type.##


##Create a vector using (15, TRUE, “World”).
x <- c(15, TRUE, "world")
x
print(x) #


##John’s score in final semester for the three subjects (95, 91, 88). 
#Subjects are Statistics, Linear Algebra and Calculus.
#Using these create a vector and give names to all elements of the vector based on their subjects.
final_score_john <- c("statistics" = 95, "Linear Alzebra" = 91, "calculus" = 88)
final_score_john
#or
score_john <- c(95, 91, 88)
score_john
sub_john <- c("Statistics", "Linear Alzebra", "Calculus")
sub_john
names(score_john) <- sub_john
score_john
View(score_john) #


##Check types (character or numeric) of the vector you created.
typeof(final_score_john)
typeof(score_john)
typeof(sub_john) #

##You have three students in your class (Choose any name you want). 
#Create a matrix using their score in above mentioned subjects (question 4) Student 1 (95, 91, 88), Student 2(96, 94, 97), Student 3(88, 98, 85). 
#Create a matrix and also put column and row names.
student_name <- c("Emma", "Amit", "John")
student_name

subject <- c("Statistics", "Linear Algebra", "Calculus")
print(subject)

Emma <- c(95, 91, 88)
Emma
Amit <- c(96, 94, 97)
print(Amit)
John <- c(88, 98, 85)
John
student_name <- c(Emma, Amit, John)
student_name
score <- matrix(student_name, nrow = 3, byrow = TRUE)
score
colnames(score) <- subject
subject
row.names(score) <- student_name
student_name
print(score) #


##Convert the created matrix into a data frame.
score_df = as.data.frame(t(score))
score_df


##Create three vectors using 5 countries (your choice) from the below given website.
#First vector should be country names, 
#second vector should be the total number of cases 
#and third vector should contain total number of deaths. 
#Create a data frame using these vectors. 
#https://www.worldometers.info/coronavirus/ 
country_names <- c("USA", "INDIA", "BRAZIL", "RUSSIA", "UK")
Tot_num_of_cases <- c(28582400, 10976388, 10081676, 4139031, 4095269)
Tot_num_of_deaths <- c(506985, 156237, 244765, 82396, 119920)
corona_cases_df <- data.frame(country_names, Tot_num_of_cases, Tot_num_of_deaths)
print(corona_cases_df) #


##Please read "mtcar" car data set from R. It is an in built data set. 
#Check the structure of the data set. 
#Also, if required, please convert them into their appropriate data types (character, logical, factor, etc). 
#Save your results into a new data frame using a new name. 
mtcars
str(mtcars)
table(mtcars$gear)
mtcars$gear <- as.factor(mtcars$gear)
typeof(mtcars$gear)
str(mtcars)
mtcars$vs <- as.factor(mtcars$vs)
typeof(mtcars$vs)
str(mtcars)
mtcars$am <- as.factor(mtcars$am)
str(mtcars)
mtcars$carb <- as.factor(mtcars$carb)
mtcars$cyl <- as.factor(mtcars$cyl)
str(mtcars)
my_mtcars <- data.frame(mtcars) #new data frame
print(my_mtcars)
str(my_mtcars)
