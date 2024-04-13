--1
Select Country.continent, round(avg(city.population),0)
From City
Join Country
On City.countrycode = Country.Code
Group by Country.continent
order by round(avg(city.population),0)
--2
SELECT cast(sum(case when t.signup_action='Confirmed' then 1 else 0 end) as real)/count(e.email_id) as activation_rate
FROM emails e
RIGHT JOIN texts t
on e.email_id=t.email_id
--3
  Câu này em không nghĩ ra ạ
--4
SELECT c.customer_id
FROM customer_contracts c
Join products p
on c.product_id = p.product_id
group by c.customer_id
HAVING count(c.customer_id)>2
--5
select t1.employee_id, t1.name, count(t2.reports_to) as reports_count, round(avg(t2.age),0) as average_age
from employees t1
left join employees t2
on t1.employee_id = t2.reports_to
where t2.reports_to is not null
--6 
select t1.product_name, sum(t2.unit) as unit
from products t1
join orders t2
on t1.product_id = t2.product_id
where extract(month from t2.order_date) =2
Group by t1.product_id
Having sum(t2.unit)>99 
--7
SELECT p.page_id
FROM pages p    
Left join page_likes l   
on p.page_id = l.page_id
where l.user_id is null
order by p.page_id 


MID-COURSE TEST (ANSWER)
1. 
Select distinct replacement_cost
From film
Order by replacement_cost
Limit 1
2.
 select 
sum(case when replacement_cost >= 9.99 and replacement_cost <= 19.99 then 1 else 0 end) as low_count
from film
3.
Select f.title, f.length, c.name
From film f
Join film_category fc
On f.film_id = fc.film_id
Join category c
On fc.category_id = c.category_id
Where c.name = 'Drama' or c.name ='Sports'
Order by f.length DESC
Limit 1
4.
Select c.name, count(f.title)
From film f
Join film_category fc
On f.film_id = fc.film_id
Join category c
On fc.category_id = c.category_id
Group by c.name
Order by count (f.title) DESC
Limit 1
5.
Select a.first_name, a.last_name, count(f.film_id) 
From actor a
Full join film_actor fa
On  a.actor_id = fa.actor_id
full join film f
on f.film_id = fa.film_id
group by a.actor_id
order by count(f.film_id) DESC
Limit 1
6.
select count (*)
from address a
left join customer c
on a.address_id = c.address_id
where c.customer_id is null
7.
select c.city, sum(p.amount) as revenue
from city c
join address a
on c.city_id = a.city_id
join customer r
on r.address_id = a.address_id
join payment p
on p.customer_id = r.customer_id
Group by c.city_id
order by sum DESC
Limit 1
8.
select c.city||','||' '|| ct.country as name, sum(p.amount) as revenue
from country ct
join city c
on ct.country_id = c.country_id
join address a
on c.city_id = a.city_id
join customer r
on r.address_id = a.address_id
join payment p
on p.customer_id = r.customer_id
Group by c.city_id, ct.country
order by revenue DESC
Limit 1







