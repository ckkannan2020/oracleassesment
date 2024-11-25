CREATE TABLE Products (
    product_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_title VARCHAR2(200) NOT NULL,
    book_price NUMBER(10, 2) CHECK (book_price >= 0),
    book_quantity NUMBER DEFAULT 0 CHECK (book_quantity >= 0)
);