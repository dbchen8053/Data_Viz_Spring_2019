-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
create view Top_Fve_Generes as 
(
select cte.name, sum(py.amount) as gross_revenue
from category cte
inner join film_category fc on cte.category_id = fc.category_id
inner join inventory i on fc.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
inner join payment py on r.rental_id = py.rental_id
group by cte.name
order by (2) desc
limit 5)
;
-- 8b. How would you display the view that you created in 8a?
select *
from top_fve_generes
;
-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
drop view top_fve_generes
;