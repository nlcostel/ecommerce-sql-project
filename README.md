<p align="center">
  <img src="https://img.shields.io/badge/Ecommerce%20SQL%20Project-Data%20Analytics%20Portfolio-blueviolet?style=for-the-badge" alt="Project Banner"/>
</p>

<h1 align="center">🛒 Ecommerce SQL Analytics Project</h1>

<p align="center">
  A complete end-to-end SQL project including database schema design, CSV ingestion, analytical queries, predictive modeling, and reporting.
</p>


<p align="center">

  <!-- Tech Stack -->
  <img src="https://img.shields.io/badge/SQL-MySQL-blue?style=flat-square" />
  <img src="https://img.shields.io/badge/Language-SQL-orange?style=flat-square" />
  <img src="https://img.shields.io/badge/Platform-Codio-lightgrey?style=flat-square" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" />


  <!-- Project Status -->
  <img src="https://img.shields.io/badge/Status-Complete-brightgreen?style=flat-square" />

  <!-- License -->
  <img src="https://img.shields.io/badge/License-MIT-purple?style=flat-square" />

</p>

# E-Commerce Customer Insights & Predictive Modeling (SQL Project)
## A complete SQL analytics project featuring data modeling, business insights, and predictive analysis.

# Project Overview

Using SQL (MySQL 5.5), the project demonstrates:

    Data modeling & relational database design

    Exploratory analysis & business performance metrics

    Customer behavioral analytics

    Feature engineering

    Predictive scoring using SQL

    Revenue forecasting using linear regression

# Business Scenario

## An e-commerce retailer wants to:

    Understand customer purchasing behavior

    Identify customers at risk of churning

    Predict future revenue

    Rank customers based on their likelihood to purchase again

## You were asked as the Data Analyst to:

    Build a clean relational schema

    Ingest raw CSV data

    Produce insights using SQL

    Develop predictive SQL models

# Dataset Description

The dataset consists of 10 customers, 10 products, 10 orders, 10 order items, and 2 returns. Although small, it represents a realistic relational structure used in commerce.

Tables included:

## Customers Table

<img width="667" height="430" alt="image" src="https://github.com/user-attachments/assets/d7729e15-d99d-4878-9143-b8aa0b8f5819" />

## Products Table

<img width="667" height="381" alt="image" src="https://github.com/user-attachments/assets/d8e50c32-cbd7-4bf4-936b-0bb929ebf696" />

## Order_Items Table

<img width="680" height="401" alt="image" src="https://github.com/user-attachments/assets/65cd4ece-5cf6-48e0-bc26-35617dd1eb35" />

## Orders Table

<img width="730" height="388" alt="image" src="https://github.com/user-attachments/assets/2fd43b3c-490f-4339-b8de-2ef029b34376" />

## Returns Table

<img width="744" height="269" alt="image" src="https://github.com/user-attachments/assets/b766ba79-b9ee-423c-8f98-6ca3623f67c3" />


# Tech Stack

    MySQL 5.5

    SQL feature engineering

    Temporary tables

    Subqueries

    Regression math (slope/intercept)

    Codio development environment

# Database Schema

## ERD

```mermaid
erDiagram

    CUSTOMERS {
        int customer_id PK
        string first_name
        string last_name
        string email
        string city
        string state
        date signup_date
    }

    PRODUCTS {
        int product_id PK
        string product_name
        string category
        decimal price
    }

    ORDERS {
        int order_id PK
        int customer_id FK
        date order_date
        string order_status
    }

    ORDER_ITEMS {
        int order_item_id PK
        int order_id FK
        int product_id FK
        int quantity
        decimal item_total
    }

    RETURNS {
        int return_id PK
        int order_id FK
        date return_date
        string return_reason
    }

    CUSTOMERS ||--o{ ORDERS : places
    ORDERS ||--o{ ORDER_ITEMS : contains
    PRODUCTS ||--o{ ORDER_ITEMS : includes
    ORDERS ||--o| RETURNS : "may have"
```

# Analysis & Predictive Models

## This project includes three major analytic components, all written in SQL and fully compatible with MySQL 5.5.

  1.0 Purchase Likelihood Scoring

    With 4 features:

      purchase_count

      total_spent

      days_since_purchase

      A weighted likelihood_score

  1.1 Formula:

    likelihood_score = purchase_count * 0.4 + total_spent * 0.005- days_since_purchase * 0.02

  1.2 Purpose:

    Prioritize customers for email, SMS, and retargeting campaigns.

  1.3 Example Output:

<img width="555" height="225" alt="image" src="https://github.com/user-attachments/assets/c966d185-d354-4ffe-b29c-2256a421221d" />

  2.0 Churn Risk Model

  Customers are categorized into:

    High Risk

    Medium Risk

    Low Risk

  Based on:

    Days since last purchase

    Total revenue

    Order history

  2.1 CASE  
  
    WHEN days_since_last_purchase > 90 THEN 'High Risk'
  
    WHEN days_since_last_purchase BETWEEN 31 AND 90 THEN 'Medium Risk'
  
    ELSE 'Low Risk'
  
    END

  2.2 Example Output:

<img width="547" height="153" alt="image" src="https://github.com/user-attachments/assets/521e19f6-11b2-4e2f-9b93-1f253396783c" />

  3.0 Revenue Forecasting Using SQL Regression

    A full linear regression model was built using:

      Temporary tables

      Summation statistics

      Slope/intercept calculations

      Time indexing (t)

    Outputs include:

      Past revenue

      Predicted future revenue trend

  3.1 Example Output

<img width="293" height="167" alt="image" src="https://github.com/user-attachments/assets/7af580d8-7846-4bf2-ac8d-bafcbe414f06" />

# How to Run This Project (Step-by-Step)

1. Clone the repository
   
      git clone https://github.com/yourusername/ecommerce_sql_project.git

      cd ecommerce_sql_project

2. Open MySQL
   
      mysql --local-infile=1 -u root

3. Create the database & schema
   
      SOURCE schema.sql;

4. Load the CSV data
   
      LOAD DATA LOCAL INFILE 'customers.csv' INTO TABLE customers ...;

      (Full commands included in project.)

5. Run all analysis & predictive models
   
      SOURCE analysis_queries.sql;

# Skills Demonstrated
## SQL Skills

    JOINs, GROUP BY, ORDER BY

    Subqueries

    Temporary tables

    Aggregate math

    Feature engineering

    Regression modeling

    Churn prediction logic

    Analytics Skills

    Cohort-style behavior analysis

    Lifecycle modeling

    Customer segmentation

    Revenue forecasting

    Data storytelling

    Business Skills

    Understanding of customer lifecycle

    Retention analysis

    Revenue intelligence

    KPI-driven analytics


# 📄 License

This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute this project, provided proper credit is given.


