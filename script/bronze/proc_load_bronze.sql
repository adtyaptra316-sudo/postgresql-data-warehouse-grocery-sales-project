/*
========================================
LOAD DATA: BULK INSERT TO BRONZE'S TABLES
========================================
Script Purpose:
	script ini akan melakukan bulk insert ke table-table bronze layer
	
Warning:
	menjalankan script ini akan menghapus data yang ada sebelumnya
*/
create or replace procedure bronze.load_bronze()
language plpgsql
as $$
-- declare variable
declare
	v_start_time timestamp;
	v_end_time timestamp;
	v_batch_start_time timestamp;
	v_batch_end_time timestamp;
begin
	v_batch_start_time:=clock_timestamp();
	raise notice '========================================';
	raise notice 'LOADING BRONZE LAYER';
	raise notice '========================================';

	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_products';
	truncate table bronze.raw_products;
	raise notice '>> Inserting data into: bronze.raw_products';
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

	
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_categories';
	truncate table bronze.raw_categories;
	raise notice '>> Inserting data into: bronze.raw_categories';
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

	
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_customers';
	truncate table bronze.raw_customers;
	raise notice '>> Inserting data into: bronze.raw_customers';
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


	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_countries';
	truncate table bronze.raw_countries;
	raise notice '>> Inserting data into: bronze.raw_countries';
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


	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_cities';
	truncate table bronze.raw_cities;
	raise notice '>> Inserting data into: bronze.raw_cities';
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


	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_employees';
	truncate table bronze.raw_employees;
	raise notice '>> Inserting data into: bronze.raw_employees';
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

	
	v_start_time:=clock_timestamp();
	raise notice '>> Truncating table: bronze.raw_sales';
	truncate table bronze.raw_sales;
	raise notice '>> Inserting data into: bronze.raw_sales';
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
	
	
	v_batch_end_time:=clock_timestamp();
	raise notice '========================================';
	raise notice '>> Loading Bronze Layer is Completed';
	raise notice '- Total Duration: % seconds', cast(extract(epoch from (v_batch_end_time - v_batch_start_time)) as text);
	raise notice '========================================';

exception
	when others then
		raise notice '==========================================';
		raise notice 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		raise notice 'Error Message: %', sqlerrm;
		raise notice 'Error Code: %', sqlstate;
		raise notice '==========================================';
end;
$$;
