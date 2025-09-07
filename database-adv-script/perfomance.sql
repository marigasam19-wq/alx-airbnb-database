/*This query retrieves all bookings along with:
User details
Property details
Payment details*/

---Initial Complex Query (unoptimized)
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


---Optimized Query
-- perfomance.sql (optimized query)
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
/* Use indexed joins */
INNER JOIN User u 
    ON b.user_id = u.user_id
INNER JOIN Property p 
    ON b.property_id = p.property_id
LEFT JOIN Payment pay 
    ON b.booking_id = pay.booking_id
/* Ensure index usage on sorting */
ORDER BY b.start_date DESC;


