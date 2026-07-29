/*
===============================================================================
Quality Checks
===============================================================================Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
*/

-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Check for uniqueness of products Key in gold.dim_products
-- Expectation: No results

select product_id, count(*) from gold.dim_products
group by product_id having count(*) >1;


-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Check for uniqueness of customer key in gold.dim_customers
-- Expectation: No results

select customer_id, count(*) from gold.dim_customers
group by customer_id having count(*) >1;


-- ====================================================================
-- Checking 'gold.dim_employees'
-- ====================================================================
-- Check for uniqueness of employees key in gold.dim_customers
-- Expectation: No results

select employee_id, count(*) from gold.dim_employees
group by employee_id having count(*) >1;


-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions

select * 
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_id = f.customer_id
left join gold.dim_products p
on p.product_id = f.product_id
where p.product_id is null or c.customer_id is null ;

select *
from gold.fact_sales f
left join gold.dim_employees e
on f.employee_id=e.employee_id 
where e.employee_id is null;
