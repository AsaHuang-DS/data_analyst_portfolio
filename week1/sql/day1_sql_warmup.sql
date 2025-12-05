-- 1. Preview Dataset
SELECT *
FROM retail
LIMIT 10;

-- 2. Unique Customers
SELECT COUNT(DISTINCT "Customer ID")
FROM retail;

-- 3. Count of Transactions
SELECT COUNT(*) 
FROM retail;

-- 4. All invoices for Germany
SELECT *
FROM retail
WHERE country  = 'Germany';

-- 5. Items with Quantity > 10
SELECT *
FROM retail
WHERE Quantity > 10;
