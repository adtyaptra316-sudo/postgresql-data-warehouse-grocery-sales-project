# Data Catalog for Gold Layer
## Overview
The Gold Layer represents the business-level data, designed for analytics and reporting. It consists of dimension and fact tables tailored for specific business metrics.

### gold.dim_products
- Purpose: Contains product details enriched with category information.
- columns:

| Column Name | Data Type | Description |
| --- | --- | --- |
| product_id | INT | Unique identifier for each product. |
| product_name | VARCHAR(100) | Name of the product |
| price | NUMERIC(12,4) | Price per unit of the product. |
| category_id | INT | Unique identifier representing the product category |
| category_name | VARCHAR(100) | Name of the product category |
| class | VARCHAR(15) | Classification of the product (e.g., ‘Low’, ‘Medium’, ‘High’) |
| resistant | VARCHAR(15) | Product durability indicator (e.g., ‘Weak’, ‘Durable’, ‘Unknown’) |
| is_alergant | VARCHAR(15) | indicates whether the item is an allergen (e.g., ‘True’, ‘False’, ‘Unknown’) |
| vitality_days | INT | Expected shelf life or freshness duration of the product in days from production/receipt date |
| modify_date | TIMESTAMP | Last modified date (YYYY-MM-DD HH:MI:SS.US) |

### gold.dim_customers
- Purpose: Contains customer details enriched with geographic data.
- columns:

| Column Name | Data Type | Descriptions |
| --- | --- | --- |
| customer_id | INT | Unique identifier for each customer |
| customer_name | VARCHAR(104) | Name of the customer |
| country_id | INT | Unique identifier representing the country of the customer |
| country_name | VARCHAR(50) | Name of the country |
| country_code | VARCHAR(2) | Two-letter country code |
| city_id | INT | Unique identifier representing the city of the customer |
| city_name | VARCHAR(50) | Name of the city |
| addres | VARCHAR(255) | Customer's street address. |

### gold.dim_employees
- Purpose: Contains employee details enriched with geogrphic data.
- Columns:

| Column Name | Data Type | Descriptions |
| --- | --- | --- |
| employee_id | INT | Unique identifier for each employee |
| employee_name | VARCHAR(104) | Name of the employee |
| gender | VARCHAR(10) | Gender of the employee (e.g., ‘Female’, ‘Male’) |
| birth_date | TIMESTAMP | Date of birth of the employee (YYYY:MM:DD HH:MI:SS.US) |
| country_id | INT | Unique identifier for the country where the employee lives. |
| country_name | VARCHAR(50) | Name of the country |
| country_code | VARCHAR(2) | Two-letter country code |
| city_id | INT | Unique identifier for the city where the employee lives. |
| city_name | VARCHAR(50) | Name of the city |
| hire_date | TIMESTAMP | Date when the employee was hired (YYYY-MM-DD HH:MI:SS.US) |

### gold.fact_sales

- Purpose: Contains detailed sales information.
- columns:
| Column Name | Data Type | Description |
| --- | --- | --- |
| sales_id | INT | Unique identifier for each sale. |
| transaction_number | VARCHAR(255) | Unique identifier for the transaction |
| sales_date | TIMESTAMP | Date and time of the sale (YYYY-MM-DD HH:MI:SS.US) |
| customer_id | INT | Customer making the purchase. |
| employee_id | INT | Employee responsible  for the sale |
| product_id | INT | Product being sold |
| quantity | INT | Number of units sold |
| discount | NUMERIC(10,2) | Discount applied to the sale |
| total_price | NUMERIC(12,4) | Final sale price after discounts. |
