--INNER JOIN to retrieve all bookings and the respective users who made those bookings.

SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM Booking b
INNER JOIN User u 
    ON b.user_id = u.user_id;  


--LEFT JOIN returns all properties, even if there is no review.

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at
FROM Property p
LEFT JOIN Review r
    ON p.property_id = r.property_id;


--FULL OUTER JOIN returns:
--All users (even if they never booked).
--All bookings (even if they aren’t linked to a valid user).

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status
FROM User u
FULL OUTER JOIN Booking b
    ON u.user_id = b.user_id;