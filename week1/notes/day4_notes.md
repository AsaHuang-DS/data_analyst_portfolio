# Day 4 Notes - SQL Joins & Multi-Table Queries
**Learning Goals**
By the end of Day 4, you should be able to:
- Understand all SQL JOIN types
- Combine data from multiple tables
- Identify when to use INNER, LEFT, RIGHT, FULL JOIN
- Use table aliases to simplify queries
- Answer business style questions using multi-table joins

**Concept Lessons**
**1. SQL JOIN Types**
- INNER JOIN - Returns rows that match both tables
- LEFT JOIN - Returns all rows from the left table, and matching rows from the right table
- RIGHT JOIN - Return all rows from the right table, and matching rows from the left
- FULL OUTER JOIN - Returns all rows from either table, with NULLS where no match exist
- CROSS JOIN - Produces all combinations (Cartesian product)

**2. Table Aliases**
```sql
SELECT c.CustomerID. o.OrderID
FROM Customers c
JOIN Order o
ON c.CustomerID = o.CustomerID
```
Aliases make joins easier to read

**3. JOIN Conditions**
Best practice:
```sql
ON table1.key = table2.key
```
Never put join logic in the WHERE clause.