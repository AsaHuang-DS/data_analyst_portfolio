-- SELECT Fundamentals
SELECT Invoice, StockCode, Description
FROM retail
LIMIT 20;

-- Column aliasing
SELECT
	Quantity AS qty,
	Price AS  price,
	Quantity * Price AS total_value
FROM retail;

-- Filtering with WHERE
SELECT *
FROM retail
WHERE Country = 'United Kingdom';

-- AND
SELECT *
FROM retail
WHERE Country = 'France'
	AND Quantity > 5;
	
-- OR 
SELECT *
FROM retail
WHERE Country IN ('Germany', 'Austria', 'Switzerland');

-- BETWEEN
SELECT *
FROM retail
WHERE Price BETWEEN 5 AND 10;

-- LIKE (text search)
SELECT *
FROM retail
WHERE Description LIKE '%gift%';

-- Sorting with ORDER BY '
SELECT *
FROM retail
ORDER BY Price DESC;

-- Multiple sort keys
SELECT *
FROM retail
ORDER BY Country, InvoiceDate;

-- Calculation in SELECT
SELECT 
	*,
	Quantity * Price AS line_revenue
FROM retail;

-- More complex
SELECT
	StockCode,
	Description,
	Price,
	Price * 1.2 AS price_with_tax
FROM retail
LIMIT 50;

-- 1. Select all unique countries
SELECT DISTINCT Country
FROM retail;

-- 2. Select the 50 most expensive items
SELECT *
FROM retail
ORDER BY Price DESC
LIMIT 50;

-- 3. Items with the word "Christmas" in the description
SELECT *
FROM retail
WHERE Description LIKE '%Christmas%';

-- 4. All invoices from France in 2010 (strftime) to extract certain year or other dates
SELECT *
FROM retail
WHERE Country = 'France' 
	AND strftime('%Y', InvoiceDate) = '2010';
	
-- 5. Items with Quantity < 0 (returns/corrections)
SELECT *
FROM retail
WHERE Quantity < 0;

-- 6. Compute total value = Quantity * Price for all rows
SELECT Quantity * Price AS total_value
FROM retail;

-- 7. Show top 20 rows sorted by total value descending
SELECT Quantity * Price AS total_value
FROM retail
ORDER BY total_value DESC
LIMIT 20;

-- 8. Filter for items with Price between 1 and 10
SELECT *
FROM retail
WHERE Price BETWEEN 1 and 10;

-- 9. Filter for invoices that contain "POSTAGE"
SELECT *
FROM retail
WHERE Description like '%POSTAGE%';

-- 10. Select rows where customer ID is NULL
SELECT *
FROM retail
WHERE 'Customer ID' IS NULL;

-- 11. Count rows where customer ID is NULL
SELECT COUNT(*)
FROM retail
WHERE 'Customer ID' IS NULL;

--12. Find all invoices for customer 17850
SELECT *
FROM retail
WHERE 'Customer ID' = 13085.0;

-- Show items with Description containing 'PAPER' or 'CARD'
SELECT *
FROM retail
WHERE Description LIKE '%PAPER%' 
	OR Description LIKE '%CARD%';
	
-- 14. Show all rows where the StockCode Starts with 'M'
SELECT *
FROM retail
WHERE StockCode LIKE '%M%';

-- 15. Show all invoices between two invoice dates
SELECT *
FROM retail
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2010-01-01';