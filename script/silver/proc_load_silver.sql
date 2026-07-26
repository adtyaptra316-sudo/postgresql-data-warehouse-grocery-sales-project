/*
=======================================
LOAD DATA: ETL FROM BRONZE TO SILVER LAYER
=======================================
Script Purpose:
    This script creates a procedure to perform data cleansing and transformation
    from the raw bronze layer to the silver layer tables.

Warning:
    Running this script will truncate/delete all existing data in the silver layer
*/

create or replace procedure silver.load_silver()
language plpgsql
as $$
-- declare internal variables for tracking execution duration
declare
	v_start_time timestamp;
	v_end_time timestamp;
	v_batch_start_time timestamp;
	v_batch_end_time timestamp;
begin
	-- record overall batch start time
	v_batch_start_time:=clock_timestamp();
	raise notice '========================================';
	raise notice 'LOAD SILVER LAYER';
	raise notice '========================================';

	/*
	-----------------------------------
	Load Table: silver.clean_products
	-----------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>>> Truncating Table: silver.clean_products';
	truncate table silver.clean_products;
	raise notice 'Inserting Data into table: silver.clean_products';
	insert into silver.clean_products(
		product_id,
		product_name,
		price,
		category_id,
		class,
		modify_date,
		resistant,
		is_alergant,
		vitality_days)
	select
		product_id,
		-- remove leading/trailing whitespaces from product name
		trim(product_name) as product_name,
		price,
		category_id,
		class,
		modify_date,
		resistant,
		is_alergant,
		-- handle empty values and double-cast string to INT safely
		cast(cast(nullif(trim(vitality_days),'') as decimal) as int) as vitality_days
	from bronze.raw_products;
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds', cast(extract(epoch from(v_end_time - v_start_time)) as text);
	raise notice '------------------------------';


	/*
	-----------------------------------
	Load Table: silver.clean_categories
	-----------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>>> Truncating Table: silver.clean_categories';
	truncate table silver.clean_categories;
	raise notice 'Inserting Data into table: silver.clean_categories';
	insert into silver.clean_categories(
		category_id,
		category_name)
	select
		category_id,
		-- remove leading/trailing whitespace from category_name
		trim(category_name) as category_name
	from bronze.raw_categories;
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds',cast(extract(epoch from(v_end_time - v_start_time))as text);
	raise notice '------------------------------';


	/*
	-----------------------------------
	Load Table: silver.clean_customers
	-----------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>>> Truncating Table: silver.clean_customers';
	truncate table silver.clean_customers;
	raise notice 'Inserting Data into table: silver.clean_customers';
	insert into silver.clean_customers(
		customer_id,
		first_name,
		middle_initial,	
		last_name,
		city_id,
		addres)
	select
		customer_id,
		-- trim whitespace for first_name 
		trim(first_name) as first_name,
		-- convert literal string 'NULL' into actual database NULL
		trim(case
			when middle_initial='NULL' then null
			else middle_initial
		end) as middle_initial,
		-- trim whitespace for last_name
		trim(last_name) as last_name,
		city_id,
		addres
	from bronze.raw_customers;
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds',cast(extract(epoch from(v_end_time - v_start_time))as text);
	raise notice '------------------------------';


	/*
	-----------------------------------
	Load Table: silver.clean_countries
	-----------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>>> Truncating Table: silver.clean_countries';
	truncate table silver.clean_countries;
	raise notice 'Inserting Data into table: silver.clean_countries';
	insert into silver.clean_countries(
		country_id,
		country_name,
		country_code)
	select
		country_id,
		-- trim whitespace for country_name
		trim(country_name) as country_name,
		country_code
	from bronze.raw_countries;
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds',cast(extract(epoch from(v_end_time - v_start_time))as text);
	raise notice '------------------------------';


	/*
	-----------------------------------
	Load Table: silver.clean_cities
	-----------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>>> Truncating Table: silver.clean_cities';
	truncate table silver.clean_cities;
	raise notice 'Inserting Data into table: silver.clean_cities';
	insert into silver.clean_cities(
		city_id,
		city_name,
		zipcode,
		country_id)
	select
		city_id,
		-- trim whitespace for city_name and zipcode
		trim(city_name) as city_name,
		trim(zipcode) as zipcode,
		country_id
	from bronze.raw_cities;
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds',cast(extract(epoch from(v_end_time - v_start_time))as text);
	raise notice '------------------------------';


	/*
	-----------------------------------
	Load Table: silver.clean_employees
	-----------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>>> Truncating Table: silver.clean_employees';
	truncate table silver.clean_employees;
	raise notice 'Inserting Data into table: silver.clean_employees';
	insert into silver.clean_employees(
		employee_id,
		first_name,
		middle_initial,
		last_name,
		birth_date,
		gender,
		city_id,
		hire_date)
	select
		employee_id,
		-- trim whitespace for first_name, middle_initial, and last_name
		trim(first_name) as first_name,
		trim(middle_initial) as middle_initial,
		trim(last_name) as last_name,
		birth_date,
		-- standardize gender code ('M' -> 'Male', 'F'-> 'Female'
		case
			when gender='M' then 'Male'
			when gender='F' then 'Female'
		end as gender,
		city_id,
		hire_date
	from bronze.raw_employees;
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds',cast(extract(epoch from(v_end_time - v_start_time))as text);
	raise notice '------------------------------';


	/*
	-----------------------------------
	Load Table: silver.clean_sales
	-----------------------------------
	*/
	v_start_time:=clock_timestamp();
	raise notice '>>> Truncating Table: silver.clean_sales';
	truncate table silver.clean_sales;
	raise notice 'Inserting Data into table: silver.clean_sales';
	insert into silver.clean_sales(
		sales_id,
		sales_person_id,
		customer_id,
		product_id,
		quantity,
		discount,
		total_price,
		sales_date,
		transaction_number)
	select
		sales_id,
		sales_person_id,
		s.customer_id,
		s.product_id,
		quantity,
		discount,
		-- calculate total_price using product price from table products
		p.price - (p.price * s.discount) as total_price,
		sales_date,
		transaction_number
	from bronze.raw_sales as s
	-- join with products table to fetch unit price
	left join bronze.raw_products as p
		on s.product_id=p.product_id;
	v_end_time:=clock_timestamp();
	raise notice 'Load Duration: % seconds',cast(extract(epoch from(v_end_time - v_start_time))as text);
	raise notice '------------------------------';
	
	-- summary
	v_batch_end_time:=clock_timestamp();
	raise notice '========================================';
	raise notice '>>> Loading Silver Layer is Completed';
	raise notice '>>> Total Duration: % seconds', cast(extract(epoch from (v_batch_end_time - v_batch_start_time)) as text);
	raise notice '========================================';
	
-- exception block to handle errors during execution
exception
	when others then
		raise notice '==========================================';
		raise notice 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		raise notice 'Error Message: %', sqlerrm;
		raise notice 'Error Code: %', sqlstate;
		raise notice '==========================================';
end;
$$;
