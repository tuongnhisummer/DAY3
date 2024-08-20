--1
select count(*) as duplicate_companies
from (SELECT company_id, title, description, count(*) as count
FROM job_listings
group by company_id, title, description
having count(*)>1) a
--2
WITH ranking as
(SELECT category, product, sum(spend) as total_spend, rank() over (partition by category order by sum(spend) DESC) as ranking
FROM product_spend
where extract(year from transaction_date) ='2022' 
group by category, product)
select category, product, total_spend
from ranking
where ranking <= 2
--3
SELECT COUNT(policy_holder_id) AS member_count
FROM (SELECT
    policy_holder_id,
    COUNT(case_id) AS call_count
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
) AS b;
--4
SELECT p.page_id
FROM pages p    
Left join page_likes l   
on p.page_id = l.page_id
where l.user_id is null
order by p.page_id 
--5*
SELECT 
  EXTRACT(MONTH FROM curr_month.event_date) AS month, 
  COUNT(DISTINCT curr_month.user_id) AS monthly_active_users 
FROM user_actions AS curr_month
WHERE EXISTS (
  SELECT last_month.user_id 
  FROM user_actions AS last_month
  WHERE last_month.user_id = curr_month.user_id
    AND EXTRACT(MONTH FROM last_month.event_date) =
    EXTRACT(MONTH FROM curr_month.event_date - interval '1 month')
)
  AND EXTRACT(MONTH FROM curr_month.event_date) = 7
  AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date);
--6
select Date_format(trans_date,'%Y-%m') as month, country, count(*) as trans_count, sum(case when state ='approved'then 1 else 0 end) as approved_count, sum(amount) as trans_total_amount, sum(case when state ='approved' then amount else 0 end) as approved_total_amount
from Transactions
group by month, country
--7
with a as
(select product_id, min(year) as first_year, quantity, price From Sales
Group by product_id)
Select p.product_id, a.first_year, a.quantity, a.price
From Product p
Join  a
on p.product_id = a.product_id
group by product_id
c2
    select product_id, year as first_year, quantity, price
from sales 
where exists
(select product_id, min(year)
from sales
group by product_id)
group by product_id
--8
select customer_id
where count(distinct product_id) = (select count(product_key) from Product)
--9
select a.employee_id
from Employees a
join Employees b
on a.employee_id = b.manager_id
where a.salary <30000
--10
select count(*) as duplicate_companies
from (SELECT company_id, title, description, count(*) as count
FROM job_listings
group by company_id, title, description
having count(*)>1) a
--11
(select u.name as results
from Users u
join MovieRating m on u.user_id = m.user_id
group by u.user_id
order by count(movie_id) desc, name asc
limit 1)
union all
(select title as results
from Movies u
join MovieRating m on u.movie_id = m.movie_id
where year(created_at) = '2020' and month(created_at) = '02'
group by u.movie_id
order by avg(rating) desc, title asc
limit 1)
--12
with a as(select requester_id id from RequestAccepted
union all
select accepter_id id from RequestAccepted)
select id, count(*) num  from a group by 1 order by 2 desc limit 1
