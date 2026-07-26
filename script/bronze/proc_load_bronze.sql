/*
========================================
LOAD DATA: BULK INSERT TO BRONZE LAYER TABLES
========================================
Script Purpose:
    This procedure performs bulk loading of raw CSV data files into the 
    Bronze Layer tables.
    
Warning:
    Running this procedure will TRUNCATE (delete) all existing data in the 
    Bronze tables before loading the new files.
*/
create or replace procedure bronze.load_bronze()
language plpgsql
as $$
-- declare internal variables for tracking execution
declare
	v_start_time timestamp;
	v_end_time timestamp;
	v_batch_start_time timestamp;
	v_batch_end_time timestamp;
begin
	-- record overall batch start time
	v_batch_start_time:=clock_timestamp();
	raise notice '========================================';
	raise notice 'LOADING BRONZE LAYER';
	raise notice '========================================';


	/*
	------------------------------
	Load Table: bronze.raw_products
	------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_products';
	truncate table bronze.raw_products;
	raise notice '>> Inserting data into: bronze.raw_products';
	-- bulk load raw CSV data into raw_products table
	copy bronze.raw_products
	from 'D:/file belajar/grocery sales database/products.csv'
	with(
		format csv,
		header true,
		delimiter ',',
		quote '"'
		);
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds', cast(extract(epoch from (v_end_time - v_start_time)) as text);
	raise notice '----------------------------------------';

	
	/*
	------------------------------
	Load Table: bronze.raw_categories
	------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_categories';
	truncate table bronze.raw_categories;
	raise notice '>> Inserting data into: bronze.raw_categories';
	-- bulk load raw CSV data into raw_categories table
	copy bronze.raw_categories
	from 'D:/file belajar/grocery sales database/categories.csv'
	with(
		format csv,
		header true,
		delimiter ',',
		quote '"'
		);
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds', cast(extract(epoch from (v_end_time - v_start_time)) as text);
	raise notice '----------------------------------------';

	
	/*
	------------------------------
	Load Table: bronze.raw_customers
	------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_customers';
	truncate table bronze.raw_customers;
	raise notice '>> Inserting data into: bronze.raw_customers';
	-- bulk load raw CSV data into raw_customers table
	copy bronze.raw_customers
	from 'D:/file belajar/grocery sales database/customers.csv'
	with(
		format csv,
		header true,
		delimiter ',',
		quote '"'
		);
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds', cast(extract(epoch from (v_end_time - v_start_time)) as text);
	raise notice '----------------------------------------';


	/*
	------------------------------
	Load Table: bronze.raw_countries
	------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_countries';
	truncate table bronze.raw_countries;
	raise notice '>> Inserting data into: bronze.raw_countries';
	-- bulk load raw CSV data into raw_countries table
	copy bronze.raw_countries
	from 'D:/file belajar/grocery sales database/countries.csv'
	with(
		format csv,
		header true,
		delimiter ',',
		quote '"'
		);
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds', cast(extract(epoch from (v_end_time - v_start_time)) as text);
	raise notice '----------------------------------------';


	/*
	------------------------------
	Load Table: bronze.raw_cities
	------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_cities';
	truncate table bronze.raw_cities;
	raise notice '>> Inserting data into: bronze.raw_cities';
	-- bulk load raw CSV data into raw_cities table
	copy bronze.raw_cities
	from 'D:/file belajar/grocery sales database/cities.csv'
	with(
		format csv,
		header true,
		delimiter ',',
		quote '"'
		);
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds', cast(extract(epoch from (v_end_time - v_start_time)) as text);
	raise notice '----------------------------------------';


	/*
	------------------------------
	Load Table: bronze.raw_employees
	------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_employees';
	truncate table bronze.raw_employees;
	raise notice '>> Inserting data into: bronze.raw_employees';
	-- bulk load raw CSV data into raw_employees table
	copy bronze.raw_employees
	from 'D:/file belajar/grocery sales database/employees.csv'
	with(
		format csv,
		header true,
		delimiter ',',
		quote '"'
		);
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds', cast(extract(epoch from (v_end_time - v_start_time)) as text);
	raise notice '----------------------------------------';

	
	/*
	------------------------------
	Load Table: bronze.raw_sales
	------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_sales';
	truncate table bronze.raw_sales;
	raise notice '>> Inserting data into: bronze.raw_sales';
	-- bulk load raw CSV data into raw_sales table
	copy bronze.raw_sales
	from 'D:/file belajar/grocery sales database/sales.csv'
	with(
		format csv,
		header true,
		delimiter ',',
		quote '"'
		);
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds', cast(extract(epoch from (v_end_time - v_start_time)) as text);
	raise notice '----------------------------------------';
	
	-- summary
	v_batch_end_time:=clock_timestamp();
	raise notice '========================================';
	raise notice '>> Loading Bronze Layer is Completed';
	raise notice '- Total Duration: % seconds', cast(extract(epoch from (v_batch_end_time - v_batch_start_time)) as text);
	raise notice '========================================';

-- exception block to handle errors during bulk loading
exception
	when others then
		raise notice '==========================================';
		raise notice 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		raise notice 'Error Message: %', sqlerrm;
		raise notice 'Error Code: %', sqlstate;
		raise notice '==========================================';
end;
$$;
