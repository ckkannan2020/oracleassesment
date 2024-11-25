

--Single-Column Index on email_office: This index will speed up searches based on the email_office field.
CREATE INDEX idx_email_office ON customers(email_office);

CREATE INDEX idx_products_title ON Products(book_title);

--Composite Index on first_name and last_name: This index helps with queries that filter by both first_name and last_name
CREATE INDEX idx_name ON customers(first_name, last_name);



--Unique Index on email_office: This automatically creates a unique constraint and an index, ensuring that no two customers can have the same office email.
-- This automatically creates a unique index for email_office
ALTER TABLE customers ADD CONSTRAINT unique_email_office UNIQUE (email_office);


--Function-Based Index on family_members: This index helps with searches that involve functions (e.g., finding customers with a certain number of family members using a MOD function).

CREATE INDEX idx_family_mod ON customers (MOD(family_members, 2));



