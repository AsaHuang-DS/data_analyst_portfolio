-- Q1. Total revenue by country
SELECT  
	c.Country,
	ROUND(SUM(o.Quantity * o.Price), 2) AS total_revenue
FROM fact_orders o
JOIN dim_customers c
	ON o."Customer ID" = c."Customer ID"
	GROUP BY c.Country 
	ORDER BY total_revenue DESC;
	
-- Q2. Top 10 customers by spending
SELECT 
	o."Customer ID",
	ROUND(SUM(o.Quantity * o.Price), 2) AS total_spent
FROM fact_orders o
GROUP BY o."Customer ID"
ORDER BY total_spent DESC
LIMIT 10;

-- Q3. Total revenue per product description
SELECT
	p.Description,
	ROUND(SUM (o.Quantity * o.Price), 2) AS total_revenue
FROM fact_orders o
JOIN dim_product p
	ON o.StockCode = p.StockCode
GROUP BY p.Description
ORDER BY total_revenue DESC
LIMIT 10;

-- Q4. Number of invoices per customer by country
SELECT 
	c.Country,
	o."Customer ID",
	COUNT (DISTINCT o.Invoice) AS num_invoices
FROM fact_orders o
JOIN dim_customers c
	ON o."Customer ID" = c."Customer ID"
GROUP BY c.Country, o."Customer ID"
ORDER BY  num_invoices DESC;

-- Q5. Revenue per country per product
SELECT 
	c.Country,
	p.Description,
	ROUND(SUM(o.Quantity * o.Price), 2) AS total_revenue
FROM fact_orders o
JOIN dim_customers c ON o."Customer ID" = c."Customer ID"
JOIN dim_product p ON o.StockCode = p.StockCode
GROUP BY c.Country, p.Description
ORDER BY total_revenue DESC
LIMIT 20;

-- Q6. Prdocut with the higheset return rate (Quantity < 0)
SELECT
	p.Description,
	ABS(SUM(o.Quantity)) AS total_returned
FROM fact_orders o
JOIN dim_product p ON o.StockCode = p.StockCode
WHERE o.Quantity < 0 
GROUP BY p.Description
ORDER BY total_returned DESC
LIMIT 10;

-- Q7. Average order value by country
WITH invoice_totals AS (
    SELECT 
        o.Invoice,
        c.Country,
        SUM(o.Quantity * o.Price) AS InvoiceTotal
    FROM fact_orders o
    JOIN dim_customers c 
        ON o."Customer ID" = c."Customer ID"
    GROUP BY o.Invoice, c.Country
)
SELECT 
    Country,
    ROUND(AVG(InvoiceTotal), 2) AS avg_invoice_value
FROM invoice_totals
GROUP BY Country
ORDER BY avg_invoice_value DESC;
