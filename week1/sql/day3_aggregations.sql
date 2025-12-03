-- 1. Total number of transactions (invoices) count distinct invoices
SELECT COUNT(DISTINCT Invoice) as total_invoices
FROM retail;

-- 2. Total revenue across the entire datasets
SELECT SUM(Quantity * Price) AS total_revnue
FROM retail;

-- 3. Top 10 highest revenue-generating product. Return: StockCode, Description, Total Revenue (sort descending)
SELECT 
	StockCode,
	Description,
	SUM(Quantity * Price) AS total_revenue
FROM retail
GROUP BY StockCode, Description
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. Revenue by country (top 10 countries) group by country
SELECT 
	Country,
	SUM(Quantity * Price AS total_revenue
FROM retail
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. Monthy sales volume for 2010
SELECT 
	STRFTIME('%m', InvoiceDate) AS month,
	SUM(Quantity) AS total_quantity
FROM retail
WHERE strftime('%Y', InvoiceDate) =  '2010'
GROUP BY month
ORDER BY month;

-- 6. Average basket size per invoice
SELECT 
	ROUND(AVG(basket_size), 2) AS avg_basket_size
FROM (
	SELECT Invoice, SUM(Quantity) as basket_size
	FROM retial
	GROUP BY Invoice
);

-- 7. Customer with more than $2,000 total spending
SELECT 
	"Customer ID",
	SUM(Quantity * Price) AS total_spent
FROM retail
WHERE "Customer ID" IS NOT NULL
GROUP BY "Customer ID"
HAVING total_spent > 2000
ORDER BY total_spent DESC;

-- 8. Find the top 5 most frequently purchases products
SELECT 
	StockCode,
	Description,
	SUM(Quantity) AS total_quantity
FROM retail
GROUP BY StockCode, Description
ORDER BY total_quantity DESC
LIMIT 5;

-- 9. Revenue distribution per customer (min/avg/max)
SELECT 
	MIN(total_revenue) AS min_revenue,
	AVG(total_revenue) AS avg_revenue,
	MAX(total_revenue) AS max_revenue
FROM (
    SELECT 
        "Customer ID",
        SUM(Quantity * Price) AS total_revenue
    FROM retail
    WHERE "Customer ID" IS NOT NULL
    GROUP BY "Customer ID"
);

-- 10. Identify customers with negative or suspicious transactions
SELECT 
	"Customer ID",
	Invoice,
	Quantity,
	Price,
	(Quantity * Price) AS revenue,
	Description
FROM retail
WHERE Quantity < 0 
	OR Price < 0
	OR (Quantity * Price) < 0
ORDER BY "Customer ID", Invoice;

-- Challenge Query: Find the top 5 customers by total revenue in 2011, including number of invoices and average revenue per invoice.
SELECT 
	"Customer ID",
	COUNT(DISTINCT Invoice) AS num_invoices,
	SUM(Quantity * Price) AS total_revenue,
	SUM(Quantity * Price ) / COUNT(DISTINCT Invoice) AS avg_invoice_value,
FROM retail
WHERE "Customer ID" IS NOT NULL
	AND STRFTIME('%Y', InvoiceDate) = '2011'
GROUP BY "Customer ID"
ORDER BY total_revenue DESC
LIMIT 5;

