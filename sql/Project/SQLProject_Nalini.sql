--------------------------- SQL PROJECT -------------------------------------
-----------------------------------------------------------------------------

-- 1.How can you retrieve all the information from the cd.facilities table?

SELECT * FROM cd.facilities;

-- 2.You want to print out a list of all of the facilities and their cost to members. 
-- How would you retrieve a list of only facility names and costs?

SELECT name, membercost FROM cd.facilities;

-- 3.How can you produce a list of facilities that charge a fee to members?

SELECT *  FROM cd.facilities
WHERE membercost > 0;

-- 4.How can you produce a list of facilities that charge a fee to members,
-- and that fee is less than 1/50th of the monthly maintenance cost?
-- Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.

SELECT facid, name, membercost, monthlymaintenance FROM cd.facilities
WHERE membercost > 0 AND membercost < monthlymaintenance/50;

-- 5.How can you produce a list of all facilities with the word 'Tennis' in their name?

SELECT * FROM cd.facilities
WHERE name ILIKE '%Tennis%';

-- 6.How can you retrieve the details of facilities with ID 1 and 5? 
-- Try to do it without using the OR operator.

SELECT * FROM cd.facilities
WHERE facid IN (1,5);

-- 7.How can you produce a list of members who joined after the start of September 2012? 
-- Return the memid, surname, firstname, and joindate of the members in question.

SELECT * FROM cd.members;
SELECT memid, surname, firstname, joindate FROM cd.members
WHERE joindate >= '2012-09-01';

-- 8.How can you produce an ordered list of the first 10 surnames in the members table? 
-- The list must not contain duplicates.

SELECT DISTINCT(surname) FROM cd.members
ORDER BY surname ASC LIMIT 10;

-- 9.You'd like to get the signup date of your last member.
-- How can you retrieve this information?

SELECT MAX(joindate) FROM cd.members;

-- 10.Produce a count of the number of facilities that have a cost to guests of 10 or more?

SELECT COUNT(*) FROM cd.facilities
WHERE guestcost >= 10;

-- 11.Produce a list of the total number of slots booked per facility in the month of September 2012.
-- Produce an output table consisting of facility id and slots, sorted by the number of slots.

SELECT facid, SUM(slots) AS totalnumberofslots FROM cd.bookings
WHERE cd.bookings.starttime BETWEEN '2012-09-01' AND '2012-09-30'
GROUP BY facid
ORDER BY SUM(slots);

-- 12.Produce a list of facilities with more than 1000 slots booked.
-- Produce an output table consisting of facility id and total slots, sorted by facility id.

SELECT facid, SUM(slots) AS Totalslots FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000 
ORDER BY facid;

-- 13.How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'?
-- Return a list of start time and facility name pairings, ordered by the time.

SELECT starttime, name AS facilityname FROM cd.bookings B
INNER JOIN cd.facilities F
ON B.facid = F.facid
WHERE name LIKE '%Tennis Court%' AND starttime BETWEEN '2012-09-21 00:00:00' AND '2012-09-21 23:59:59'
ORDER BY starttime;

-- 14.How can you produce a list of the start times for bookings by members named 'David Farrell'?

SELECT starttime, firstname,surname FROM cd.bookings B
INNER JOIN cd.members M
ON B.memid = M.memid
WHERE firstname ILIKE '%David%' AND surname ILIKE '%Farrell%'
ORDER BY starttime;

-- TO find the count

SELECT COUNT(*) FROM 
 (SELECT starttime, firstname,surname FROM cd.bookings B
INNER JOIN cd.members M
ON B.memid = M.memid
WHERE firstname ILIKE '%David%' AND surname ILIKE '%Farrell%') A;
-- ANS: count 34 Rows of timestamp


--------------------------------- SQL DATABASE ----------------------------------

-- Create a new database called "School" this database should have two tables: teachers and students.
-- The students table should have columns for student_id, first_name,last_name, homeroom_number, phone,email, and graduation year.
-- The teachers table should have columns for teacher_id, first_name, last_name, homeroom_number, department, email, and phone.
-- The constraints are mostly up to you, but your table constraints do have to consider the following:
-- We must have a phone number to contact students in case of an emergency.
-- We must have ids as the primary key of the tables
-- Phone numbers and emails must be unique to the individual.

-- Creating school database.
CREATE DATABASE School;
-- Creating 'students' table.
CREATE TABLE students(
	
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	homeroom_number integer,
	phone VARCHAR(200) UNIQUE NOT NULL,
	email VARCHAR(50) UNIQUE,
	graduation_year INTEGER
);

-- Creating 'teachers' table.
CREATE TABLE teachers(
	
	teacher_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL, 
	last_name VARCHAR(50) NOT NULL,
	homeroom_number INTEGER,
	department VARCHAR(50),
	email VARCHAR(50) UNIQUE, 
	phone VARCHAR(200) UNIQUE
);

-- To check the tables.
SELECT * FROM students;
SELECT * FROM teachers;

-- Once you've made the tables, 
-- insert a student named Mark Watney (student_id=1) who has a phone number of 777-555-1234 and doesn't have an email.
-- He graduates in 2035 and has 5 as a homeroom number.

-- Insert values into the 'students' table.
INSERT INTO students(student_id, first_name, last_name, homeroom_number, phone, graduation_year)
VALUES (1, 'Mark', 'Watney', 5, '777-555-1234', 2035);

-- Shows the 'students' table information.
SELECT * FROM students;

-- Then insert a teacher names Jonas Salk (teacher_id = 1) who as a homeroom number of 5
-- and is from the Biology department. 
-- His contact info is: jsalk@school.org and a phone number of 777-555-4321.

-- Insert values into 'teachers' table.
INSERT INTO teachers(teacher_id, first_name, last_name, homeroom_number, department, email, phone)
VALUES (1, 'Jonas', 'Salk', 5, 'Biology', 'jsalk@school.org', '777-555-4321');

-- Shows the 'teachers' table information.
SELECT * FROM teachers;

--------------------------------------- END ----------------------------------------------------------





