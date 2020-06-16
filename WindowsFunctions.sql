
--Grand Total by City
select city, (order_amount/grand_total)*100 pct 
	from (SELECT order_id, order_date, customer_name, city, order_amount
			,SUM(order_amount) OVER(PARTITION BY city) as grand_total 
			FROM [dbo].[Orders]) A;


--average per month
SELECT order_id, order_date, customer_name, city, order_amount
 ,AVG(order_amount) OVER(PARTITION BY city, MONTH(order_date)) as   average_order_amount 
FROM [dbo].[Orders];


--count function
SELECT order_id, order_date, customer_name, city, order_amount
 ,COUNT(order_id) OVER(PARTITION BY city) as total_orders
FROM [dbo].[Orders];


--rank functions assigns the same number for ties
SELECT order_id,order_date,customer_name,city, order_amount,
RANK() OVER(ORDER BY order_amount DESC) [Rank]
FROM [dbo].[Orders]

--dense_rank assigns same number for ties and not skip next number
SELECT order_id,order_date,customer_name,city, order_amount,
DENSE_RANK() OVER(ORDER BY order_amount DESC) [Rank]
FROM [dbo].[Orders]


--ROW_ NUMBER() without PARTITION BY
SELECT order_id,order_date,customer_name,city, order_amount,
ROW_NUMBER() OVER(ORDER BY order_id) [row_number]
FROM [dbo].[Orders];


--ROW_NUMBER() with PARTITION BY
select top 1 with ties a.* from 
(
SELECT order_id,order_date,customer_name,city, order_amount,
ROW_NUMBER() OVER(PARTITION BY city ORDER BY order_amount DESC) [row_number]
FROM [dbo].[Orders]) a
where a.row_number = 1
order by a.order_amount desc;

--LAG() function  previous row order by partition
SELECT order_id,customer_name,city, order_amount,order_date,
 --in below line, 1 indicates check for previous row of the current row
 LAG(order_date,1) OVER(ORDER BY order_date) prev_order_date
FROM [dbo].[Orders];

--LEAD() function next row 
SELECT order_id,customer_name,city, order_amount,order_date,
 --in below line, 1 indicates check for next row of the current row
 LEAD(order_date,1) OVER(ORDER BY order_date) next_order_date
FROM [dbo].[Orders];

--FIRST_VALUE() and LAST_VALUE()
SELECT order_id,order_date,customer_name,city, order_amount,
FIRST_VALUE(order_date) OVER(PARTITION BY city ORDER BY city) first_order_date,
LAST_VALUE(order_date) OVER(PARTITION BY city ORDER BY city) last_order_date
FROM [dbo].[Orders];








