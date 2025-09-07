
-- 1. Create a partitioned Booking table
CREATE TABLE Booking (
    booking_id     UUID PRIMARY KEY,
    property_id    UUID NOT NULL,
    user_id        UUID NOT NULL,
    start_date     DATE NOT NULL,
    end_date       DATE NOT NULL,
    total_price    DECIMAL NOT NULL,
    status         ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (YEAR(start_date));

-- 2. Create partitions for different years
CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM (2023) TO (2024);

CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM (2024) TO (2025);

CREATE TABLE Booking_2025 PARTITION OF Booking
    FOR VALUES FROM (2025) TO (2026);

-- You can keep adding partitions as data grows
