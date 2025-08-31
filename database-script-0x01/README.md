
## Overview
This schema defines the core entities for the Airbnb-like application:
- **Users** (guests, hosts, admins)
- **Properties** (hosted by users)
- **Bookings** (made by guests on properties)
- **Payments** (linked to bookings)
- **Reviews** (feedback from guests on properties)
- **Messages** (user-to-user communication)

## Normalization
- The schema is normalized up to **Third Normal Form (3NF)**.
- Controlled denormalization: `bookings.total_price` is stored for performance optimization.

## Constraints
- **Primary Keys:** UUIDs for global uniqueness.
- **Foreign Keys:** Enforce referential integrity across tables.
- **Checks:** Ensure valid values for `role`, `status`, `payment_method`, and `rating`.
- **Unique Constraint:** Emails must be unique in the `users` table.

## Indexing
Indexes added for performance on frequently queried columns:
- `users.email`
- `properties.host_id`
- `bookings.property_id`, `bookings.user_id`
- `payments.booking_id`
- `reviews.property_id`, `reviews.user_id`
- `messages.sender_id`, `messages.recipient_id`
