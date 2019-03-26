-- 4a. List the last names of actors, as well as how many actors have that last name.
select a.last_name, count(a.last_name) as last_name_counts
from actor a
group by last_name
;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors.
-- select *
-- from
-- 	(select a.last_name, count(a.last_name) as last_name_counts
-- 	from actor a
-- 	group by last_name) as gp
-- where gp.last_name_counts >= 2
-- ;

select a.last_name, count(a.last_name) as last_name_counts
from actor a
group by last_name
having count(a.last_name) >=2
;

-- select a.last_name, count(a.last_name) as last_name_counts
-- from actor a
-- where count(a.last_name) >=2
-- group by last_name

;


-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
update actor 
set first_name = 'HARPO', last_name = 'WILLIAMS'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS'
;

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
SET SQL_SAFE_UPDATES = 0;
update actor 
set first_name = 'GROUCHO'
where first_name = 'HARPO'
;

