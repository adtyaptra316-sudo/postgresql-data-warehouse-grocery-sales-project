/*
========================================
DDL SCRIPT: CREATE BRONZE'S TABLES
========================================
Script Purpose:
	Script ini membuat tabel di layer 'bronze', menghapus tabel yang sudah ada jika memang ada.
	Jalankan script ini untuk mendefinisikan ulang struktur DDL tabel 'bronze'. 
*/

-- Drop and recreate table products
drop table if exists bronze.raw_products;

create table bronze.raw_products(
	product_id int,
	product_name varchar(100),
	price varchar(15),
	category_id int,
	class varchar(15),
	modify_date timestamp,
	resistant varchar(15),
	is_alergant varchar(15),
	vitality_days varchar(15)
);

drop table if exists bronze.raw_categories;

create table bronze.raw_categories(
	category_id int,
	category_name varchar(100)
);

drop table if exists bronze.raw_customers;

create table bronze.raw_customers(
	customer_id int,
	first_name varchar(50),
	middle_initial varchar(1),
	last_name varchar(50),
	city_id int,
	addres varchar(100)
);

drop table if exists bronze.raw_countries;

create table bronze.raw_countries(
	country_id int,
	country_name varchar(50),
	country_code varchar(2)
);

drop table if exists bronze.raw_cities;

create table bronze.raw_cities(
	city_id int,
	city_name varchar(50),
	zipcode varchar (10),
	country_id int
);

drop table if exists bronze.raw_employees;

create table bronze.raw_employees(
	employee_id int,
	firs_name varchar(50),
	middle_initial varchar(1),
	last_name varchar(50),
	birth_date timestamp,
	gender varchar(10),
	city_id int,
	hire_date timestamp
);

drop table if exists bronze.raw_sales;

create table bronze.raw_sales(
	sales_id int,
	sales_person_id int,
	customer_id int,
	product_id int,
	quantity int,
	discount decimal(10,2),
	total_price decimal(10,2),
	sales_date timestamp,
	transaction_number varchar(50)
);
