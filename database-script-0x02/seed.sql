-- Insert sample Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    (UUID(), 'sammy', 'mariga', 'sam@example.com', 'hashed_pass1', '0715907311', 'guest', NOW()),
    (UUID(), 'eunice', 'mumbi', 'mumbi@example.com', 'hashed_pass2', '0720311468', 'host', NOW()),
    (UUID(), 'Caroline', 'Mwangi', 'caroline@example.com', 'hashed_pass3', '0715907311', 'admin', NOW());

-- Insert sample Properties
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at)
VALUES
    (UUID(), (SELECT user_id FROM User WHERE email='sam@example.com'), 'Beachfront Villa', 'Luxury villa by the ocean', 'Mombasa, Kenya', 120.00, NOW(), NOW()),
    (UUID(), (SELECT user_id FROM User WHERE email='sam@example.com'), 'Nairobi Apartment', 'Modern 2-bedroom apartment', 'Nairobi, Kenya', 70.00, NOW(), NOW());

-- Insert sample Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    (UUID(), (SELECT property_id FROM Property WHERE name='Beachfront Villa'), (SELECT user_id FROM User WHERE email='sam@example.com'), '2025-09-01', '2025-09-05', 480.00, 'confirmed', NOW()),
    (UUID(), (SELECT property_id FROM Property WHERE name='Nairobi Apartment'), (SELECT user_id FROM User WHERE email='sam@example.com'), '2025-10-10', '2025-10-15', 350.00, 'pending', NOW());

-- Insert sample Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
    (UUID(), (SELECT booking_id FROM Booking WHERE status='confirmed'), 480.00, NOW(), 'credit_card');

-- Insert sample Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    (UUID(), (SELECT property_id FROM Property WHERE name='Beachfront Villa'), (SELECT user_id FROM User WHERE email='calorine@example.com'), 5, 'Amazing stay! Highly recommended.', NOW());

-- Insert sample Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    (UUID(), (SELECT user_id FROM User WHERE email='sam@example.com'), (SELECT user_id FROM User WHERE email='eunice@example.com'), 'Hello, is the villa available in September?', NOW());
