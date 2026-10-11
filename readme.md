# <p align=center> Olist E-commerce (Public Dataset) : Business Analysis

## 🧭 Executive Summary:
Welcome to the analytics repository for the Olist Brazilian E-commerce dataset.  logistics, customer lifetime value, financial risk, merchant operations, and regional economics.
Simulated a professional corporate workflow by collaborating with an AI personna - Executive Stakeholder (who defined business scope, metrics, and requirements) and a Technical Reviewer (who audited code architecture, edge cases, and performance). This setup ensured every query answered a genuine business question rather than just demonstrating syntax.

Across 9 modular analytical tasks, this project uncovers the exact operational friction points and revenue drivers, logistics bottlenecks, customer spending behavior, payment risks, and how delivery delays impact customer satisfaction.

## <p align=center> 📌 Table of Contents
* [***🎯 Project Overview & Objectives***](#-project-overview--objectives)

* [***🛠️ Technical Skills & Tools Showcase***](#️-technical-skills--tools-showcase)

* [***🤖 Strategic AI Collaboration (Synthetic Stakeholder & Co-Pilot)***](#-strategic-ai-collaboration-synthetic-stakeholder--co-pilot)

* [***📊 Database Structure***](#-database-structure)

* [***💡 Key Business Findings & Executive Observations***](#-key-business-findings--executive-observations)

* [***🏁 Project Conclusion & Key Takeaways***](#-project-conclusion--key-takeaways)


----------------------------------------------------------------------------
## 🎯 Project Overview & Objectives

This repository presents a SQL data analysis project based on the Olist Brazilian E-commerce dataset.

- **Core Mission:** Bridge the gap between raw data engineering and executive decision-making by transforming transactional records into actionable business intelligence.

- **Operational Scope:** Cover nine distinct analytical domains ranging from product performance and regional logistics to customer segmentation, payment risk, and customer satisfaction impact.

- **Methodology:** Adopt an executive stakeholder perspective to ensure that every query answers high-impact business questions rather than merely demonstrating syntax.

### 📋 Nine Core Analytical Areas Covered:

- **🛍️ Product Performance & Revenue:** Isolate top-performing product categories by total sales volume and gross revenue contribution to guide inventory stocking.

- **📦 Logistics & Delivery Bottlenecks:** Map fulfillment performance across regional boundaries to separate carrier transit times from merchant handling times.

- **👥 Customer Value Segmentation:** Differentiate buyer behavior between one-time purchasers and repeat customers to establish baseline metrics for lifetime value (LTV).

- **💳 Payment Method & Installment Risk Analysis:** Evaluate credit card behavioral patterns, payment types, and installment frequency against basket sizes and platform risks.

- **📈 Macroeconomic Growth & MoM Trends:** Track monthly revenue trajectories and historical marketplace expansion curves for financial forecasting.

- **🏭 Seller Operational Risk Assessment:** Cross-examine merchant revenue contributions against average ratings and cancellation frequencies to protect platform trust.

- **🚚 Regional Freight Economics:** Calculate state-level freight-to-price ratios to expose shipping cost burdens on remote consumers.

- **🎯 Multi-Tier RFM Customer Segmentation:** Deploy a robust 5-5-5 model (Recency, Frequency, Monetary) to isolate VIP champions from at-risk accounts.

- **⭐ Delivery Performance vs. Customer Satisfaction:** Quantitatively link delivery delay intervals to average customer review scores to uncover the "satisfaction cliff."

🔍 SQL Queries? Check them out here [SQL_Queries_Folder](/SQL_Code/)

## 🛠️ Technical Skills & Tools Showcase

**💻 Database Management System:** PostgreSQL (executed locally via VS Code)

**⚙️ Data Engineering & Hygiene:** Custom DDL scripting, foreign key constraint manipulation, composite primary key restructuring, and \COPY batch data loading.

**⚡SQL Capabilities:**

- Complex multi-table joins (INNER JOIN, LEFT JOIN).

- Window functions.

- Common Table Expressions (CTEs) for clean, modular query architecture.

- Defensive data hygiene via explicit NULL/Zero handling (COALESCE) and conditional logic (CASE).

**📊 Visualization & Reporting:** Power BI (model data relationships, and design visual storytelling components for logistics, RFM, and revenue trends).

## 🤖 Strategic AI Collaboration (Synthetic Stakeholder & Reviewver)

To maintain enterprise-grade analytical rigor, the development lifecycle followed a structured multi-phase governance framework utilizing specialized AI collaboration roles:
|Project Phase|Functional Role|Scope & Contribution|
|-------------|---------------|--------------------|
|Strategy & Scope👔|Executive Stakeholdere|Defind core business objectives, set KPI thresholds, and outlined strategic expectations for marketplace health and customer retention.|
|Execution & Review🕵️| Technical Reviewer|Inspected the written SQL query logic and execution output screenshots against the original business scope to independently evaluate and confirm whether the analytical requirements were successfully resolved.|


## 📊 Database Structure

                    The relational database is built in PostgreSQL and consists of 8 core tables. To ensure clean ingestion of raw transactional CSV files, data hygiene protocols were implemented via custom DDL scripts, foreign key constraint management, composite primary key restructuring, and proper indexing.

- **📦 Customers ->** Unique customer identifiers and location data (city, state, zip code).

- **📋 Orders: ->** Full order lifecycle timestamps (purchase date, approval, carrier handoff, actual delivery, and estimated delivery).

- **🛒 Order_items ->** Line-item details connecting orders to specific products and merchants, including item prices and freight values.

- **🏷️ Products & Product_categories ->** Product physical dimensions, weight metrics, and English-translated category names.

- **🏭 Sellers ->** Merchant location records down to city and state levels.

- **💳 Payments ->** Payment gateway types, installment counts, and monetary transaction values.

- **⭐ Order_reviews->** Customer review scores, feedback comments, and response timestamps.

        +------------------------+             +------------------------+
        |       customers        |             |        sellers         |
        +------------------------+             +------------------------+
        | PK  customer_id        |             | PK  seller_id          |
        |     customer_unique_id |             |     seller_zip_code    |
        |     customer_zip_code  |             |     seller_city        |
        |     customer_city      |             |     seller_state       |
        |     customer_state     |             +------------------------+
        +-----------+------------+                          |
                    |                                       | (1:N)
                    | (1:N)                                 |
                    v                                       v
        +------------------------+             +------------------------+
        |         orders         |------------>|      order_items       |
        +------------------------+   (1:N)     +------------------------+
        | PK  order_id           |             | PK  order_id           |
        | FK  customer_id        |             | PK  order_item_id      |
        |     order_status       |             | FK  product_id         |
        |     purchase_timestamp |             | FK  seller_id          |
        |     approved_at        |             |     shipping_limit     |
        |     delivered_carrier  |             |     price              |
        |     delivered_customer |             |     freight_value      |
        |     estimated_delivery |             +-----------+------------+
        +-----+------+-------+---+                         |
            |      |                                    | (N:1)
            |      |                                    v
            |      |                         +------------------------+
            |      |                         |        products        |
            |      |                         +------------------------+
            |      |                         | PK  product_id         |
            |      |                         | FK  product_category   |
            |      |                         |     weight_g,          |
            |      |                         |     dimensions         |
            |      |                         +-----------+------------+
            |      |                                     |
            |      | (1:N)                               | (N:1)
            |      v                                     v
            |   +-------------------------+  +------------------------+
            |   |        payments         |  |   product_categories   |
            |   +-------------------------+  +------------------------+
            |   | FK  order_id            |  | PK  product_category   |
            |   |     payment_sequential  |  |     category_english   |
            |   |     payment_type        |  +------------------------+
            |   |     payment_installments|
            |   |     payment_value       |
            |   +-------------------------+
            |
            | (1:N)
            v
        +------------------------+
        |     order_reviews      |
        +------------------------+
        |     review_id          |
        | FK  order_id           |
        |     review_score       |
        |     comment_title      |
        |     comment_message    |
        |     creation_date      |
        |     timestamp          |
        | PK    internal_id      |
        +------------------------+       

### 🔑 Key Architectural & Design Decisions
#### **The Dual Role of order_id (Primary Key vs. Foreign Key):**

In the main orders table, order_id acts as a standard Primary Key (PK), uniquely anchoring each distinct transaction.

In secondary tables like payments and order_reviews, order_id functions as a Foreign Key (FK). Because a single order can span multiple payment installments or tie to specific feedback entries, order_id naturally repeats across rows without violating database structure.

#### **Composite Primary Keys in order_items:**

E-commerce orders frequently contain multiple line items (e.g., a customer purchasing three different products in one cart session). Because order_id repeats and individual line item counters (order_item_id) restart across different orders, neither column can uniquely identify a row on its own.

To solve this, a composite primary key combining (order_id + order_item_id) was implemented, ensuring every individual product line across the entire platform maintains absolute uniqueness.

#### **Issue-resolver code:**

**1. Fixing Missing Foreign Key Data (products & product_categories)**

****The Issue:**** The products table has a foreign key constraint linking product_category_name to the product_categories table. However, when loading the raw CSV data, some category names listed in the products file did not yet exist in the category lookup table, which caused the foreign key check to fail.

***The Solution:***

Temporarily dropped the foreign key constraint (ALTER TABLE public.products DROP CONSTRAINT ...) so the raw CSV data could be imported freely.

Used the \COPY command to ingest the olist_products_dataset.csv file.

Extracted all distinct category names from the newly loaded products and dynamically inserted any missing ones into the product_categories table while using ON CONFLICT (product_category_name) DO NOTHING to prevent duplicate errors.

Re-added the foreign key constraint (ALTER TABLE public.products ADD CONSTRAINT ...) to restore data integrity.

```sql  
ALTER TABLE public.products DROP CONSTRAINT products_product_category_name_fkey;
-- Drops the foreign key constraint temporarily

\COPY products FROM 'C:\Users\spsol\OneDrive\Documents\Power Query exercise\SQL Project 2\Datasets\olist_products_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Temporarily copies data into the products table without the foreign key constraint


INSERT INTO public.product_categories (product_category_name)
SELECT DISTINCT product_category_name 
FROM public.products 
WHERE product_category_name IS NOT NULL
  AND product_category_name NOT IN (SELECT product_category_name FROM public.product_categories)
ON CONFLICT (product_category_name) DO NOTHING;
-- Inserts distinct product category names from the products table into the product_categories table, avoiding duplicates

ALTER TABLE public.products ADD CONSTRAINT products_product_category_name_fkey 
FOREIGN KEY (product_category_name) REFERENCES public.product_categories (product_category_name);
-- Re-adds the foreign key constraint to the products table, linking it to the product_categories table
```
**2. Resolving Composite Keys for Line Items (order_items)**

****The Issue:**** The order_items table requires a composite primary key made of both order_id and order_item_id because an order can contain multiple items. However, the initial table creation or default constraint had mismatched rules or failed due to duplicate order IDs during ingestion.

***The Solution:***

Dropped the incorrect primary key constraint (ALTER TABLE public.order_items DROP CONSTRAINT order_items_pkey).

Wiped out partial data using TRUNCATE TABLE to ensure a clean slate.

Re-applied a proper composite primary key constraint spanning both columns (ADD PRIMARY KEY (order_id, order_item_id)), ensuring every line item is uniquely trackable within its parent order.

```sql 
-- Drop the incorrect primary key
ALTER TABLE public.order_items DROP CONSTRAINT order_items_pkey;

-- Add a composite primary key using BOTH order_id and order_item_id
ALTER TABLE public.order_items 
ADD PRIMARY KEY (order_id, order_item_id);

-- Wipe out any partial data from previous attempts
TRUNCATE TABLE public.order_items;
```

**3. Restructuring Order Reviews (order_reviews)**

****The Issue:**** The order_reviews table originally tried to use constraints that conflicted with incoming multi-row data structures where multiple reviews or re-entries could share similar properties, so the default primary key blocked data ingestion.

***The Solution:***

Cleared out incomplete data using TRUNCATE TABLE public.order_reviews.

Dropped the old blocking primary key constraint.

Added a brand-new, auto-incrementing serial column (internal_id SERIAL PRIMARY KEY) as a bulletproof primary key to guarantee every single review row has a unique identifier without relying on messy raw text IDs.

```sql
-- Wipe out any partial data from previous attempts
TRUNCATE TABLE public.order_reviews;

-- Drop the old primary key that was blocking duplicates
ALTER TABLE public.order_reviews DROP CONSTRAINT order_reviews_pkey;

-- Add a brand new auto-incrementing serial ID as the true primary key for every row
ALTER TABLE public.order_reviews ADD COLUMN internal_id SERIAL PRIMARY KEY;
```

## 💡 Key Business Findings & Executive Observations

### Task 1: Product Performance & Revenue
**🎯 Business Objective (Stakeholder Scope):** Isolate top-performing product categories by total sales volume and gross revenue contribution to guide inventory stocking.

**⚙️ SQL Approach:** Utilized multi-table ```INNER JOIN``` operations connecting orders, order_items, products, and product_categories, applying ```SUM(price)``` and ```COUNT(order_id)``` aggregated via ```GROUP BY``` product_category_name_english.

**💡 Finding:** Highlighted core category revenue drivers, giving marketing and warehouse teams precise data for budget allocation.

***Visualization for the queried results***

![alt text](<Result_Charts/1.Revenue & Category Performance.png>)

### Task 2: Logistics & Delivery Bottlenecks
**🎯 Business Objective (Stakeholder Scope):** Map fulfillment performance across regional lines to locate shipping friction points.

**⚙️ SQL Approach:** Applied timestamp subtraction (order_delivered_customer_date - order_purchase_timestamp) and ```AVG()``` aggregations grouped by customer_state to isolate delivery lags.Calculated delivery intervals using timestamp subtraction grouped by state.

**💡 Finding:** Separated carrier transit times from merchant handling times across specific state boundaries.

***Visualization for the queried results***

![alt text](<Result_Charts/2.Operational & Fulfilment Bottlenecks.png>)

### Task 3: Customer Value Segmentation (Lifetime Spend)
**🎯 Business Objective (Stakeholder Scope):** Differentiate buyer behavior between one-time purchasers and repeat customers to measure retention.

**⚙️ SQL Approach:** Executed user-level groupings on customer_unique_id using ```COUNT(order_id)``` and ```SUM(payment_value)``` via Common Table Expressions (CTEs).

**💡 Finding:** Quantified the retention gap, establishing a clear baseline for customer lifetime value (LTV).

***Visualization for the queried results***

  ![alt text](<Result_Charts/3.Customer Value Segmentation.png>)

### Task 4: Payment Method & Installment Risk Analysis
**🎯 Business Objective (Stakeholder Scope):** Analyze credit card behavioral patterns, payment types, and installment frequency.

**⚙️ SQL Approach:** Grouped financial records from the payments table utilizing payment_type and payment_installments, applying ```SUM(payment_value)``` and ```AVG()``` functions.

**💡 Finding:** Mapped how installment options drive higher cart values while highlighting risk profiles tied to specific payment gateways.

### Task 5: Macroeconomic Growth & MoM Trends
**🎯 Business Objective (Stakeholder Scope):** Track monthly revenue trajectories and growth velocity for financial forecasting.

**⚙️ SQL Approach:** Applied time-series truncation ```(DATE_TRUNC('month', order_purchase_timestamp))``` alongside window functions ```(LAG())``` to calculate Month-over-Month (MoM) growth velocity.

**💡 Finding:** Exposed seasonal demand surges and historical marketplace expansion curves.

***Visualization for the queried results***

  ![alt text](<Result_Charts/5.Monthly Revenue Trend & Growth Analysis.png>)

### Task 6: Seller Operational Risk Assessment
**🎯 Business Objective (Stakeholder Scope):** Cross-examine merchant revenue contribution against average ratings and cancellation frequencies.

**⚙️ SQL Approach:** Constructed multi-tier CTE architectures combined with ```COALESCE``` safety nets to handle null ratings and cross-referenced order_status = 'canceled' with seller IDs.

**💡 Finding:** Flagged high-revenue merchants carrying high cancellation rates to protect platform trust.

### Task 7: Regional Freight Economics
**🎯 Business Objective (Stakeholder Scope):** Calculate state-level freight-to-price ratios to evaluate shipping burdens on remote consumers.

**⚙️ SQL Approach:** Computed ratio metrics via division of aggregated totals ```(SUM(freight_value) / SUM(price) * 100)``` grouped by customer_state.

**💡 Finding:** Freight costs consume 24% to 28%+ of product price in remote northern/northeastern states, compared to 16%–17% in southern industrial cores.

|State | Total Revenue ($)|Total Freight Cost ($)|Avg Product Price ($)|Freight-to-Price Ratio (%)|
|------|------------------|----------------------|---------------------|--------------------------|
|RR (Roraima)|$7,829.43| $2,235.19| $150.57|28.55%|
|MA (Maranhão)|$119,648.22|$31,523.77|$145.20|26.35%|
|RO (Rondônia)|$46,140.64|$11,417.38|$165.97|24.74%|
|MG (Minas Gerais)|$1,585,308.03|$270,853.46|$120.75|17.09%|
|RJ (Rio de Janeiro)|$1,824,092.67|$305,589.31|$125.12|16.75%|

***Visualization for the queried results***

  ![alt text](<Result_Charts/7.Regional Freight Cost vs. Product Price Analysis.png>)

### Task 8: Multi-Tier RFM Customer Segmentation
**🎯 Business Objective (Stakeholder Scope):** Build a robust 5-5-5 segmentation model (Recency, Frequency, Monetary) to isolate VIP champions from at-risk accounts.

**⚙️ SQL Approach (Reviewer Audited):** Deployed multi-tier CTEs, custom ```CASE``` conditional logic for frequency scoring to bypass massive data skew (where 85%+ users are one-time buyers), and ```NTILE(5)``` window distributions.

**💡 Finding:** Stratified the user base into clean behavioral buckets (Champions, Loyal Customers, Potential Loyalists, At-Risk).

|RFM Segment|Defining Characteristics|Recommended Action / Strategy|
|-----------|------------------------|-----------------------------|
|👑 Champions|High Recency, Frequency, and Monetary score (5-5-5)|Reward loyalty with VIP perks or referral incentives.|
|🤝 Loyal Customers|Consistent buyers with strong engagement (Score: 4+)|Up-sell premium categories and cross-promotions.|
|🌱 Potential Loyalists|Recent buyers with moderate spend|Nurture with targeted retention campaigns.|
|⚠️ At-Risk / Lost|High recency, low frequency/spend|Re-engagement campaigns and feedback surveys.|

***Visualization for the queried results***

  ![alt text](<Result_Charts/8.RFM Segmentation (Recency, Frequency, Monetary).png>)

### Task 9: Delivery Performance vs. Customer Satisfaction Impact
**🎯 Business Objective (Stakeholder Scope):** Quantitatively link delivery delay intervals to average customer review scores.

**⚙️ SQL Approach:** Engineered date-parsing interval calculations using ```CASE``` statements to bucket delivery variances, joined against order_reviews to compute ```AVG(review_score)```.

**💡 Finding:** Uncovered a severe "satisfaction cliff"—while on-time deliveries maintain a healthy 4.32 rating, minor delays drop scores to 2.53, and extreme delays crash sentiment down to 1.65.

|Delivery Category|Total Orders|Average Review Rating|Business Impact Interpretation|
|-----------------|------------|---------------------|------------------------------|
|🚀 Much Earlier|62,215|4.32|Exceeding expectations builds exceptional brand trust.|
|✅ Early / On Time|28,227|4.22|Meeting fulfillment SLAs preserves high satisfaction.|
|⚠️ Late by 1-15 days|4,457|2.53|The Satisfaction Cliff: Minor delays cut ratings in half.|
|🚨 Late by approx a month|1,759|1.65|Severe operational breakdown causing heavy negative reviews.|
|❌ Late by 1+ months|347|2.05|Extreme outliers requiring immediate carrier intervention.|

***Visualization for the queried results***

  ![alt text](<Result_Charts/9.Delivery Performance & Customer Satisfaction Impact.png>)

##  🏁 Project Conclusion & Key Takeaways

***📦 1. The Delivery Trap (Logistics & Customer Sentiment)***

**The Problem:** Customer reviews tank aggressively the moment an order misses its window.

**The Insight:** There is a brutal "satisfaction cliff." On-time deliveries hover comfortably around a 4.32 rating, but even a minor delay cuts customer sentiment straight in half. Predictable fulfillment SLAs matter far more to brand loyalty than occasional lightning-fast delivery.

***🗺️ 2. The Regional Shipping Divide (Freight Economics)***

**The Problem:** Shipping costs hit remote consumers disproportionately hard.

**The Insight:** Freight-to-price ratios spike to 24%–28%+ in northern and northeastern states (like Roraima and Maranhão), compared to just 16%–17% in southern industrial hubs. Solving regional carrier bottlenecks is essential for expanding market reach outside major economic cores.

***🎯 3. Shifting from Volume to Value (Customer Segmentation)***

**The Problem:** Relying solely on gross revenue hides underlying retention issues.

**The Insight:** Deploying the RFM model proved that long-term marketplace health isn't about chasing one-time checkout volume—it's about protecting and nurturing the core cluster of repeat buyers and VIP champions who drive sustainable, recurring revenue.

***💻 4. Clean Engineering as a Foundation (Data Integrity)***

**The Problem:** Raw e-commerce CSV files are notoriously messy, full of orphaned foreign keys and duplicate rows.

**The Insight:** Building a robust database isn't just about writing queries; it requires active engineering hygiene—like resolving composite primary keys in order_items and managing dynamic category insertions to ensure analytics are built on rock-solid ground.

### 📊 Project Impact Summary
|Analytical Domain|Core Discovery|Business / Technical Action Taken|
|-----------------|--------------|----------------|
|Fulfillment|Minor delays cause a 50%+ drop in review scores.|Highlighted the need for strict carrier accountability and realistic delivery estimates.|
|Regional Freight|Remote states face up to 28% freight cost burdens.|Flagged geographic pricing friction for future supply chain optimization.|
|Customer Retention|85%+ users are one-time buyers; RFM isolates the core VIP base.|Built a 5-5-5 segmentation framework to target retention campaigns effectively.|

### 📊 Dashboard Mockup & Preview
> **Author's Note:** To accelerate README documentation and establish a clean presentation standard, a conceptual layout mockup generated by Gemini AI is utilized for this preview. The core metrics and data workflows are built directly from the PostgreSQL queries outlined in this repository.
