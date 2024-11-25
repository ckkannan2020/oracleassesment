CREATE TABLE Customers (
    customer_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email_office VARCHAR2(100) NOT NULL UNIQUE,
    email_personal VARCHAR2(100) NULL,
    family_members NUMBER DEFAULT 0 CHECK (family_members >= 0)
);