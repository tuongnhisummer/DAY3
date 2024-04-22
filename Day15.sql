--1
SELECT extract(year from transaction_date) as year, product_id,
spend as curr_year_spend, lag(spend) over (PARTITION BY product_id order by extract(year from transaction_date)) as prev_year_spend,
round((lag(spend) over (PARTITION BY product_id order by extract(year from transaction_date)) - spend)/lag(spend) over (PARTITION BY product_id order by extract(year from transaction_date))*100,2)
FROM user_transactions
--2

