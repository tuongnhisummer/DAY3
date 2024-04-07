--1
select name
from STUDENTS
where marks > 75
order by right(name, 3), id
--2
select user_id, concat(upper(left(name,1)), lower(right(name,length(name)-1))) as name
from Users
order by user_id
--3
SELECT manufacturer, '$'||round(sum(total_sales)/1000000,0)||' '||'million' as sale
FROM pharmacy_sales
group by manufacturer
order by manufacturer, sale DESC
--4
SELECT extract(month from submit_date) as mth, product_id, round(avg(stars),2) as ag
FROM reviews
group by product_id, mth
order by mth, product_id
--5
SELECT sender_id, COUNT(message_id)
FROM messages
where extract(month from sent_date) =8 and extract (year from sent_date) =2022
group by sender_id
--6
select tweet_id
from tweets
where length(content)>15
--8
select count(employee_id)
from employees
Where extract(month from joining_date) between 1 and 7, extract(year from joining_date) = 2022
--9
select position ('a' in first) as position
from worker
where first_name = 'Amitah'
--10
select substring( title, length(winery)+2,4)
from winemag_p2
where country = 'Macedonia'
