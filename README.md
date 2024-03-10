# Metro Property Valuation & Data Normalization Pipeline

## 📌 Executive Summary
This project tackles the critical business need for accurate property valuation in the metropolitan real estate market. The original dataset of 56,000+ property transactions was riddled with missing fields, inconsistent address formatting, and duplicate records. A robust data engineering pipeline was built in SQL Server to normalize the data, ensuring high fidelity for downstream valuation models and reporting.

## 🛠 Tech Stack & Architecture
- **Data Warehouse / Transformation:** SQL Server (CTEs, Window Functions, Self-Joins)
- **Methodology:** Data Cleansing, Normalization, Anomaly Detection

## 📊 Key Business Findings
- **Data Integrity Improvement:** Standardized over 40% of records that previously contained unstructured address strings, enabling accurate geospatial mapping.
- **Duplicate Reduction:** Identified and purged 104 exact duplicate transaction entries, preventing artificial inflation of aggregate sales metrics.
- **Valuation Anomaly:** 15% of the entries were missing the property city. Implemented a self-join technique using parcel IDs to back-fill missing cities with 99.8% accuracy.

## 💡 Strategic Recommendations
1. Implement upstream validation rules on the CRM input layer to prevent null address fields at the source.
2. Schedule the SQL normalization pipeline to run daily via stored procedures rather than ad-hoc batches to ensure near real-time data readiness.

## 📁 Repository Structure
- `/sql/`: SQL migration and transformation scripts
