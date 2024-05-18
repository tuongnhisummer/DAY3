--1
SELECT productline, year_id, dealsize,
SUM (sales) AS revenue
FROM sales_dataset_rfm_prj
GROUP BY productline, year_id, dealsize

--2
SELECT month_id,
SUM (sales) AS revenue,
ordernumber AS order_number
FROM sales_dataset_rfm_prj
GROUP BY month_id, ordernumber
--3
SELECT month_id,
SUM (sales) AS revenue,
ordernumber AS order_number
FROM sales_dataset_rfm_prj
WHERE month_id = 11
GROUP BY month_id, ordernumber
ORDER BY SUM (sales) DESC)
--4
SELECT *
FROM (
SELECT *,
DENSE_RANK () OVER (PARTITION BY year_id ORDER BY revenue) AS RANK
FROM (
SELECT year_id, productline, SUM (sales) AS revenue
FROM sales_dataset_rfm_prj
WHERE country = 'UK'
GROUP BY year_id, productline, country)
ORDER BY RANK () OVER (PARTITION BY year_id, productline ORDER BY revenue))
WHERE RANK = 1
--5
CREATE TABLE segment_score
(segment Varchar,
    scores Varchar)
WITH rfm AS (
SELECT customername,
current_date - MAX(orderdate) AS R,
COUNT (DISTINCT ordernumber) AS F,
SUM (sales) AS M
FROM sales_dataset_rfm_prj
GROUP BY customername),
-- Divide customers into groups
segmentation_score AS (
SELECT customername,
ntile (5) OVER (ORDER BY R DESC) AS r_score,
ntile (5) OVER (ORDER BY F) AS f_score,
ntile (5) OVER (ORDER BY M) AS m_score
FROM rfm)
SELECT a.*, b.segment
FROM (
SELECT customername,
CAST (r_score AS VARCHAR)|| CAST (f_score AS VARCHAR) || CAST (m_score AS VARCHAR) AS seg_score
FROM segmentation_score) AS a
JOIN segment_score AS b ON a.seg_score=b.scores
