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
--4
SELECT c.customer_id
FROM customer_contracts c
Join products p
on c.product_id = p.product_id
group by c.customer_id
HAVING count(c.customer_id)>2
