use sakila;
# 2.7

#How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT category_id, COUNT(*)   
FROM film AS film  
JOIN film_category AS cat
ON film.film_id = cat.film_id
GROUP BY category_id;

# always start off SELECT with * -> select everything to visualise what the table looks like
# when you chose the right columns, change the SELECT line to the columns you want to use


# Display the total amount rung up by each staff member in August of 2005.

SELECT sta.staff_id, SUM(amount) 
FROM staff AS sta
JOIN payment AS pay
ON sta.staff_id = pay.staff_id
GROUP BY sta.staff_id;

# SELECT columns
# FROM tables as x
# JOIN key as value (y)
# ON x.same_id = y.same_id
# etc.


# Which actor has appeared in the most films?


SELECT actor_id, COUNT(*)
FROM film as fil
JOIN film_actor as ac  
ON fil.film_id = ac.film_id 
GROUP BY actor_id
ORDER BY COUNT(*) DESC;


# Which customer has rented the most movies
# group by customer_id to display most frequent customer

SELECT ren.customer_id, COUNT(*)
FROM rental AS ren
JOIN customer AS cust
ON ren.customer_id = cust.customer_id 
GROUP BY customer_id 
ORDER BY COUNT(*) DESC;


#Show first and last names and address of each staff member.

SELECT first_name, last_name, address
FROM staff AS sta
JOIN address AS ad
ON sta.address_id = ad.address_id;

#List each film and the number of actors that are listed for that film.

SELECT title, COUNT(actor_id)
FROM film AS fil
JOIN film_actor AS act
ON fil.film_id = act.film_id
GROUP BY title;

#Using 
#tables: payment,customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name.

SELECT last_name, SUM(amount)
FROM payment AS paym
INNER JOIN customer AS cust
ON paym.customer_id = cust.customer_id
GROUP BY last_name
ORDER BY last_name ASC;


#List number of films per category

SELECT category_id, COUNT(*)   
FROM film AS film 
LEFT JOIN film_category as cat
ON film.film_id = cat.film_id
GROUP BY category_id;

# 2.8 
#Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country
FROM store AS sto 
JOIN address AS ad 
ON sto.address_id = ad.address_id 
JOIN city AS ci 
ON ad.city_id = ci.city_id 
JOIN country AS co 
ON co.country_id = ci.country_id; 


#Write a query to display how much business, in dollars, each store brought in.

SELECT sta.store_id, SUM(amount)  #every time you write sum/count of second column and not a function on the first column use -> GROUP BY
FROM payment AS pay
JOIN staff AS sta
ON pay.staff_id = sta.staff_id
JOIN store AS sto
ON sta.store_id = sto.store_id
GROUP BY sta.store_id;


#Which film categories are longest?

SELECT name, AVG(length)
FROM film AS fil	
LEFT JOIN film_category AS ficat
ON fil.film_id = ficat.film_id
LEFT JOIN category AS cat
ON ficat.category_id = cat.category_id
GROUP BY name
ORDER BY AVG(length) DESC;


#Display the most frequently rented movies in descending order.

SELECT title, COUNT(*)
FROM  film AS film
INNER JOIN inventory AS inv
ON film.film_id = inv.film_id
INNER JOIN rental AS ren
ON inv.inventory_id = ren.inventory_id
GROUP BY title
ORDER BY COUNT(*) DESC;


#List the top five genres in gross revenue in descending order.
#column: name (in category(genre))

SELECT name, SUM(amount)
FROM  category AS cate
JOIN film_category AS ficat
on ficat.category_id = cate.category_id
JOIN film AS fi
ON fi.film_id = ficat.film_id
JOIN inventory AS inve
ON fi.film_id = inve.film_id
JOIN rental AS rent
ON inve.inventory_id = rent.inventory_id
INNER JOIN payment AS pay
ON pay.rental_id = rent.rental_id
GROUP BY name
ORDER BY SUM(amount) DESC
limit 5;

#Is "Academy Dinosaur" available for rent from Store 1?
# columns: store_id, title


SELECT st.store_id, title
FROM store AS st
JOIN inventory AS inven
ON st.store_id = inven.store_id
JOIN film AS f
ON f.film_id = inv.film_id
WHERE st.store_id = 1 AND title = 'ACADEMY DINOSAUR';


#Get all pairs of actors that have worked together on the same film.

SELECT * FROM film_actor AS A
JOIN film_actor AS B
ON (A.actor_id <> B.actor_id) AND (A.film_id = B.film_id);
