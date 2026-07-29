/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
*/

-- ====================================================================
-- Checking 'silver.clean_products'
-- ====================================================================
-- Check for NULLs or duplicates in primary key
-- Expectation: no results

select product_id, count(*) from silver.clean_products
group by product_id
having count(*)>1 or product_id is null;

-- Check for unwanted spaces
-- Expectation: no results

select product_name from silver.clean_products
where product_name != trim(product_name);


-- ====================================================================
-- Checking 'silver.clean_categories'
-- ====================================================================
-- Check for NULLs or duplicates in primary key
-- Expectation: no results

select category_id, count(*) from silver.clean_categories
group by category_id
having count(*)>1 or category_id  is null;

-- Check for unwanted spaces
-- Expectation: no results

select category_name from silver.clean_categories
where category_name != trim(category_name);


-- ====================================================================
-- Checking 'silver.clean_customers'
-- ====================================================================
-- Check for NULLs or duplicates in primary key
-- Expectation: no results

select customer_id , count(*) from silver.clean_customers
group by customer_id 
having count(*)>1 or customer_id  is null;

-- Check for unwanted spaces
-- Expectation: no results

select first_name from silver.clean_customers
where first_name != trim(first_name);

select last_name from silver.clean_customers
where last_name != trim(last_name);

-- Data standardization
select distinct middle_initial from silver.clean_customers;

-- Data consistency
-- Expectation: no results
select full_name from silver.clean_customers
where full_name !=
	concat_ws(
			' ',
			nullif(trim(first_name),''),
			case
			 	when nullif(trim(middle_initial),'') is not null
			 			and nullif(trim(middle_initial),'') !='NULL'
			 		then concat(rtrim(trim(middle_initial),'.'),'.')
			 	else null
			 end,
			 nullif(trim(last_name),'')
			 );


-- ====================================================================
-- Checking 'silver.clean_countries'
-- ====================================================================
-- Check for NULLs or duplicates in primary key
-- Expectation: no results

select country_id, count(*) from silver.clean_countries
group by country_id 
having count(*)>1 or country_id  is null;

-- Check for unwanted spaces
-- Expectation: no results

select country_name from silver.clean_countries
where country_name != trim(country_name);


-- ====================================================================
-- Checking 'silver.clean_cities'
-- ====================================================================
-- Check for NULLs or duplicates in primary key
-- Expectation: no results

select city_id, count(*) from silver.clean_cities
group by city_id
having count(*)>1 or city_id is null;

-- Check for unwanted spaces
-- Expectation: no results

select city_name from silver.clean_cities
where city_name != trim(city_name);

select zipcode from silver.clean_cities
where zipcode != trim(zipcode);


-- ====================================================================
-- Checking 'silver.clean_cities'
-- ====================================================================
-- Check for NULLs or duplicates in primary key
-- Expectation: no results

select employee_id , count(*) from silver.clean_employees
group by employee_id
having count(*)>1 or employee_id is null;

-- Check for unwanted spaces
-- Expectation: no results

select first_name from silver.clean_employees
where first_name != trim(first_name);

select middle_initial from silver.clean_employees
where middle_initial != trim(middle_initial);

select last_name from silver.clean_employees
where last_name != trim(last_name);

-- Data standardization
select distinct gender from silver.clean_employees;

-- Data consistency
-- Expectation: no results
select full_name from silver.clean_employees
where full_name !=
	concat_ws(
			' ',
			nullif(trim(first_name),''),
			case
			 	when nullif(trim(middle_initial),'') is not null
			 			and nullif(trim(middle_initial),'') !='NULL'
			 		then concat(rtrim(trim(middle_initial),'.'),'.')
			 	else null
			 end,
			 nullif(trim(last_name),'')
			 );


-- ====================================================================
-- Checking 'silver.clean_sales'
-- ====================================================================
-- Check for NULLs or duplicates in primary key
-- Expectation: no results

select sales_id  , count(*) from silver.clean_sales
group by sales_id 
having count(*)>1 or sales_id  is null;

select customer_id from silver.clean_sales
where customer_id is null or customer_id =0;

-- Check data consistency: total_price = (price * quantity)*(1-discount)
-- Expectation: no results
select cs.total_price as clean_total_price,round((rs.quantity * rp.price) * (1 - rs.discount),4) as expected_total_price
from silver.clean_sales cs
join bronze.raw_sales rs
on cs.sales_id=rs.sales_id
left join bronze.raw_products rp
on rs.product_id=rp.product_id
where cs.total_price != round((rs.quantity * rp.price) * (1 - rs.discount),4);
