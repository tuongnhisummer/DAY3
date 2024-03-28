--1
Select name
From CITY
Where Population > 120000 and CountryCode = 'USA'
--2
Select *
From city
Where COUNTRYCODE ='JPN'
--3
Select City, state
from station
--4
Select distinct City
From Station
Where city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' or city like 'u%'
--5
Select distinct City
From Station
Where city like '%a' or city like '%e' or city like '%i' or city like '%o' or city like '%u'
--6
Select distinct City
From Station
Where not( city like 'A%' or city like 'E%' or city like 'i%' or city like 'o%' or city like 'u%')
--7
Select name
From Employee
Order by name
--8
Select name
From Employee
Where salary >2000 and months <10
--9
Select product_id
From Products
Where low_fats = 'Y' and recyclable = 'Y'
--10
Select name
From Customer
where not referee_id =2 or referee_id is null
--11
Select name, population, area
From World
Where area >= 3000000 or population >= 25000000
--12
select distinct author_id as id
from Views
where article_id >1
order by author_id
--13
SELECT part, assembly_step
FROM parts_assembly
where finish_date is null
--14
select *
from lyft_drivers
where yearly_salary <=30000 or yearly >= 70000
--15
select advertising_channel
from uber_advertising
where money_spent >100000
