-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select f.title
from film f
inner join language l 
on f.language_id = l.language_id
where f.title like 'K%' or f.title like 'Q%'
;
-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
select f.title, a.first_name, a.last_name
from film f
inner join film_actor fa on f.film_id = fa.film_id
inner join actor a on fa.actor_id = a.actor_id
where f.title = 'Alone Trip'
;
-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select c.first_name, c.last_name, c.email, cry.country
from customer c
inner join address a on c.address_id = a.address_id
inner join city cy on a.city_id = cy.city_id
inner join country cry on cy.country_id = cry.country_id
where cry.country = 'Canada'
;
-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select f.title, ct.name as movie_category
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category ct on fc.category_id = ct.category_id
where ct.name = 'Family'
;
-- 7e. Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as count_rent
from rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
group by f.title
order by (2) desc
;
-- 7f. Write a query to display how much business, in dollars, each store brought in.
select ste.store_id, sum(amount) as business_brought_in
from store ste
inner join staff sta on ste.store_id = sta.store_id
inner join payment py on sta.staff_id = py.staff_id
group by ste.store_id
;
-- 7g. Write a query to display for each store its store ID, city, and country.
select ste.store_id, cy.city, cry.country
from store ste
inner join address a on ste.address_id = a.address_id
inner join city cy on a.city_id = cy.city_id
inner join country cry on cy.country_id = cry.country_id
;
-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select cte.name, sum(py.amount) as gross_revenue
from category cte
inner join film_category fc on cte.category_id = fc.category_id
inner join inventory i on fc.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment py on r.rental_id = py.rental_id
group by cte.name
order by (2) desc
limit 5
;