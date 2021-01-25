USE sakila;

-- 1 --
SELECT s.store_id, ci.city, co.country
FROM store as s
	join address as a
		on s.address_id = a.address_id
	join city as ci
		on a.city_id = ci.city_id
	join country as co
		on ci.country_id = co.country_id
group by s.store_id
order by s.store_id;

-- 2 --
SELECT * FROM payment;

SELECT s.store_id, co.country, sum(p.amount) AS business_per_store
FROM store as s
	join customer as c
		on s.store_id = c.store_id
	join payment as p
		on c.customer_id = p.customer_id
	join address as a
		on s.address_id = a.address_id
	join city as ci
		on a.city_id = ci.city_id
	join country as co
		on ci.country_id = co.country_id
group by s.store_id
order by business_per_store DESC;

-- 3 --
SELECT c.name, round(avg(f.length),2) AS average_length
FROM category as c
	left join film_category as fc
		on c.category_id = fc.category_id
	left join film as f
		on fc.film_id = f.film_id
group by c.name
order by average_length DESC;

-- 4 --
SELECT c.name, round(avg(f.length),2) AS average_length
FROM category as c
	join film_category as fc
		on c.category_id = fc.category_id
	join film as f
		on fc.film_id = f.film_id
group by c.name
order by average_length DESC
LIMIT 3;

-- 5 --
SELECT f.title, count(r.rental_id) AS most_frequently_rented
FROM rental as r
	join inventory as i
		on r.inventory_id = i.inventory_id
	join film as f
		on i.film_id = f.film_id
group by f.title
order by most_frequently_rented DESC;

-- 6 --
SELECT c.name, sum(p.amount) AS revenue
FROM category as c
	left join film_category as fc
		on c.category_id = fc.category_id
	left join film as f
		on fc.film_id = f.film_id
	left join inventory as i
		on f.film_id = i.film_id
	left join rental as r
		on i.inventory_id = r.inventory_id
	left join payment as p
		on r.rental_id = p.rental_id
group by c.name
order by revenue DESC
LIMIT 5;

-- 7 --
SELECT f.title, s.store_id, r.rental_date, r.return_date
FROM film as f
	join inventory as i
		on f.film_id = i.film_id
	join rental as r
		on i.inventory_id = r.inventory_id
	join store as s
		on i.store_id = s.store_id
where f.title = 'Academy Dinosaur' and r.return_date < CURDATE() and s.store_id = 1
#group by s.store_id
order by r.return_date DESC;