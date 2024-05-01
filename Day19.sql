--1
Alter table sales_dataset_rfm_prj
Alter column ordernumber TYPE numeric USING (trim(ordernumber):: numeric)
Alter table sales_dataset_rfm_prj
Alter column quantityordered TYPE numeric USING (trim(quantityordered):: numeric) 
Alter table sales_dataset_rfm_prj
Alter column priceeach TYPE numeric USING (trim(priceeach):: numeric)
Alter table sales_dataset_rfm_prj
Alter column orderlinenumber TYPE numeric USING (trim(orderlinenumber):: numeric)
SET datestyle = 'iso,mdy';  
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderdate TYPE date USING (TRIM(orderdate):: date)
--2
select ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERUMBER, SALES, ORDERDATE
from sales_dataset_rfm_prj
where ORDERNUMBER is null or QUANTITYORDERED is null or PRICEEACH is null or ORDERLINENUMBER is null or SALES is null or ORDERDATE is null 
--3
Alter table sales_dataset_rfm_prj
Add CONTACTLASTNAME varchar(50)
Update sales_dataset_rfm_prj
set CONTACTLASTNAME = right(contactfullname,length(contactfullname)-position('-' in contactfullname))
Alter table sales_dataset_rfm_prj
Add CONTACTFIRSTNAME varchar(50)
Update sales_dataset_rfm_prj
set CONTACTFIRSTNAME = left(contactfullname,position('-' in contactfullname)-1)
--4
Alter table sales_dataset_rfm_prj
add QTR_ID numeric
Alter table sales_dataset_rfm_prj
add MONTH_ID numeric
Alter table sales_dataset_rfm_prj
add YEAR_ID numeric
Update sales_dataset_rfm_prj
Set month_id = extract(month from orderdate)
Update sales_dataset_rfm_prj
Set year_id = extract(year from orderdate)
Update sales_dataset_rfm_prj
Set qtr_id = (case when month_id in (1,2,3) then 1 when month_id in (4,5,6) then 2 when month_id in (7,8,9) then 3 else 4 end)
--5
c1
with min_max_value as
(select Q1-1.5*IQR as min_value, Q1+1.5*IQR as max_value
From (select 
percentile_cont (0.25) WITHIN GROUP (order by quantityordered) as Q1,
percentile_cont (0.75) WITHIN GROUP (order by quantityordered) as Q2,
percentile_cont (0.75) WITHIN GROUP (order by quantityordered)-percentile_cont (0.75) WITHIN GROUP (order by quantityordered) as IQR
from sales_dataset_rfm_prj) as a)
select *
from sales_dataset_rfm_prj
where quantityordered <(select min_value from min_max_value) or quantityordered > (select max_value from Min_max_value)
Kết luận MIN = MAX nên không có Outlier
  
C2 (ở cách 2 lúc em chọn z_score >2 or >3 thì có xuất hiện outlier (khác với c1, vậy cách nào mới đúng ạ)
with cte as
(select quantityordered, 
(select avg(quantityordered) from sales_dataset_rfm_prj) as avg, 
 (select stddev(quantityordered) From sales_dataset_rfm_prj) as stddev
 from sales_dataset_rfm_prj)
 select quantityordered, (quantityordered-avg)/stddev as z_score
 from cte
--6 (chỗ lọc dữ liệu em không biết lọc theo trường ordernumber có đúng không ạ, tại lúc lọc có rất nhiều dữ liệu bị trùng ạ)
select *
from (select row_number() over (partition by ordernumber order by orderdate) as stt,*
from sales_dataset_rfm_prj) a
where stt =1
?
create table SALES_DATASET_RFM_PRJ_CLEAN as
(select *
from (select row_number() over (partition by ordernumber order by orderdate) as stt,*
from sales_dataset_rfm_prj) a
where stt =1)

