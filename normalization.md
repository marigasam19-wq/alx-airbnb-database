# Database Normalization

This document explains the normalization process applied to the **Airbnb Clone Database** to ensure the schema meets **Third Normal Form (3NF)**. The goal of normalization is to reduce redundancy, improve data integrity, and make the schema easier to maintain.

---

## Step 1: First Normal Form (1NF)
**Rule:** Eliminate repeating groups; ensure atomic values.

- Removed any fields storing multiple values in one column (e.g., instead of `amenities = "wifi, parking, pool"`, we created a separate **Amenities** table with one row per amenity).
- Ensured each column contains atomic data (e.g., `first_name`, `last_name` instead of `full_name`).
- Each table has a **primary key** to uniquely identify records.

✅ Example:  
Instead of:

| PropertyID | Title       | Amenities            |
|------------|-------------|----------------------|
| 1          | Beach House | wifi, pool, parking  |

We now have:

**Properties Table**  
| PropertyID | Title       |
|------------|-------------|
| 1          | Beach House |

**Amenities Table**  
| AmenityID | Name   |
|-----------|--------|
| 1         | Wifi   |
| 2         | Pool   |
| 3         | Parking|

**PropertyAmenities (Join Table)**  
| PropertyID | AmenityID |
|------------|-----------|
| 1          | 1         |
| 1          | 2         |
| 1          | 3         |

---

## Step 2: Second Normal Form (2NF)
**Rule:** Remove partial dependencies (non-key attributes should depend on the whole primary key).

- For tables with **composite keys**, we ensured non-key attributes depend on the entire key.  
- Example: In the **Bookings** table, attributes like `booking_date` and `status` depend on the **BookingID** (primary key), not just `UserID` or `PropertyID`.

✅ Bookings table in 2NF:  
| BookingID | UserID | PropertyID | StartDate   | EndDate     | Status     |
|-----------|--------|------------|-------------|-------------|------------|
| 101       | 1      | 5          | 2025-09-01  | 2025-09-05  | Confirmed  |

Here, all non-key fields (`StartDate`, `EndDate`, `Status`) depend on the full **BookingID**, not partially on `UserID` or `PropertyID`.

---

## Step 3: Third Normal Form (3NF)
**Rule:** Remove transitive dependencies (non-key attributes should not depend on other non-key attributes).

- Separated data that was indirectly dependent on keys.  
- Example: `city` and `country` were originally stored in **Properties**. This caused redundancy if multiple properties were in the same city.  
  - ✅ Solution: Created a **Locations** table.

✅ Before:  
| PropertyID | Title       | City     | Country |
|------------|-------------|----------|---------|
| 1          | Beach House | Mombasa  | Kenya   |
| 2          | City Loft   | Nairobi  | Kenya   |

✅ After:  

**Properties**  
| PropertyID | Title       | LocationID |
|------------|-------------|------------|
| 1          | Beach House | 1          |
| 2          | City Loft   | 2          |

**Locations**  
| LocationID | City     | Country |
|------------|----------|---------|
| 1          | Mombasa  | Kenya   |
| 2          | Nairobi  | Kenya   |

This prevents redundant storage of `Kenya` across multiple rows.

---

## Final Schema Overview
After applying 3NF, our core entities are:

- **Users** (UserID, Name, Email, PasswordHash, Role)
- **Properties** (PropertyID, Title, Description, Price, HostID, LocationID)
- **Locations** (LocationID, City, Country)
- **Bookings** (BookingID, UserID, PropertyID, StartDate, EndDate, Status)
- **Payments** (PaymentID, BookingID, Amount, Method, Status, Date)
- **Amenities** (AmenityID, Name)
- **PropertyAmenities** (PropertyID, AmenityID)

---

## Conclusion
The schema is now in **Third Normal Form (3NF)**:
- **1NF:** No repeating groups, atomic values.  
- **2NF:** No partial dependencies on part of a composite key.  
- **3NF:** No transitive dependencies between non-key attributes.  

This ensures minimal redundancy, improved consistency, and better scalability for the Airbnb database.