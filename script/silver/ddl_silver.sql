/*
========================================
DDL SCRIPT: CREATE SILVER'S TABLES
========================================
Script Purpose:
	This script drops existing silver tables (if any) and recreates them.
	Silver tables hold cleansed, standardized, and transformed data 
	prepared for downstream analytics and gold layer ingestion.
    
Warning:
    Dropping tables will permanently remove all cleansed data stored in this layer.
*/
drop table if exists silver.clean_products;
create table silver.clean_products(
	product_id int,
	product_name varchar(100),
	price decimal(12,4),
	category_id int,
	class varchar(15),
	modify_date timestamp,
	resistant varchar(15),
	is_alergant varchar(15),
	vitality_days int,		-- change data type from varchar(15) to integer
	dwh_created_date timestamp default current_timestamp		-- create technical column for ETL process load timestamp
);


drop table if exists silver.clean_categories;
create table silver.clean_categories(
	category_id int,
	category_name varchar(100),
	dwh_created_date timestamp default current_timestamp		-- create technical column for ETL process load timestamp
);


drop table if exists silver.clean_customers;
create table silver.clean_customers(
	customer_id int,
	first_name varchar(50),
	middle_initial varchar(1),		-- change data type from varchar(10) to varchar(1)
	last_name varchar(50),
	full_name varchar(104),			-- create derived column full name
	city_id int,
	addres varchar(255),
	dwh_created_date timestamp default current_timestamp		-- create technical column for ETL process load timestamp
);


drop table if exists silver.clean_countries;
create table silver.clean_countries(
	country_id int,
	country_name varchar(50),
	country_code varchar(2),
	dwh_created_date timestamp default current_timestamp		-- create technical column for ETL process load timestamp
);


drop table if exists silver.clean_cities;
create table silver.clean_cities(
	city_id int,
	city_name varchar(50),
	zipcode varchar (10),
	country_id int,
	dwh_created_date timestamp default current_timestamp		-- create technical column for ETL process load timestamp
);


drop table if exists silver.clean_employees;
create table silver.clean_employees(
	employee_id int,
	first_name varchar(50),
	middle_initial varchar(1),		-- change data type from varchar(10) to varchar(1)
	last_name varchar(50),
	full_name varchar(104),			-- create derived column full name
	birth_date timestamp,
	gender varchar(10),
	city_id int,
	hire_date timestamp,
	dwh_created_date timestamp default current_timestamp		-- create technical column for ETL process load timestamp
);


drop table if exists silver.clean_sales;
create table silver.clean_sales(
	sales_id int,
	sales_person_id int,
	customer_id int,
	product_id int,
	quantity int,
	discount decimal(10,2),
	total_price decimal(12,4),
	sales_date timestamp,
	transaction_number varchar(255),
	dwh_created_date timestamp default current_timestamp		-- create technical column for ETL process load timestamp
);
