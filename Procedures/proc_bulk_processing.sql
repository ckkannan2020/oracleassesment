--7. Caching and Bulk Processing
--Oracle allows for bulk processing with FORALL and BULK COLLECT to improve performance when working with large datasets.

create or replace procedure prc_bulk_processing as
    TYPE customer_array IS TABLE OF Customers%ROWTYPE;
    v_customers customer_array;
BEGIN
    -- Bulk collect data from Customers
    SELECT * BULK COLLECT INTO v_customers
    FROM Customers
    WHERE family_members > 2;

    -- Bulk insert into another table (for example, create a backup)
    FORALL i IN 1..v_customers.COUNT
        INSERT INTO Customer_Backup (customer_id, first_name, last_name)
        VALUES (v_customers(i).customer_id, v_customers(i).first_name, v_customers(i).last_name);

    COMMIT;
END;
/