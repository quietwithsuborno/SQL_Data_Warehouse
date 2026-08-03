# 🔍 Exploratory Data Analysis (EDA)

Before proceeding to advanced visualization, I performed a deep dive into the Gold layer to validate data integrity, understand the business footprint, and audit the quality of the dataset.

---

### 1. Business Footprint & Sales Performance
A comprehensive audit of the dataset reveals a healthy 4-year operational span:
* **Time Coverage:** From **2010-12-29** to **2014-01-28**.
* **Revenue:** A total of **29,356,250** in sales generated from **60,423 units sold**.
* **Order Structure:** I identified **27,659 unique orders** spanning **60,398 order lines** (transaction-level entries).
    * This indicates that a typical order contains multiple items (**~2.18 items per order**), and a small number of line items involve quantities greater than 1 (60,423 total units vs. 60,398 order lines).

---

### 2. Efficiency & Value Metrics (Derived Insights)
* **Average Order Value (AOV):** **1,061.36** (Calculated from Sales / Unique Orders).
* **Revenue per Item:** **485.85** (This perfectly aligns with the reported **Average Price of 486**, confirming cross-table consistency).
* **Customer Value:** Every customer in this dataset has made at least one purchase (no dormant/zero-activity records), contributing an average of **1,588.20** in revenue over the period.

---

### 3. Product Catalog Composition (Assortment)
The product catalog consists of **295 unique SKUs**, showing a heavy focus on high-ticket and technical items:
* **Core Focus:** **Components (44.1%)** and **Bikes (33.7%)** make up **~78%** of the inventory.
* **Supplementary:** Clothing (12.2%) and Accessories (10.1%) complete the assortment.

---

### 4. Customer Demographics & Data Quality Observations 🚩
* **Gender Balance:** The base is nearly perfectly balanced with **50.6% Male** and **49.4% Female** customers.
* **Age Distribution Red Flag:** The customer base shows no one younger than **40**, and the oldest birthdate recorded results in an age of **110** — both ends of this range are unusual for a typical retail customer base.
* **Data Quality Note:** The absence of younger customers combined with the implausible age of 110 suggests potential **data-quality artifacts** in the birthdate field (e.g., placeholder/default values or a non-representative sample), requiring careful handling during targeted segmentation.
