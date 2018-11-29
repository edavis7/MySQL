SELECT * FROM sakila.actor;

#1a
select first_name, last_name
from actor;

#1b
select concat(first_name,  " ", last_name) as Actor_Name
from actor;

#2a
select first_name, last_name 
from actor
where first_name = "Joe";

#2b
select first_name, last_name 
from actor
where last_name  like "%GEN%";

#2c
select last_name, first_name 
from actor
where last_name  like "%LI%";

#2d
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

#3a
select * from actor;
alter table actor 
add column description blob;

#3b
select * from actor;
alter table actor 
drop column description;

#4a
select last_name, count(last_name) as 'Count of last name'
from actor
group by last_name;

#4b
select last_name, count(*) as 'Count of last name'
from actor
group by last_name
having count(*)>=2;

#4c
update actor
set first_name =  'HARPO'
where first_name = 'GROUCHO'
and last_name = 'Williams';

select * from actor
where first_name = 'HARPO';

#4d
update actor
set first_name = 'GROUCHO'
where first_name = 'HARPO' 
and last_name = 'Williams';

#5a
show create table address;

#6a
select staff.first_name, staff.last_name, address.address
from staff
left join address 
on (staff.address_id=address.address_id);

#6b
select first_name, last_name, sum(amount) as 'Total Amount'
from staff
inner join payment
on (staff.staff_id=payment.staff_id)
group by staff.first_name, staff.last_name;

#6c
select count(actor_id), title
from film
inner join film_actor
on (film.film_id=film_actor.film_id)
group by title;

#6d
select count(inventory_id) as 'Total Inventory for Hunchback Impossible'
from film
inner join inventory
on (film.film_id=inventory.film_id)
where title = 'Hunchback Impossible';

#6e
select first_name, last_name, sum(amount) as 'Total Amount Paid'
from customer
inner join payment
on (customer.customer_id=payment.customer_id)
group by customer.first_name, customer.last_name
order by last_name;

#7a
select title
from film
where language_id in 
	(select language_id 
    from language 
    where name = 'English')
and (title like 'K%' or title like 'Q%');   

#7b
select first_name, last_name
from actor
where actor_id in
	(select actor_id 
    from film_actor
    where film_id in
    (select film_id
    from film
    where title = 'Alone Trip'));

#7c
select country, first_name, last_name, email
from country
left join customer
on (country.country_id=customer.customer_id)
where country = 'Canada';

#7d
select title, category
from film_list
where category = 'Family';

#7e
select title, count(film.film_id) as 'Rental_Count'
from film
join inventory
on (film.film_id=inventory.film_id)
join rental
on (inventory.inventory_id=rental.inventory_id)
group by title  
order by Rental_Count DESC;

#7f
select staff.store_id, sum(payment.amount) as 'Revenue'
from payment
join staff
on (payment.staff_id=staff.staff_id)
group by store_id;

#7g
select store_id, city, country
from store
join address
on (store.address_id=address.address_id)
join city
on (address.city_id=city.city_id)
join country
on (city.country_id=country.country_id);

#7h
select category.name 'Genre', sum(payment.amount) as 'Gross'
from category 
join film_category
on (category.category_id=film_category.category_id)
join inventory
on (film_category.film_id=inventory.film_id)
join rental
on (inventory.inventory_id=rental.inventory_id)
join payment
on (payment.rental_id=rental.rental_id)
group by category.name order by sum(payment.amount)  DESC limit 5;

#8a
create view Top_Five_Gross_Genre as
select category.name 'Genre', sum(payment.amount) as 'Gross'
from category 
join film_category
on (category.category_id=film_category.category_id)
join inventory
on (film_category.film_id=inventory.film_id)
join rental
on (inventory.inventory_id=rental.inventory_id)
join payment
on (payment.rental_id=rental.rental_id)
group by category.name order by sum(payment.amount)  DESC limit 5;

#8b
select * from Top_Five_Gross_Genre;

#8c
drop view Top_Five_Gross_Genre;
