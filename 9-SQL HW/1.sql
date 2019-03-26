-- 1a. Display the first and last names of all actors from the table acto
select a.first_name, a.last_name
from actor a
;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
select concat(a.first_name, ' ', a.last_name) as 'Actor Name'
from actor a
;
