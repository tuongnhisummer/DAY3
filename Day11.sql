--1
Select Country.continent, round(avg(city.population),0)
From City
Join Country
On City.countrycode = Country.Code
Group by Country.continent
order by round(avg(city.population),0)
--4
SELECT c.customer_id
FROM customer_contracts c
Join products p
on c.product_id = p.product_id
group by c.customer_id
HAVING count(c.customer_id)>2
