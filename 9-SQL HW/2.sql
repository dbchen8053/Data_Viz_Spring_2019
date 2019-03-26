-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select a.actor_id, a.first_name, a.last_name
from actor a
where a.first_name = 'Joe'
;

-- 2b. Find all actors whose last name contain the letters GEN:
select a.actor_id, a.first_name, a.last_name
from actor a
where a.last_name like '%GEN%'
;

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
select a.actor_id, a.first_name, a.last_name
from actor a
where a.last_name like '%LI%'
order by a.last_name, a.first_name
;

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
select c.country_id, c.country
from country c
where c.country in ('Afghanistan', 'Bangladesh', 'China')
;
