--To prevent SQL injection, always use bind variables and avoid directly embedding user inputs into SQL queries.
--Unsanitized inputs directly concatenate user data into SQL queries, allowing malicious code injection.

create or replace procedure proc_sql_injection as
    v_email VARCHAR2(100);
BEGIN
    -- Using bind variables to prevent SQL Injection
    v_email := 'john.doe@company.com';
    FOR rec IN (SELECT * FROM Customers WHERE email_office = v_email) LOOP
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || rec.customer_id);
    END LOOP;
END;
/
