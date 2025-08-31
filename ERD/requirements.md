---mermaid
erDiagram
    USER {
        uuid user_id PK "Primary Key"
        string first_name
        string last_name
        string email UNIQUE "Indexed"
        string password_hash
        string phone_number
        enum role "guest | host | admin"
        datetime created_at
    }

    PROPERTY {
        uuid property_id PK "Primary Key"
        uuid host_id FK "References USER(user_id)"
        string name
        text description
        string location
        decimal price_per_night
        datetime created_at
        datetime updated_at
    }

    BOOKING {
        uuid booking_id PK "Primary Key"
        uuid property_id FK "References PROPERTY(property_id)"
        uuid user_id FK "References USER(user_id)"
        date start_date
        date end_date
        decimal total_price
        enum status "pending | confirmed | canceled"
        datetime created_at
    }

    PAYMENT {
        uuid payment_id PK "Primary Key"
        uuid booking_id FK "References BOOKING(booking_id)"
        decimal amount
        datetime payment_date
        enum payment_method "credit_card | paypal | stripe"
    }

    REVIEW {
        uuid review_id PK "Primary Key"
        uuid property_id FK "References PROPERTY(property_id)"
        uuid user_id FK "References USER(user_id)"
        int rating "1–5"
        text comment
        datetime created_at
    }

    MESSAGE {
        uuid message_id PK "Primary Key"
        uuid sender_id FK "References USER(user_id)"
        uuid recipient_id FK "References USER(user_id)"
        text message_body
        datetime sent_at
    }

    %% Relationships
    USER ||--o{ PROPERTY : "hosts"
    USER ||--o{ BOOKING : "makes"
    USER ||--o{ REVIEW : "writes"
    USER ||--o{ MESSAGE : "sends"
    USER ||--o{ MESSAGE : "receives"
    PROPERTY ||--o{ BOOKING : "is booked in"
    PROPERTY ||--o{ REVIEW : "is reviewed"
    BOOKING ||--o{ PAYMENT : "has"
    BOOKING ||--o{ REVIEW : "receives"
