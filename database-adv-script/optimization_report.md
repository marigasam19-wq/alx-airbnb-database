#  Optimize Complex Queries

##  Objective
The goal of this task is to **refactor complex queries** to improve performance.  
We will:
1. Write a complex query joining multiple tables.  
2. Analyze its performance using `EXPLAIN ANALYZE`.  
3. Add indexes and refactor the query.  
4. Compare results before and after optimization.  

---

## 1 Initial Query

We need to retrieve:
- All **bookings**  
- Along with **user details**, **property details**, and **payment details**

```sql
-- perfomance.sql (initial query)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date DESC;
