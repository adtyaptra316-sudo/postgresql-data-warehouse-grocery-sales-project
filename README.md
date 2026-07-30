# Data Warehouse and Analytics Project
Welcome to the Data Warehouse and Analytics Project repository! 🚀
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

## 🏗️ Data Architecture
The data architecture for this project follows **Medallion Architecture** **Bronze**, **Silver**, and **Gold** Layer
<img width="1044" height="757" alt="data architecture" src="https://github.com/user-attachments/assets/4becc5e0-9af9-4fdb-a3de-8efbb8246f5f" />
1. **Bronze** Layer: Stores raw data as-is from source systems. Stores raw data as-is from the source systems. Data is ingested from CSV Files into PostgreSQL Database.
2. **Silver** Layer: This layer includes data cleansing, standardization, and normalization proccess to prepare data for analytics
3. **Gold** Layer: Houses business-ready data modeled into a star schema required for reporting and analytics.

## 🔍 Project Overview
- **Nama Proyek:** 4-Month Retail Sales Performance & Behavioral Engine (PostgreSQL)
- **Dataset:** Grocery Sales Dataset (4-Month Snapshot Dataset from Kaggle)
- **Data Architecture:** Design a moder datawarehouse using Medallion Architecture Bronze, Silver, and Gold Layer
- **Project Purpose:** Building a centralized data platform (Single Source of Truth) using PostgreSQL to evaluate 4-month sales performance, salesperson effectiveness, customer purchasing behavior, and city-level geographic distribution.

## 📝 Project Requirement
### Building the Data Warehouse (Data Engineering)
#### Objective
Develop a modern data warehouse using PostgreSQL to analytical reporting and informed decision-making.

#### Specifications
Data Sources: Import data provided as CSV files.
Data Quality: Cleanse and resolve data quality issues prior to analysis.
Integration: Combine multiple tables into a single, user-friendly data model designed for analytical queries.
Documentation: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

### BI: Analytics & Reporting (Data Analysis)
#### Objective
Develop SQL-based analytics to deliver detailed insights into:

- Monthly Sales Performance
- Top Product Identification
- Customer Purchase Behavior
- Salesperson Effectiveness
- Geographical Sales Insight (City-Level Only)

These insights empower stakeholders with key business metrics, enabling strategic decision-making.
