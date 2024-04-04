--1
Select  DISTINCT CITY
From STATION
WHERE ID%2=0
--2
SELECT COUNT (CITY) - COUNT (DISTINCT CITY)
FROM STATION
--4
SELECT Round (CAST(sum( item_count*order_occurrences) / sum(order_occurrences) as decimal),1) as mean
FROM items_per_order;
--5
SELECT candidate_id
FROM candidates
Where skill in ('Python','Tableau','PostgreSQL')
Group by candidate_id
Having Count(skill) =3
--6
SELECT user_id, DATE(Max(post_date))- DATE(Min(post_date)) as days_between
FROM posts
Where post_date >= '2021-01-01' and post_date < '2020-01-01'
Group by user_id
Having count(post_id) >= 2;
--7
SELECT card_name, max(issued_amount) - min(issue_month) as difference
FROM monthly_cards_issued
GROUP BY card_name
Order by difference DESC
--8
  SELECT manufacturer, count(drug) as drug_count, ABS(sum(cogs - total_sales)) as loss
FROM pharmacy_sales
Where cogs >total_sales
group by manufacturer
order by loss DESC
--9
Select id, movie, description, rating
From Cinema
where id%2=1 and description <> 'boring'
Order by rating DESC
--10
Select teacher_id, count(distinct subject_id) as cnt
From teacher 
group by teacher_id
--11
Select user_id, count(follower_id) as followers_count
from Followers
Group by user_id
order by user_id
--12
Select class
From Courses
Group by class
Having count(class)>4
