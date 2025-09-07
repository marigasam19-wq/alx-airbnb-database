-- Indexes to optimize queries

-- 1. User table: email is often used in WHERE clauses (login, search)
CREATE INDEX idx_user_email ON User(email);

-- 2. Booking table: user_id is often used in JOINs with User
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- 3. Booking table: property_id is often used in JOINs with Property
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- 4. Booking table: start_date is often queried for date ranges (analytics, availability checks)
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- 5. Property table: location is often used in search filters
CREATE INDEX idx_property_location ON Property(location);

-- 6. Property table: pricepernight is often queried for sorting/filtering
CREATE INDEX idx_property_price ON Property(pricepernight);
