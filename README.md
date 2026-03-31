# 📊 Data Warehouse Project – Gold Layer Implementation

## 🧾 Overview

This project focuses on building the **Gold Layer** of a data warehouse using PostgreSQL.
The Gold Layer represents the **business-ready, analytics-friendly data model** derived from the Silver Layer.

It is designed to support reporting, dashboards, and business intelligence tools by providing **clean, consistent, and enriched data**.

---

## 🏗️ Architecture

The project follows a **multi-layered data architecture**:

* **Bronze Layer** → Raw data (ingested from source systems)
* **Silver Layer** → Cleaned and standardized data
* **Gold Layer** → Business-level, transformed data (this project)

---

## 🎯 Objective

The goal of this implementation is to:

* Transform cleaned data into **analytics-ready datasets**
* Create **dimension views** for easy querying
* Integrate multiple data sources (CRM & ERP)
* Apply business logic and data standardization

---

## 📦 Gold Layer Components

### 1. 🧑‍💼 `dim_customers`

A dimension view that provides a unified and enriched view of customer data.

#### 🔍 Features:

* Surrogate key generation using `ROW_NUMBER()`
* Combines data from:

  * CRM system (`crm_cust_info`)
  * ERP system (`erp_cust_az12`)
  * Location data (`erp_loc_a101`)
* Handles missing values using fallback logic
* Standardized column naming

#### 🧠 Business Logic:

* CRM is treated as the **primary source for gender**
* ERP data is used as a **fallback when CRM data is unavailable**
* Ensures all customers are retained using **LEFT JOINs**

---

## 🛠️ Technologies Used

* **PostgreSQL**
* SQL (Window Functions, Joins, Views)
* Data Warehousing Concepts

---

## 🔗 Example Query

```sql
SELECT *
FROM gold.dim_customers;
```

---

## ⚙️ Key Concepts Applied

* **Views** for abstraction and reusability
* **LEFT JOIN** to preserve complete customer data
* **Window Functions** (`ROW_NUMBER`) for surrogate keys
* **Data Integration** across multiple systems
* **Data Standardization & Cleaning**

---

## ⚠️ Notes

* The surrogate key generated using `ROW_NUMBER()` is **dynamic** and may change if the underlying data changes.
* For production-grade systems, consider using **persisted surrogate keys**.

---

## 🚀 Future Enhancements

* Convert views into **materialized views** for performance optimization
* Add **fact tables** for analytical queries
* Implement **indexes** for faster joins
* Introduce **data quality checks**

---

## 📌 Conclusion

The Gold Layer provides a **trusted, business-ready dataset** that simplifies analytics and ensures consistency across reporting systems.

---

## 👤 Author

Your Name
