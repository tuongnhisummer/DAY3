with cte1 as (
select
format_date('%y-%m', date (a.created_at)) as month_year, extract (year from a.created_at) as year,
c.category as product_category, (sum (b.sale_price) - sum (c.cost)) as tpv,
count (a.order_id) as tpo, sum (c.cost) as total_cost,
((sum (b.sale_price) - sum (c.cost)) - sum (c.cost)) as total_profit
from bigquery-public-data.thelook_ecommerce.orders as a 
join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id=b.order_id
join bigquery-public-data.thelook_ecommerce.products as c
on b.product_id=c.id
group by format_date('%y-%m', date (a.created_at)), c.category, extract (year from a.created_at))
-- create view table with revenue growth, order growth, profit to cost ratio
select month_year, year, product_category, tpv, tpo,
100*(tpv - lag (tpv) over (partition by product_category order by month_year asc))/(tpv + lag (tpv) over (partition by product_category order by month_year asc)) ||'%' as revenue_growth,
100*(tpo - lag (tpo) over (partition by product_category order by month_year asc))/(tpo + lag (tpo) over (partition by product_category order by month_year asc)) ||'%' as order_growth,
total_cost, 
total_profit, total_profit/cte1.total_cost as profit_to_cost_ratio
from cte1
--cohort analysis
with cte as 
 (elect user_id,sale_price,
  format_date('%y-%m', date (first_puchase_date)) as cohort_date,
  created_at,
  (extract(year from created_at)-extract(year from first_puchase_date))*12 
  + (extract(month from created_at)-extract(month from first_puchase_date))+ 1 as index
 from 
 (select user_id,sale_price,
  min(created_at) over (partition by user_id) as first_puchase_date,
 created_at
 from bigquery-public-data.thelook_ecommerce.order_items
 where status ='complete'))
 ,cte2 as (
 select cohort_date, index,
  count(distinct user_id) as cnt,
  sum (sale_price) as revenue
 from cte
 where index <=4
 group by 1,2
 order by cohort_date),customer_cohort as 
(select cohort_date,
 sum(case when index = 1 then cnt else 0 end) as t1,
 sum(case when index = 2 then cnt else 0 end) as t2,
 sum(case when index = 3 then cnt else 0 end) as t3,
 sum(case when index = 4 then cnt else 0 end) as t4
 from cte2
 group by cohort_date
 order by cohort_date)
--retention cohort
, retention_cohort as (
select cohort_date,
round(100.00* t1/t1,2)||'%' t1,
round(100.00* t2/t1,2)||'%' t2,
round(100.00* t3/t1,2)||'%' t3,
round(100.00* t4/t1,2)||'%' t4
from customer_cohort)
--churn cohort
select cohort_date,
(100-round(100.00* t1/t1,2))||'%' t1,
(100-round(100.00* t2/t1,2))||'%' t2,
(100-round(100.00* t3/t1,2))||'%' t3,
(100-round(100.00* t4/t1,2))||'%' t4
from customer_cohort
