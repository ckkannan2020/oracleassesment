--Able to demonstrate the right Transaction Management.

--when adding a customer and purchasing a product, we want to ensure that both actions are completed successfully 
--or rolled back in case of an error.
-- PLSQL Block with Transaction Management, Field Validation, Exception Handling

create or replace procedure proc_transaction_mgmt as
DECLARE
    v_customer_id NUMBER;
    v_product_id NUMBER;
    v_quantity NUMBER := 2;  -- For example, the user wants to purchase 2 books
    v_book_price NUMBER;
    v_total_cost NUMBER;
BEGIN
    -- Transaction Start
    SAVEPOINT start_transaction;

    -- Validate Inputs for Customer Insertion
    IF v_quantity <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Quantity must be greater than 0.');
    END IF;

    -- Customer Insertion with SQL Injection Prevention (using bind variables)
    INSERT INTO customers (customer_id, first_name, last_name, email_office, email_personal, family_members)
    VALUES (customer_seq.NEXTVAL, 'John', 'Doe', 'john.doe@company.com', 'john.doe@gmail.com', 4)
    RETURNING customer_id INTO v_customer_id;

    -- Product Retrieval
    SELECT book_price INTO v_book_price
    FROM products
    WHERE product_id = 101
    FOR UPDATE;

    -- Calculate Total Cost
    v_total_cost := v_book_price * v_quantity;

    -- Insert Product Purchase Record
    INSERT INTO product_purchases (customer_id, product_id, quantity, total_cost)
    VALUES (v_customer_id, 101, v_quantity, v_total_cost);

    -- Commit Transaction if all operations are successful
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK TO start_transaction;
        RAISE_APPLICATION_ERROR(-20002, 'Product not found.');
    WHEN OTHERS THEN
        ROLLBACK TO start_transaction;
        RAISE_APPLICATION_ERROR(-20003, 'Unexpected error: ' || SQLERRM);
END;
/