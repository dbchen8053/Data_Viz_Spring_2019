-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
select s.first_name, s.last_name, a.address
from staff s
inner join address a
on s.address_id = a.address_id
;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
select s.first_name, s.last_name, p.payment_date, sum(p.amount) as total_amout
from staff s
inner join payment p
on s.staff_id = p.staff_id
where p.payment_date between '2005-08-01' and '2005-08-31'
group by s.staff_id
;


-- select s.staff_id, s.first_name, s.last_name, sum(a_payment.amount) as total_amout
-- from staff s
-- inner join
-- (
-- select p.staff_id, p.payment_date, p.amount
-- from payment p
-- where p.payment_date between '2005-08-01' and '2005-08-31') as a_payment
-- on s.staff_id = a_payment.staff_id
-- group by staff_id
-- ;

-- select p.staff_id, p.payment_date, sum(p.amount)
-- from payment p
-- where p.payment_date between '2005-08-01' and '2005-08-31'
-- group by staff_id
-- ;
-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select f.title, count(fa.actor_id) as number_of_actors
from film f
inner join film_actor fa
on f.film_id = fa.film_id
group by f.title
;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select hi.title, count(i.inventory_id)
from inventory i
inner join (
select f.film_id, f.title
from film f
where f.title = 'Hunchback Impossible') as hi
on i.film_id = hi.film_id
;

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select c.first_name, c.last_name, sum(cp.amount)
from customer c
inner join
(select p.customer_id, p.amount
from payment p) as cp
on c.customer_id = cp.customer_id
group by c.customer_id
order by (2)
;



