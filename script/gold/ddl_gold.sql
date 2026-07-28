 /*
========================================
DDL SCRIPT: CREATE GOLD VIEWS
========================================
Script Purpose:
	This script creates views for the gold layer in the datawarehouse.
	The gold layer represents the final dimensions and fact tables (star schema)
	  	
	each view performs transformation and combines data from the silver layer
	to produce a clean, enriched, and business-ready dataset
  	
Usage:
	These views can be queried directly for analytics and reporting
 */
 
 /*--------------------------------
Create Dimension: gold.dim_products
--------------------------------*/
 create or replace view gold.dim_products as
 select
	pr.product_id,
	pr.product_name,
	pr.price,
	pr.category_id,
	ca.category_name,
	pr.class,
	pr.resistant,
	pr.is_alergant,
	pr.vitality_days,
	pr.modify_date
from silver.clean_products as pr
left join silver.clean_categories as ca
on pr.category_id=ca.category_id;


 /*--------------------------------
Create Dimension: gold.dim_customers
--------------------------------*/
create or replace view gold.dim_customers as
select
	cu.customer_id,
	cu.full_name as customer_name,
	ci.country_id,
	co.country_name,
	co.country_code,
	cu.city_id,
	ci.city_name,
	cu.addres
from silver.clean_customers as cu
left join silver.clean_cities as ci
on cu.city_id=ci.city_id 
left join silver.clean_countries as co
on ci.country_id=co.country_id;


 /*--------------------------------
Create Dimension: gold.dim_employees
--------------------------------*/
create or replace view gold.dim_employees as
select
	em.employee_id,
	em.full_name as employee_name,
	em.gender,
	em.birth_date,
	ci.country_id,
	co.country_name,
	co.country_code,
	em.city_id,
	ci.city_name,
	em.hire_date
from silver.clean_employees as em
left join silver.clean_cities as ci
on em.city_id=ci.city_id
left join silver.clean_countries as co
on ci.country_id=co.country_id;


 /*--------------------------------
Create fact: gold.fact_sales
--------------------------------*/
create or replace view gold.fact_sales as
select 
	sa.sales_id,
	sa.transaction_number,
	sa.sales_date,
	sa.customer_id,
	sa.sales_person_id as employee_id,
	sa.product_id,
	sa.quantity,
	sa.discount,
	total_price
from silver.clean_sales as sa;
