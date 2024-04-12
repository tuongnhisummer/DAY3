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
