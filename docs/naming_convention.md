# Naming Convention
This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the data warehouse.

## Table of contents
* [General Principal](#general-principal)
* [Table Naming Convention](#table-naming-convention)
* [Column Naming Convention](#column-naming-convention)
* [Stored Procedure](#stored-procedure)

## General Principal

- Naming convention: Use snack_case, with lowercase letters with underscore(_) to sparate word
- Language: Use English for all names
- Avoid Reserved Words: Do not use SQL reserved words as object names

## Table Naming Conventions

Bronze Rules

- All names must start with “raw”, and table names must match their original names without renaming
- raw_<entity>
    - <entity>: Exact table name from the source system
    - example: raw_products → products information from the source system

Silver Rules

- All names must start with “clean”, and table names must match their original names without renaming
- clean_<entity>
    - <entity>: Exact table name from the source system
    - example: clean_customers → customer information from the source system

Gold Rules

- All names must use meaningful, business- alligned names for tables, starting  with the category prefix
- <category>_<entity>
    - <category>: describe the role of the table, such  as dim (dimension) or fact (fact table)
    - <entity>: descriptive name of the table, alligned with the business domain
- examples:
    - dim_customers → dimension table for customers
    - fact_sales→ fact table containing sales transactions

    Glossary of Category Patterns
    | Pattern | Meaning | Example |
    | --- | --- | --- |
    | dim_ | dimension table | dim_customers |
    | fact_ | fact table | fact_sales |
    | report_ | report table | report_sales_monthly |

## Column Naming Convention

Surrogate Key

- All primary keys in dimension tables must use the suffix key
- <table_name>_key
    - <table_name>: refers to the name of the table or entity the key belong to
    - _key: a suffix indicating that  this column is a surrogate key
- example: products_key → surrogate key in the dim_products tableT

Technical Column

- All technical  column must be start with the prefix dwh_, followed a descriptive name indicating the column’s purpose
- dwh_column_name
- example: dwh_load_date →system generated column used to store the date when the record was loaded

## Stored Procedure

- All stored procedures used for loading data must follow the naming pattern:
- load_<layer>
    - <layer>: Represents the layer being loaded, such as bronze, silver, or gold.
    - Example:
        - load_bronze → Stored procedure for loading data into the Bronze layer.
        - load_silver → Stored procedure for loading data into the Silver layer.
