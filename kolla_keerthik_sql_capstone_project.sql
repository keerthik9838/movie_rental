use sakila ; 

show tables ; 

select * from actor_info ; 

-- Task 1 Display the full name of all actors availabe in database 

select concat(first_name," ", last_name) as full_name from actor_info ; 

-- Task 2 
-- Task 2.1 Display the number of times each first name appears in the database .
 
select first_name , count(*) as repeated  from actor_info group by first_name ;


-- Task 2.2 
select distinct(count(first_name)) from actor_info ; 

-- task 2.2.2 
select distinct first_name  from actor_info ; 

-- Task 3.1 Display the number of times each last name appears in the database 

select last_name , count(*) as no_of_times from actor_info group by last_name ;  
 
 -- task 3.2 Display all unique last names in the database 
 
 select last_name  from actor_info group by last_name having count(last_name) < 2 ; 
 
 -- Task 4.1 Display the list of records for the movies with rating 'R'
 
 
 select * from film where rating like 'r%' ;
 
 -- Task 4.2 Display the list of movies that are not related with rating 'R' 
 
 select * from film where rating not like 'r%' ; 
 
 -- Task 4.3 Display the list of records for the movies that are suitable for audience below 13 years of age 
 
select * from film where rating like 'PG-13' ; 


-- Task 5.1 Display the list of records for the movies where replacement cost is up to $11 

  select * from film where replacement_cost <= 11 ; 
  
-- Task 5.2 Display the list of records for the movies where replacement cost between $11 and $ 20 

select * from film where replacement_cost between 11 and 20 ;   
  
-- Task 5.3 Display the list of records in the descending order of their replacement costs 

select * from film order by replacement_cost desc ; 
 
 
 -- Task 6 Display the names of the top 3 movies with the greatest number of actors. 
 
 
select film_id , count(actor_id) as count_actor from film_actor group by film_id order by count_actor desc limit 3; 

select title from film where film_id in (508,146,87) ; 



 -- Task 7 Disply the movies that started with k and q ; 
 
 select * from film where title like 'K%' or 'Q%';
 
 -- Task 8 Display the names of all actors who acted in agent truman movie ? 

 select concat(first_name,' ',last_name) as full_name from actor where actor_id in (select actor_id  from film_actor where film_id in (
 select film_id from film where title = 'AGENT TRUMAN' )) ;
 
 -- Task 9  Identify all the movies categorized as filmy movies . 
 select * from film where rating = 'PG';  
 
 -- Task 10.1 Display maximum , minimum , and average rental rates of movies based on ratings . 
 select * from film ; 
 select rating , max(rental_rate) as max_rate , min(rental_rate) as min_rate ,
 avg(rental_rate) as avg_rate from film group by rating order by  avg_rate desc; 
 
 -- Task 10.2  Display movies in descending order of their rental frequencies .
 select title , count(rental.rental_id) as rent_freq from film left join inventory on film.film_id = inventory.film_id 
 left join rental on inventory.inventory_id = rental.inventory_id group by film.title order by rent_freq desc ; 
 
-- Task 11  In how many film categories , the difference between the average film replacement cost and the average film rental rate is greater than 15 
select count(*) as category_count 
from (
select c.name as category from film as f join film_category as fc on f.film_id = fc.film_id inner join category as c on fc.category_id = c.category_id
group by c.name having avg(f.replacement_cost - f.rental_rate) >15 ) as categories_difference ; 

-- Task 12 Display the film categories in which the number of movies is greater than 70 

select category.name as category , count(film.film_id)  as movie_count from category join film_category on category.category_id = film_category.category_id 
join film on film_category.film_id = film.film_id group by category.name having movie_count > 70; 