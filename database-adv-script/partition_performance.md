### Report: Partitioning Improvements
🔍 Before Partitioning
The Booking table is large (millions of rows).
Queries like
```sql
SELECT * FROM Booking 
WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';
```
scanned the entire table, even if we only needed one year’s data.
Result: Slow performance (lots of unnecessary row reads).

### After Partitioning
Table is split into smaller partitions by year (Booking_2023, Booking_2024, etc).
When querying by date range, only the relevant partition is scanned.
Result:
Faster queries (less data scanned).
Better index usage within each partition.
Easier to manage old data (you can drop a partition instead of deleting rows).