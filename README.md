# Query_app
This is my query app

After the download of the repository, you can install two docker-containers. There will be a database server with Northwind db and a web server which uses tomcat.

For the installation you shoud start the Install.sh file from the Query_app folder. If you try it from another folder, then you will get an error.

You can make queries by visiting http://localhost:8080 page on the guest machine after the installation.

#### A few example queries:

```sql

-- Which product is made by whom
SELECT p.product_name AS product, s.company_name AS company
FROM products AS p
JOIN suppliers AS s
ON p.supplier_id = s.supplier_id 
ORDER BY p.product_name;

-- How many products are in each category
SELECT c.category_name AS category, COUNT(*) AS number_of_products
FROM products AS p
JOIN categories AS c
ON p.category_id = c.category_id
GROUP BY c.category_name
Order by number_of_products DESC, C.category_name ASC; 

--numbers for the year 1997 broken down by months
SELECT EXTRACT(YEAR FROM o.order_date) AS year,
	   EXTRACT(MONTH FROM o.order_date) AS month,
	   COUNT(*) AS order_count,
	   ROUND(SUM (unit_price*quantity*(1-discount)))
FROM public.orders AS o	
INNER JOIN public.order_details AS od
	ON o.order_id = od.order_id
GROUP BY EXTRACT(YEAR FROM o.order_date), EXTRACT(MONTH FROM o.order_date)
HAVING EXTRACT(YEAR FROM o.order_date) = '1997'

-- all US customers who have less than 5 orders:
SELECT c.company_name, 
	   COUNT(*) AS orders, 
	   ARRAY_TO_STRING(ARRAY_AGG(o.order_id), ', ') AS order_ids
FROM public.customers AS c
JOIN public.orders AS o
	ON c.customer_id = o.customer_id
WHERE c.country = 'USA'
GROUP BY c.company_name
HAVING COUNT(*)<5
ORDER BY orders ASC;

```