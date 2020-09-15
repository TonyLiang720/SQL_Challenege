-- Which actors have the first name ‘Scarlett’? 2
select
a1.actor_id,
a1.first_name,
a1.last_name,
a1.last_update
from sakila.actor a1
where
a1.first_name = 'Scarlett'

;

-- Which actors have the last name ‘Johansson’? 3
select
a1.actor_id,
a1.first_name,
a1.last_name,
a1.last_update
from sakila.actor a1
where
a1.last_name = 'Johansson'

;

-- How many distinct actors last names are there? 121
select
count(distinct a1.last_name) as distinct_last_name
from sakila.actor a1

;

-- Which last names are not repeated?
select
a3.last_name,
a3.sum_last_name
from
	(select 
	a2.last_name,
	sum(a2.count_last_name) sum_last_name
	from
		(select
		a1.last_name,
		1 count_last_name
		from sakila.actor a1) a2
	group by 
	a2.last_name) a3
where
a3.sum_last_name = 1

;

-- Which last names appear more than once?
select
a3.last_name,
a3.sum_last_name
from
	(select 
	a2.last_name,
	sum(a2.count_last_name) sum_last_name
	from
		(select
		a1.last_name,
		1 count_last_name
		from sakila.actor a1) a2
	group by 
	a2.last_name) a3
where
a3.sum_last_name > 1

-- Which actor has appeared in the most films? Gina Degeneres
select
a2.actor_id,
a2.count_film,
a3.first_name,
a3.last_name
from
	(select
	a1.actor_id,
	count(a1.film_id) count_film
	from sakila.film_actor a1 
	group by
	a1.actor_id) a2
left outer join sakila.actor a3 on a2.actor_id = a3.actor_id
order by a2.count_film desc

-- Is ‘Academy Dinosaur’ available for rent from Store 1? Yes, 4 copies
select
a1.inventory_id,
a1.film_id,
a1.store_id,
a2.title
from sakila.inventory a1
left outer join sakila.film a2 on a1.film_id = a2.film_id
where
a2.title = 'ACADEMY DINOSAUR'
and a1.store_id = 1

-- 2. Find all actors whose last names contain the letters "LI". Order the rows by last name and first name, in that order.
select
a1.actor_id,
a1.first_name,
a1.last_name,
a1.last_update
from sakila.actor a1
where 1 = 1 
and a1.last_name like '%LI%'

-- 3. List the last names of actors, as well as how many actors have that last name.
select
a1.last_name,
count(a1.first_name) sum_actors
from sakila.actor a1
group by a1.last_name

-- 4. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors.
select
a2.last_name,
a2.sum_actors
from
    (select
	a1.last_name,
	count(a1.first_name) sum_actors
	from sakila.actor a1
	group by a1.last_name) a2
where a2.sum_actors >= 2

-- 5. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
update
sakila.actor a1
set
a1.first_name = 'HARPO'
where
a1.first_name = 'GROUCHO'
and a1.last_name = 'WILLIAMS'

-- 6. It turns out that GROUCHO was the correct name after all. In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
update
sakila.actor a1
set
a1.first_name = 'GROUCHO'
where
a1.first_name = 'HARPO'

-- 7. Display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China.
select
a1.country_id,
a1.country
from sakila.country a1
where
a1.country in ('Afghanistan', 'Bangladesh', 'China')

-- 8. Use a join to display the first and last names, as well as the address, of each staff member. Use the tables named staff and address.
select
a1.first_name,
a1.last_name,
a1.address_id,
a2.address
from sakila.staff a1
left outer join sakila.address a2 on a1.address_id = a2.address_id