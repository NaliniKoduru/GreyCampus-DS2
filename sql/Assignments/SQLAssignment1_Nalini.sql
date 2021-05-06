----------------------------------------SQL Assignment1-------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- 1.Do we have actors in the actor table that share the full name and if yes display those shared names.
SELECT * FROM actor;
SELECT first_name, last_name FROM actor;
SELECT COUNT(DISTINCT first_name || last_name) FROM actor;
SELECT DISTINCT a1.first_name, a1.last_name
FROM actor a1 JOIN actor a2
ON a1.actor_id <> a2.actor_id AND a1.first_name = a2.first_name AND a1.last_name = a2.last_name;
-- ANS: Yes. Name is Susan Davis.

-- 2.Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.
SELECT * FROM payment;
SELECT SUM(amount), customer_id FROM payment
WHERE staff_id = 2 GROUP BY customer_id HAVING SUM(amount)>=110;

-- 3.How many films begin with the letter J?
SELECT * FROM film;
SELECT COUNT(*) FROM film
WHERE title LIKE 'J%';
--count with title names.
SELECT COUNT(*), title FROM film
WHERE title ILIKE 'J%' GROUP BY title;
-- ANS: 20

-- 4.What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?
SELECT * FROM customer;
SELECT * FROM customer
WHERE customer_id in ( select max(customer_id) from customer where first_name LIKE 'E%' AND address_id < 500);
-- ANS: Eddie Tomlin

-- 5.How many films have the word Truman somewhere in the title?
SELECT * FROM film;
SELECT * FROM film
WHERE title LIKE '%Truman%';
SELECT COUNT(*) FROM film
WHERE title LIKE '%Truman%';
--ANS: count 5

-- 6.Display the total amount payed by all customers in the payment table.
SELECT SUM(amount) FROM payment;
-- ANS: SUM 61312.04

-- 7.Display the total amount payed by each customer in the payment table.
SELECT SUM(amount) AS Total_payment,customer_id FROM payment
GROUP BY customer_id ORDER BY customer_id;

-- 8.What is the highest total_payment done.
SELECT SUM(amount) AS total_payment FROM payment P
GROUP BY customer_id ORDER BY SUM(amount) DESC;
SELECT MAX(total_payment) from (SELECT SUM(amount) AS total_payment FROM payment
GROUP BY customer_id) P;
-- ANS: 211.55

-- 9.Which customers have not rented any movies so far.
SELECT DISTINCT COUNT(customer_id) FROM rental;
SELECT DISTINCT COUNT(customer_id)FROM customer;
SELECT DISTINCT(customer_id) FROM rental;
SELECT * FROM customer C 
WHERE C.customer_id 
NOT IN (SELECT DISTINCT rental.customer_id FROM rental);
-- ANS: There are no such customers.

-- 10.How many payment transactions were greater than $5.00?
SELECT COUNT(amount)
FROM payment
WHERE amount > 5;
-- ANS: COUNT 3618





