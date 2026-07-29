### gold.dim_products

- Purpose: Contains product details enriched with category information.
- column:

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
