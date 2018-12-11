use sakila;
-- 1a.
select first_name from actor;
select last_name from actor;
select first_name, last_name from actor;

ALTER TABLE actor ADD COLUMN actor_names int auto_increment primary key 
first;
-- 1b.
select upper(concat(first_name, ' ', last_name)) as actors_name from actor;
-- 2a.
select first_name, last_name, actor_id from actor
where upper(first_name) like 'JOE';
-- 2b
select first_name, last_name, actor_id from actor
where upper(last_name) like '%GEN%';
-- 2c. 
select last_name, first_name, actor_id from actor
where upper(last_name) like '%LI%';
-- 2d. 
select country_id, country from country
where country in("Afghanistan", 'Bangladesh', 'China');

-- 3a. 
alter table actor add column discription blob;
-- 3b
alter table actor drop column discription;

-- 4a. 
select last_name from actor;
select count(distinct(last_name)) from actor;
-- 4b. 
select last_name from actor
group by last_name
having count(last_name) = 2;
-- 4c. 
update actor
set first_name = 'GROUCHO' where first_name =  'HARPO' and last_name = 'WILLIAMS';

select * from actor where first_name =  'GROUCHO' and last_name = 'WILLIAMS';
-- 4d.
update actor 
set first_name = 'HARPO' where first_name =  'GROUCHO' and last_name = 'WILLIAMS';

select * from actor where first_name =  'HARPO' and last_name = 'WILLIAMS';
-- 5a. 
SHOW CREATE TABLE address;
-- 6a. 
select * from staff
join address on
staff.address_id = address.address_id;
-- 6b. 
select sum(amount) as 'staff made' from payment
join staff on
staff.staff_id = payment.staff_id
where payment.payment_date >= '2005-08'and payment.staff_id = 1;

select sum(amount) as 'staff made' from payment
where payment.payment_date >= '2005-08'and payment.staff_id = 2;

select sum(amount) from payment
where payment.payment_date = '2005-08'and payment.staff_id = 1;
-- 6c. 
select sum(actor_id), title from film_actor
inner join film on film_actor.film_id = film.film_id
group by title;
-- where film_actor.film_id = film_actor.film_id;
-- select count(distinct(actor_id)), film_id from film_actor
-- for film_id;
-- 6d. 
select first_name, last_name, sum(amount) as 'total amount' from payment
join customer on customer.customer_id = payment.customer_id
group by customer.customer_id order by last_name;
-- 7a.
select title from film
where title like 'k%' or title like 'q%';
-- 7b. 
select  first_name, last_name from actor
join film_actor on film_actor.actor_id = actor.actor_id
join film on film_actor.film_id = film.film_id
where title = 'Alone Trip';
-- 7c. 
select email from customer
join address on address.address_id = customer.address_id
join city on address.city_id = city.city_id
join country on country.country_id = city.country_id
where country = 'Canada';
-- 7d. 
select title from film
join film_category on film.film_id = film_category.film_id
join category on category.category_id = film_category.category_id
where name = 'Family';
-- 7e. 
select sum(amount) from payment
join customer on customer.customer_id = payment.customer_id
group by customer.store_id;
-- 7f. 
select district, country, city from address
join city on city.city_id = address.city_id
join country on city.country_id = country.country_id
join store on store.address_id = address.address_id
group by store.store_id;
-- 7g. 
select name from category
join film_category on film_category.category_id = category.category_id
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on payment.rental_id = rental.rental_id
group by category.name order by sum(payment.amount)
desc limit 5;
-- 8a. 
create view top_5_genres as
select name from category
join film_category on film_category.category_id = category.category_id
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on payment.rental_id = rental.rental_id
group by category.name order by sum(payment.amount)
desc limit 5;
-- 8b.
-- send data base to my boss
-- 8c. 
drop view top_5_genres;
