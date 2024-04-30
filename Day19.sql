--1
--2
select ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE
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
