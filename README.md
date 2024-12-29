# Telecom Customer Churn Analysis

## Tools Used
- SQL
- Power BI
- Python

## Table of Contents
1. [Project Objective](#project-objective)
2. [ETL Framework](#etl-framework)
3. [Dashboard Development](#dashboard-development)
   - [Demographic Analysis](#demographic-analysis)
   - [Payment and Account Information](#payment-and-account-information)
   - [Services Analysis](#services-analysis)

## Project Objective
Design a complete ETL process within a database and develop a Power BI dashboard to leverage customer data and accomplish the following objectives:

1. **Analyze Customer Data across:**
   - Demographics
   - Payment and Account Information
   - Services

2. **Analyze customer churn profiles** to identify strategic opportunities for targeted marketing campaigns.

## ETL Framework
Our framework incorporates the following components:
1. **CSV File**: Source data.
2. **Azure Data Studio**: Database management and SQL queries.
3. **PostgreSQL**: Database system for data transformation and storage.

---

## Dashboard Development

### **Colors**
- **Male**: `#1396C5`
- **Female**: `#e669b9`
- **General**: `#717bc5`
- **Highlighting on Numbers**: `#BABFE7`

### **Branding**
- **Logo**: DahalCraft - "Chasing Brilliance"

### Steps:

1. **Create a New Column**: `churn_status`
   ```DAX
   if [customer_status] = "Churned" then 1
   else 0
   ```
   Change the data type to "Whole Number."

2. **Range Binning for Monthly Charges**
   Create a new column `monthly_charge_status`:
   ```DAX
   if [monthly_charge] < 60 then "<60"
   else if [monthly_charge] < 80 then "60-80"
   else if [monthly_charge] < 100 then "80-100"
   else ">=100"
   ```

3. **Create a New Table for Measures**: `tbl_Measures`
   - Total Customers:
     ```DAX
     Total Customers = COUNT(modified_customer_churn[customer_id])
     ```
   - New Members:
     ```DAX
     New Members = CALCULATE(COUNT(modified_customer_churn[customer_id]), modified_customer_churn[customer_status] = "Joined")
     ```
   - Total Churn:
     ```DAX
     Total Churn = SUM(modified_customer_churn[churn_status])
     ```
   - Churn Rate:
     ```DAX
     Churn Rate = [Total Churn] / [Total Customers]
     ```

4. **Cards**:
   - Display metrics: Total Customers, New Members, Total Churn, Churn Rate (%)

5. **Donut Chart**:
   - Values: Total Churn
   - Legend: Gender

---

### Demographic Analysis

1. **Age Grouping**:
   Create a reference table `mapping_Age_Group` with age bins:
   ```DAX
   if [age] < 21 then "<21"
   else if [age] < 35 then "21-35"
   else if [age] < 50 then "35-50"
   else ">=50"
   ```

2. **Visualization**:
   - Line and Stacked Column Chart:
     - X-axis: `Age Group`
     - Y-axis: `Churn Rate`

3. **Sorting**:
   - Add `Age_Sort_Idx` column for sorting:
     ```Power Query
     if [Age Group] = "<21" then 1
     else if [Age Group] = "21-35" then 2
     else if [Age Group] = "35-50" then 3
     else 4
     ```

---

### Payment and Account Information

1. **Payment Method**:
   - Create a Clustered Bar Chart:
     - X-axis: `Payment Method`
     - Y-axis: `Churn Rate`

2. **Tenure Grouping**:
   Create a reference table `mapping_Tenure_Group` with bins:
   ```DAX
   if [tenure_in_months] < 6 then "< 6 months"
   else if [tenure_in_months] < 12 then "6-12 months"
   else if [tenure_in_months] < 18 then "12-18 months"
   else if [tenure_in_months] < 24 then "18-24 months"
   else ">=24 months"
   ```

3. **Visualization**:
   - Line and Stacked Column Chart:
     - X-axis: `Tenure Group`
     - Y-axis: `Churn Rate`

4. **Sorting**:
   - Add `Tenure_Sort_Idx` column for sorting:
     ```Power Query
     if [Tenure Group] = "< 6 months" then 1
     else if [Tenure Group] = "6-12 months" then 2
     else if [Tenure Group] = "12-18 months" then 3
     else if [Tenure Group] = "18-24 months" then 4
     else 5
     ```

---

### Services Analysis

1. **Services Columns**:
   - Unpivot services columns (e.g., `phone_service`, `multiple_lines`, etc.).
   - Rename columns to `Service` and `Status`.

2. **Matrix Visualization**:
   - Rows: `Service`
   - Columns: `Status`
   - Values: `Churn Status` (formatted as percentages)

3. **Pie Chart**:
   - Group `total_revenue` by `contract` type.

4. **Dropdown Filters**:
   - Add slicers for `monthly_charge_status` and `married` columns.

5. **Toolkit**:
   - Visualize `Total Churn` by `churn_category` and `churn_reason`.

---

## Final Deliverable
The dashboard provides actionable insights to:
- Identify key demographic and service patterns related to churn.
- Enable data-driven strategies for customer retention and marketing campaigns.
