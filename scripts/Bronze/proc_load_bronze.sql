/*
===============================================================================
Stored Procedure: Load Bronze Layer (PostgreSQL)
===============================================================================
Purpose:
    Loads CSV data into bronze schema.
    - Truncates tables
    - Loads data using COPY
    - Logs execution time

NOTE:
    COPY works only if files are accessible to PostgreSQL server
===============================================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze_data()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
BEGIN
    batch_start_time := NOW();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '================================================';

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading CRM Tables';
    RAISE NOTICE '------------------------------------------------';

    -- ================= CRM =================

    -- crm_cust_info
    start_time := NOW();
    RAISE NOTICE '>> Truncating: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;

    RAISE NOTICE '>> Loading: bronze.crm_cust_info';
    COPY bronze.crm_cust_info
    FROM 'F:/DATA WAREHOUSE PROJECT/datasets/source_crm/cust_info.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := NOW();
    RAISE NOTICE '>> Duration: % sec', EXTRACT(EPOCH FROM (end_time - start_time));

    -- crm_prd_info
    start_time := NOW();
    RAISE NOTICE '>> Truncating: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;

    COPY bronze.crm_prd_info
    FROM 'F:/DATA WAREHOUSE PROJECT/datasets/source_crm/prd_info.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := NOW();
    RAISE NOTICE '>> Duration: % sec', EXTRACT(EPOCH FROM (end_time - start_time));

    -- crm_sales_details
    start_time := NOW();
    RAISE NOTICE '>> Truncating: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;

    COPY bronze.crm_sales_details
    FROM 'F:/DATA WAREHOUSE PROJECT/datasets/source_crm/sales_details.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := NOW();
    RAISE NOTICE '>> Duration: % sec', EXTRACT(EPOCH FROM (end_time - start_time));

    -- ================= ERP =================

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Loading ERP Tables';
    RAISE NOTICE '------------------------------------------------';

    -- erp_loc_a101
    start_time := NOW();
    RAISE NOTICE '>> Truncating: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;

    COPY bronze.erp_loc_a101
    FROM 'F:/DATA WAREHOUSE PROJECT/datasets/source_erp/LOC_A101.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := NOW();
    RAISE NOTICE '>> Duration: % sec', EXTRACT(EPOCH FROM (end_time - start_time));

    -- erp_cust_az12
    start_time := NOW();
    RAISE NOTICE '>> Truncating: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;

    COPY bronze.erp_cust_az12
    FROM 'F:/DATA WAREHOUSE PROJECT/datasets/source_erp/CUST_AZ12.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := NOW();
    RAISE NOTICE '>> Duration: % sec', EXTRACT(EPOCH FROM (end_time - start_time));

    -- erp_px_cat_g1v2
    start_time := NOW();
    RAISE NOTICE '>> Truncating: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    COPY bronze.erp_px_cat_g1v2
    FROM 'F:/DATA WAREHOUSE PROJECT/datasets/source_erp/PX_CAT_G1V2.csv'
    DELIMITER ','
    CSV HEADER;

    end_time := NOW();
    RAISE NOTICE '>> Duration: % sec', EXTRACT(EPOCH FROM (end_time - start_time));

    -- ================= FINAL =================

    batch_end_time := NOW();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Bronze Layer Load Completed';
    RAISE NOTICE 'Total Duration: % sec',
        EXTRACT(EPOCH FROM (batch_end_time - batch_start_time));
    RAISE NOTICE '================================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE '========================================';
        RAISE NOTICE 'ERROR: %', SQLERRM;
        RAISE NOTICE '========================================';
END;
$$;


call bronze.load_bronze_data();
