-- Step 1: Create the Database
CREATE DATABASE churn_db;

-- Step 2: Create the Main Table
CREATE TABLE telecom_customer_churn (
    customer_id VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    age INT,
    married VARCHAR(5),
    number_of_dependents INT,
    city VARCHAR(100),
    zip_code INT,
    latitude FLOAT,
    longitude FLOAT,
    number_of_referrals INT,
    tenure_in_months INT,
    offer VARCHAR(25),
    phone_service VARCHAR(10),
    avg_monthly_long_distance_charges FLOAT,
    multiple_lines VARCHAR(10),
    internet_service VARCHAR(10),
    internet_type VARCHAR(50),
    avg_monthly_gb_download FLOAT,
    online_security VARCHAR(10),
    online_backup VARCHAR(10),
    device_protection_plan VARCHAR(10),
    premium_tech_support VARCHAR(10),
    streaming_tv VARCHAR(10),
    streaming_movies VARCHAR(10),
    streaming_music VARCHAR(10),
    unlimited_data VARCHAR(10),
    contract VARCHAR(50),
    paperless_billing VARCHAR(50),
    payment_method VARCHAR(50),
    monthly_charge FLOAT,
    total_charges FLOAT,
    total_refunds FLOAT,
    total_extra_data_charges INT,
    total_long_distance_charges FLOAT,
    total_revenue FLOAT,
    customer_status VARCHAR(50),
    churn_category VARCHAR(50),
    churn_reason VARCHAR(255)
);

-- Step 3: Import Data
COPY telecom_customer_churn
FROM 'C:\Users\pd006\Desktop\internship_search\machine_learning\Telecom-Customer-Churn-Prediction\data\telecom_customer_churn.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '');


-- Step 4: Handle Missing Values
-- Replace NULL values with default or computed values
UPDATE telecom_customer_churn SET gender = 'Unknown' WHERE gender IS NULL;
UPDATE telecom_customer_churn SET age = (SELECT AVG(age) FROM telecom_customer_churn WHERE age IS NOT NULL) WHERE age IS NULL;
UPDATE telecom_customer_churn SET married = 'No' WHERE married IS NULL;
UPDATE telecom_customer_churn SET city = 'Unknown' WHERE city IS NULL;
UPDATE telecom_customer_churn SET monthly_charge = 0 WHERE monthly_charge IS NULL;
UPDATE telecom_customer_churn SET churn_category = 'Others' WHERE churn_category IS NULL;
UPDATE telecom_customer_churn SET avg_monthly_long_distance_charges = 0 WHERE avg_monthly_long_distance_charges IS NULL;
UPDATE telecom_customer_churn SET multiple_lines = 'No' WHERE multiple_lines IS NULL;
UPDATE telecom_customer_churn SET internet_type = 'None' WHERE internet_type IS NULL;
UPDATE telecom_customer_churn SET avg_monthly_gb_download = 0 WHERE avg_monthly_gb_download IS NULL;
UPDATE telecom_customer_churn SET online_security = 'No' WHERE online_security IS NULL;
UPDATE telecom_customer_churn SET online_backup = 'No' WHERE online_backup IS NULL;
UPDATE telecom_customer_churn SET device_protection_plan = 'No' WHERE device_protection_plan IS NULL;
UPDATE telecom_customer_churn SET premium_tech_support = 'No' WHERE premium_tech_support IS NULL;
UPDATE telecom_customer_churn SET streaming_tv = 'No' WHERE streaming_tv IS NULL;
UPDATE telecom_customer_churn SET streaming_movies = 'No' WHERE streaming_movies IS NULL;
UPDATE telecom_customer_churn SET streaming_music = 'No' WHERE streaming_music IS NULL;
UPDATE telecom_customer_churn SET unlimited_data = 'No' WHERE unlimited_data IS NULL;
UPDATE telecom_customer_churn SET churn_reason = 'Others' WHERE churn_reason IS NULL;

-- Step 5: Check for missing values
SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN Number_of_Dependents IS NULL THEN 1 ELSE 0 END) AS Number_of_Dependents_Null_Count,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_Null_Count,
    SUM(CASE WHEN Zip_Code IS NULL THEN 1 ELSE 0 END) AS Zip_Code_Null_Count,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS Latitude_Null_Count,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS Longitude_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Offer IS NULL THEN 1 ELSE 0 END) AS Offer_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Avg_Monthly_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Avg_Monthly_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Avg_Monthly_GB_Download IS NULL THEN 1 ELSE 0 END) AS Avg_Monthly_GB_Download_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Tech_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Tech_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM telecom_customer_churn;


-- Step 6: Create Modular Tables for ETL

-- Demographics Table
CREATE TABLE customer_demographics AS
SELECT customer_id, gender, age, married, number_of_dependents
FROM telecom_customer_churn;

-- Service Table---
CREATE TABLE customer_services AS
SELECT customer_id, phone_service, internet_service, contract, payment_method,
       monthly_charge, total_charges, total_extra_data_charges, total_long_distance_charges
FROM telecom_customer_churn;

-- Churn Table
CREATE TABLE customer_churn AS
SELECT customer_id, churn_category, churn_reason
FROM telecom_customer_churn;

-- Usage Table
CREATE TABLE customer_usage AS
SELECT customer_id, avg_monthly_gb_download, avg_monthly_long_distance_charges, 
       streaming_tv, streaming_movies, streaming_music
FROM telecom_customer_churn;


DROP TABLE telecom_customer_churn;
DROP TABLE customer_geography
DROP TABLE customer_demographics;
DROP TABLE customer_services;
DROP TABLE customer_churn;
DROP TABLE customer_usage;

SELECT * FROM telecom_customer_churn;

-- Geographic Table
CREATE TABLE customer_geography AS
SELECT customer_id, city, zip_code, latitude, longitude
FROM telecom_customer_churn;


-- Step 7: Perform Analytical Queries

-- Demographics Distribution
SELECT gender, COUNT(*) AS customer_count
FROM telecom_customer_churn
GROUP BY gender;

-- Churn Rate Analysis
SELECT churn_category, COUNT(*) AS churn_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telecom_customer_churn), 2) AS churn_rate
FROM telecom_customer_churn
GROUP BY churn_category;

-- Service Type vs Churn
SELECT contract, churn_category, COUNT(*) AS churn_count
FROM telecom_customer_churn
GROUP BY contract, churn_category
ORDER BY churn_count DESC;

-- Charges and Churn Correlation
SELECT churn_category, AVG(monthly_charge) AS avg_monthly_charge,
       AVG(total_charges) AS avg_total_charges
FROM telecom_customer_churn
GROUP BY churn_category;

/*
-- Step 8: Indexing for Performance
CREATE INDEX idx_customer_id ON telecom_customer_churn(customer_id);
CREATE INDEX idx_churn_category ON telecom_customer_churn(churn_category);
*/

-- Step 9: Create virtual tables for further analysis
CREATE VIEW vw_ChurnData AS
SELECT * FROM telecom_customer_churn WHERE Customer_Status IN ('Churned', 'Stayed');

CREATE VIEW vw_JoinData AS
SELECT * FROM telecom_customer_churn WHERE Customer_Status = 'Joined';

-- SELECT * FROM vw_JoinData;


CREATE TABLE modified_customer_churn AS TABLE telecom_customer_churn;

