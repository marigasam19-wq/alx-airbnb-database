### Monitoring and Refining Database Performance

## 1. Monitor Queries with EXPLAIN / ANALYZE
These tools show how SQL executes a query and where it spends time.
Example: Check performance of a query fetching bookings + user details.
```sql
EXPLAIN ANALYZE
SELECT 
    b.booking_id, b.start_date, b.end_date, u.first_name, u.last_name
FROM Booking b
INNER JOIN User u 
    ON b.user_id = u.user_id
WHERE b.start_date BETWEEN '2025-01-01' AND '2025-12-31';
```

Output (simplified idea):
Shows if indexes are used.
Shows how many rows are scanned.
Highlights if the query is doing a full table scan (slow).


## 2. Identify Bottlenecks
From monitoring, possible issues might be:
---Full Table Scans: Queries scanning millions of rows instead of using indexes.
---Unoptimized Joins: Joining large tables without indexes on join keys.
---Sorting/Grouping inefficiencies: ORDER BY, GROUP BY on non-indexed columns.


## 3. Suggested Improvements
🛠 Indexes

Add missing indexes on columns used in WHERE, JOIN, or ORDER BY.
```sql
-- Index to speed up date range queries
CREATE INDEX idx_booking_start_date ON Booking(start_date);
-- Index to optimize join with User table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
```
🛠 Schema Adjustments
Normalization: Avoid duplicate data storage to reduce table size.
Denormalization (rare cases): For analytics queries, pre-compute aggregates into a summary table.