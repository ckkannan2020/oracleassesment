BEGIN
    DBMS_SCHEDULER.create_job (
        job_name        => 'UPDATE_PRODUCT_STOCK',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN UPDATE products SET book_quantity = book_quantity - 1 WHERE book_quantity > 0; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=1; BYMINUTE=0; BYSECOND=0',
        enabled         => TRUE
    );
END;

/

