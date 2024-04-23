--1
SELECT extract(year from transaction_date) as year, product_id,
spend as curr_year_spend, lag(spend) over (PARTITION BY product_id order by extract(year from transaction_date)) as prev_year_spend,
round((lag(spend) over (PARTITION BY product_id order by extract(year from transaction_date)) - spend)/lag(spend) over (PARTITION BY product_id order by extract(year from transaction_date))*100,2)
FROM user_transactions
--2
with a as
(select card_name, issued_amount,
rank() over (partition by card_name order by issue_year,issue_month) 
from monthly_cards_issued)
select card_name, issued_amount
from a
where rank =1
order by issued_amount DESC
--3
with a as 
(SELECT user_id, spend, transaction_date, 
rank() Over(partition by user_id order by transaction_date) as rank
FROM transactions)
select user_id, spend, transaction_date
from a  
where rank =3
--4
with a as
(SELECT distinct(transaction_date), user_id, 
rank() over (partition by user_id order by transaction_date DESC) as rank,
count(*) over (partition  by user_id, transaction_date) as purchase_count
from user_transactions)
select transaction_date, user_id, purchase_count
from a
where rank= 1
order by transaction_date
--5
WITH a AS (
  SELECT 
    user_id, tweet_date, tweet_count,
    LAG(tweet_count, 2) OVER (PARTITION BY user_id ORDER BY tweet_date) AS lag2,
    LAG(tweet_count, 1) OVER (PARTITION BY user_id ORDER BY tweet_date) AS lag1
  FROM tweets)
  SELECT 
  user_id, tweet_date,
  CASE WHEN lag1 IS NULL AND lag2 IS NULL THEN ROUND(tweet_count, 2)
    WHEN lag1 IS NULL THEN ROUND((lag2 + tweet_count) / 2.0, 2)
    WHEN lag2 IS NULL THEN ROUND((lag1 + tweet_count) / 2.0, 2)
    ELSE ROUND((lag1 + lag2 + tweet_count) / 3.0, 2)
  END AS rolling_avg_3d
FROM a;
--7
WITH ranking as
(SELECT category, product, sum(spend) as total_spend, rank() over (partition by category order by sum(spend) DESC) as ranking
FROM product_spend
where extract(year from transaction_date) ='2022' 
group by category, product)
select category, product, total_spend
from ranking
where ranking <= 2
--8
with a as (SELECT a.artist_name,g.rank
FROM artists a  
join songs s 
on a.artist_id=s.artist_id
join global_song_rank g  
on s.song_id=g.song_id
where g.rank<=10),
b as (select artist_name,COUNT(*) as count
from a
GROUP BY artist_name),
c as (select artist_name,dense_rank() over (order by count desc) as artist_rank
from b)
select * 
from c 
where artist_rank<=5
