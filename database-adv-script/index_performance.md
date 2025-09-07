# ⚡ SQL Indexing and Performance Optimization

## 📌 Objective
Improve query performance by creating indexes on frequently used columns in the **User**, **Booking**, and **Property** tables.

---

## 🔹 What is an Index?
An **index** is like a "lookup table" for the database.  
- Without indexes → the database must **scan the entire table** (slow).  
- With indexes → the database can **jump directly** to the rows it needs (fast).  

👉 Think of it like the index in a book: instead of reading every page, you jump to the page number directly.

---

## 🔹 Indexes Created

### 1. User Table
- **`email`** → often used in `WHERE` conditions (e.g., login checks).  
```sql
CREATE INDEX idx_user_email ON User(email);
```
Emails are often used in login checks:
```sql
SELECT * FROM User WHERE email = 'alice@mail.com';
```
Without an index → the database checks every row until it finds the email.
With this index → it can jump directly to the right row.


### 2. Booking table: user_id
```sql
CREATE INDEX idx_booking_user_id ON Booking(user_id);
```
This speeds up queries that join User and Booking:
```sql
SELECT * FROM Booking b 
JOIN User u ON b.user_id = u.user_id;
```
The index helps the database find all bookings for a given user quickly.


### 3. Booking table: property_id
```sql
CREATE INDEX idx_booking_property_id ON Booking(property_id);
```
Helps when joining Property and Booking:
```sql
SELECT * FROM Property p
JOIN Booking b ON p.property_id = b.property_id;
```
Without index → database scans all bookings.
With index → it instantly finds bookings for a specific property.


### 4. Booking table: start_date
```sql
CREATE INDEX idx_booking_start_date ON Booking(start_date);
```
Useful when filtering bookings by date ranges:
```sql
SELECT * FROM Booking 
WHERE start_date BETWEEN '2025-09-01' AND '2025-09-10';
```
Makes reporting and availability checks much faster.


### 5. Property table: location
```sql
CREATE INDEX idx_property_location ON Property(location);
```
Users often search by location:
```sql
SELECT * FROM Property WHERE location = 'Nairobi';
```
Without index → full table scan.
With index → fast lookup.


### 6. Property table: price per night
```sql
CREATE INDEX idx_property_price ON Property(pricepernight);
```
Helps when sorting or filtering by price:
```sql
SELECT * FROM Property ORDER BY pricepernight;
SELECT * FROM Property WHERE pricepernight < 100;
```
Index allows efficient sorting and filtering instead of scanning all rows.