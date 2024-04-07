--1
SELECT 
SUM(CASE 
WHEN device_type ='laptop' THEN '1' ELSE 0 END) AS laptop_reviews,
SUM(CASE 
WHEN device_type ='tablet' or device_type ='phone'THEN '1' ELSE 0 END) AS mobile_reviews
FROM viewership;
--2
Select x,y,z,
CASE
WHEN x+y > z and y+z> z and x+z> y THEN 'Yes' ELSE 'No' END as triangle
From Triangle
--3
SELECT *
round(CAST(count(case_id)/sum(case when call_category is null Then 1 ELSE 0 end )*100 as integer),1) as call_percentage
FROM callers;
--4
Select name
From Customer
where not referee_id =2 or referee_id is null
--5
Select
Sum(CASE pclass = 1 THEN survived ELSE 0 END) as first_class_survivos,
Sum(CASE pclass = 2 THEN survived ELSE 0 END) as second_class_survivos,
Sum(CASE pclass = 3 THEN survived ELSE 0 END) as third_class_survivos,
Sum(CASE pclass = 1 THEN passengerid - survived ELSE 0 END) AS first_class_non-survivos,
Sum(CASE pclass = 2 THEN passengerid - survived ELSE 0 END) AS second_class_non-survivos,
Sum(CASE pclass = 3 THEN passengerid - survived ELSE 0 END) AS third_class_non-survivos
from titanic
