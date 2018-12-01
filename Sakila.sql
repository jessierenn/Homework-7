USE sakila
SELECT first_name, last_name from actor

SELECT DISTINCT CONCAT(UPPER(first_name)," ",UPPER(last_name)) AS "Actor Name"
FROM actor

SELECT FROM actor
WHERE first_name = 'Joe';

SELECT FROM actor
WHERE UPPER(last_name) LIKE '%GEN%';

SELECT FROM actor 
WHERE UPPER(last_name) LIKE '%LI%'
ORDER BY last_name, first_name;

SELECT FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, COUNT(actor_id) AS "Count" FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(actor_id) AS lnCount FROM actor
GROUP BY last_name HAVING lnCount >= 2;

UPDATE actor
SET first_name = 'HARPO' WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';


UPDATE actor
SET first_name = 'GROUCHO' WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

SELECT s.first_name, s.last_name, a.address, a.address2
FROM staff s LEFT  JOIN address a ON s.address_id = a.address_id;

SELECT s.first_name, s.last_name, SUM(p.amount) AS 'TOTAL'
FROM staff s LEFT JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name;

SELECT f.title, COUNT(DISTINCT fa.actor_id) AS "Actor Count"
FROM film f INNER JOIN film_actor fa ON f.film_id = fa.film_id GROUP BY f.title;

SELECT f.title, COUNT(i.inventory_id) AS "Inventory Count"
FROM inventory i INNER JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible' GROUP BY f.title;

SELECT c.first_name, c.last_name, SUM(p.amount) AS "Total Amount Paid"
FROM customer c INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP By c.first_name, c.last_name ORDER BY c.last_name;


SELECT title FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%')
	AND language_id=(SELECT language_id
	FROM language
	where name='English');
    
SELECT first_name, last_name
FROM actor
WHERE actor_id
	IN (SELECT actor_id
FROM film_actor
WHERE film_id 
		IN (SELECT film_id
from film
where title='ALONE TRIP'));

SELECT first_name, last_name, email
FROM customer cu
	JOIN address a ON (cu.address_id = a.address_id)
	JOIN city cit ON (a.city_id=cit.city_id)
	JOIN country cntry ON (cit.country_id=cntry.country_id);

SELECT title
from film f
	JOIN film_category fcat on (f.film_id=fcat.film_id)
	JOIN category c on (fcat.category_id=c.category_id);


SELECT title, COUNT(f.film_id) AS 'Count_of_Rented_Movies'
FROM film f
	JOIN inventory i ON (f.film_id= i.film_id)
	JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title
ORDER BY Count_of_Rented_Movies DESC;

SELECT s.store_id, SUM(p.amount)
FROM payment p
	JOIN staff s ON (p.staff_id=s.staff_id)
GROUP BY store_id;

SELECT store_id, city, country
FROM store s
	JOIN address a ON (s.address_id=a.address_id)
	JOIN city c ON (a.city_id=c.city_id)
	JOIN country cntry ON (c.country_id=cntry.country_id);
    
    
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross"
FROM category c
	JOIN film_category fc ON (c.category_id=fc.category_id)
	JOIN inventory i ON (fc.film_id=i.film_id)
	JOIN rental r ON (i.inventory_id=r.inventory_id)
	JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name
ORDER BY total  LIMIT 5;


CREATE VIEW top_five_genres AS
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
	JOIN film_category fc ON (c.category_id=fc.category_id)
	JOIN inventory i ON (fc.film_id=i.film_id)
	JOIN rental r ON (i.inventory_id=r.inventory_id)
	JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name 
ORDER BY total LIMIT 5;

SELECT * FROM top_five_genres;

DROP VIEW top_five_genres
