-- Q1. Extract the year, month, and day from InvoiceDate
SELECT
	Invoice,
	InvoiceDate,
	STRFTIME('%Y', InvoiceDate) AS year,
	STRFTIME('%m', InvoiceDate) AS month,
	STRFTIME('%d', InvoiceDate) AS day
FROM fact_orders
LIMIT 20;

-- Q2. Find total revenue per day
SELECT
	DATE(InvoiceDate) AS day,
	SUM(Quantity * Price) AS revenue
FROM fact_orders
GROUP BY DATE(InvoiceDate)
ORDER BY DATE(InvoiceDate);

-- Q3. Find monthly revenue trends
SELECT
	STRFTIME('%Y-%m', InvoiceDate) AS year_month,
	SUM(Quantity * Price) AS revenue
FROM fact_orders
GROUP BY year_month
ORDER BY year_month;

-- Q4. Find the best revenue month of all time
SELECT
	STRFTIME('%Y-%m', InvoiceDate) AS year_month,
	SUM(Quantity * Price) AS revenue
FROM fact_orders
GROUP BY year_month
ORDER BY revenue DESC
LIMIT  1;

-- Q5. Calculate 7-day moving average of daily revenue (SQLite does not support full WINDOW RANGE frames, but we can simulate with a correlated subquery.)
WITH daily_rev AS (
	SELECT 
		DATE(InvoiceDate) AS day,
		SUM(Quantity * Price) AS revenue
	FROM fact_orders
	GROUP BY DATE(InvoiceDate)
)
SELECT 
	d1.day,
	d1.revenue,
	(
		SELECT AVG(d2.revenue)
		FROM daily_rev d2 
		WHERE d2.day BETWEEN DATE(d1.day, '-6 days') AND d1.day
	) AS moving_avg_7d
FROM daily_rev d1
ORDER BY d1.day;

-- Q6. Month-over-month revenue growth
WITH monthly_rev AS (
	SELECT 
		STRFTIME('%Y-%m', InvoiceDate) AS year_month,
		SUM(Quantity * Price) AS revenue
	FROM fact_orders
	GROUP BY year_month
)
SELECT
	year_month,
	revenue,
	LAG(revenue, 1) OVER (ORDER BY year_month) AS previous_month,
	(revenue  - LAG(revenue, 1) OVER (ORDER BY year_month)) / LAG(revenue, 1) OVER (ORDER BY year_month) AS mom_growth
FROM monthly_rev
ORDER BY year_month;