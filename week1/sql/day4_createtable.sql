-- 1. Create dim_customers
CREATE TABLE dim_customers AS
SELECT DISTINCT
	"Customer ID",
	Country
FROM retail
WHERE "Customer ID" IS NOT NULL;

-- 2. Create dim_products
CREATE TABLE dim_product AS
SELECT DISTINCT
	StockCode,
	Description
FROM retail
WHERE StockCode IS NOT NULL;

-- 3. Create fact_orders
CREATE TABLE fact_orders AS
SELECT 
	Invoice,
	InvoiceDate,
	"Customer ID",
	StockCode,
	Quantity,
	Price
FROM retail
WHERE Invoice IS NOT NULL;

-- Pragma 
PRAGMA table_info(dim_customers);
PRAGMA table_info(dim_product);
PRAGMA table_info(fact_orders);