## Write Complex Queries with Joins

## join_quaries.sql

## 1. INNER JOIN

Returns only rows that have matches in both tables.

If there is no match, the row is excluded.

Syntax:

SELECT columns
FROM table1
INNER JOIN table2
    ON table1.column = table2.column;


Example:

SELECT u.user_id, u.name, b.booking_id, b.property
FROM Users u
INNER JOIN Bookings b
    ON u.user_id = b.user_id;


Result:

Shows only users who made bookings.

Users with no bookings are excluded.

## 2. LEFT JOIN

Returns all rows from the LEFT table, plus matching rows from the RIGHT table.

If there’s no match, the RIGHT side is filled with NULL.

Syntax:

SELECT columns
FROM table1
LEFT JOIN table2
    ON table1.column = table2.column;


Example:

SELECT u.user_id, u.name, b.booking_id, b.property
FROM Users u
LEFT JOIN Bookings b
    ON u.user_id = b.user_id;


Result:

Shows all users.

If a user has no booking, booking details are NULL.

## 3. FULL OUTER JOIN

Returns all rows from both tables.

Matches are combined.

Non-matching rows are shown with NULL.

Syntax (PostgreSQL, SQL Server, Oracle):

SELECT columns
FROM table1
FULL OUTER JOIN table2
    ON table1.column = table2.column;


Example:

SELECT u.user_id, u.name, b.booking_id, b.property
FROM Users u
FULL OUTER JOIN Bookings b
    ON u.user_id = b.user_id;


Result:

Shows all users (even without bookings).

Shows all bookings (even if they don’t belong to a user).



## subqueries.sql

#  SQL Subqueries: Correlated & Non-Correlated


##  Non-Correlated Subquery

###  Task
Find all properties where the **average rating** is greater than `4.0`.

### 🛠 Query
```sql
SELECT p.property_id, p.name, p.location
FROM Property p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);


###Correlated Subqueries

## 📌 What is a Correlated Subquery?
A **correlated subquery** is a subquery that depends on the outer query for its values.  
- It runs **once for each row** of the outer query.  
- The inner query cannot run on its own; it uses columns from the outer query.

---

##  Example Task
**Find users who have made more than 3 bookings.**

---

## 🛠 Query
```sql
SELECT u.user_id, u.first_name, u.last_name, u.email
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3;
```
## Query
```sql
Write a query to find the total number of bookings made by 
each user, using the COUNT function and GROUP BY clause.

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM User u
LEFT JOIN Booking b
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;
```

Step-by-Step Explanation
1. FROM User u

We start with the User table.
This gives us all users, e.g.:

user_id	first_name	last_name
1	Alice	Kim
2	Bob	Lee
3	Carol	Okoth
2. LEFT JOIN Booking b ON u.user_id = b.user_id

We join the Booking table to each user.

If a user has bookings, they’ll be matched.

If a user has no bookings, they’ll still appear (because it’s a LEFT JOIN) but with NULL values for bookings.

Result after the join (simplified):

user_id	 name	booking_id
1	     Alice	    101
1	     Alice	    102
1	     Alice	    103
2	     Bob	    104
2	     Bob	    105
3	     Carol	    NULL

3. COUNT(b.booking_id)

The COUNT function counts how many bookings (booking_id) each user has.

Alice → 3 bookings

Bob → 2 bookings

Carol → 0 bookings (because no rows matched, but still included thanks to LEFT JOIN).

4. GROUP BY u.user_id, u.first_name, u.last_name

We group rows by user so that each user appears once in the final result.
Without GROUP BY, we’d get multiple rows per booking.

Now the grouped result looks like:

user_id 	name	total_bookings
1	       Alice	         3
2	       Bob	             2
3	       Carol	         0

5. ORDER BY total_bookings DESC

Finally, we sort the results in descending order of bookings.

So the output becomes:

user_id 	name	total_bookings
1 	        Alice	        3
2	        Bob	            2
3	        Carol	        0


## B Use a window function (ROW_NUMBER, RANK) to rank properties 
   # based on the total number of bookings they have received 

SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_rank
FROM Property p
LEFT JOIN Booking b
    ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY property_rank;

Step-by-Step Explanation
1. FROM Property p

We start with the Property table:

property_id 	name
  1	            Sea Villa
  2	            City Loft
  3	            Safari Hut

2. LEFT JOIN Booking b ON p.property_id = b.property_id

We join the Booking table to each property.

If a property has bookings → they are matched.

If a property has no bookings, it still appears (because of LEFT JOIN) but with NULL values for booking_id.

Example after join:

property_id	  name	booking_id
1	Sea       Villa	       101
1	Sea       Villa	       102
2	City      Loft	       103
2	City      Loft	       104
2	City      Loft	       105

3	Safari Hut	NULL
3. COUNT(b.booking_id) AS total_bookings

We count how many bookings each property has.

Sea Villa → 2 bookings

City Loft → 3 bookings

Safari Hut → 0 bookings

4. GROUP BY p.property_id, p.name

We group by property so that we get one row per property.
Now our result looks like:

property_id 	name    	total_bookings
1	           Sea Villa	  2
2	           City Loft	  3
3	           Safari Hut     0

5. RANK() OVER (ORDER BY COUNT(b.booking_id) DESC)

Here comes the window function part.

We rank properties based on total bookings, highest first (DESC).

If two properties have the same number of bookings, they get the same rank.

So the result becomes:

property_id	   name 	   total_bookings  	property_rank
2	           City Loft	    3                 	1
1	           Sea Villa	    2	                2
3	           Safari Hut	    0	                3

6. ORDER BY property_rank

We sort the final table by rank so the most booked properties appear first.

