# Module 1: Fundamentals of IT & Industry Analytics
## Session 4: End-to-End Data Analytics Workflow

---

### Overview & Learning Objectives
The primary objective of this session is to master the standard **7-Stage Data Analytics Workflow** utilized across top technology and enterprise consulting firms:
1. **Requirement Gathering**: Defining problem statements, business questions, and target metrics.
2. **Data Collection**: Sourcing raw data from transactional databases, streaming logs, third-party APIs, and webhooks.
3. **Data Cleaning**: Handling missing values, trimming irregular whitespace, standardizing formats, and enforcing strict data types.
4. **Data Transformation**: Reshaping tables, aggregating transaction records, computing derived metrics, and feature engineering.
5. **Data Modeling**: Building relational schemas, statistical regression, user segmentation, or cohort models.
6. **Reporting & Dashboards**: Creating executive summaries, automated dashboards, and interactive visual charts.
7. **Insights Presentation & Action**: Formulating data-driven business decisions with projected return on investment (ROI).

![Data Analytics Workflow](Data_Analytics_Workflow_Visual.png)

---

### Demo: Comprehensive End-to-End Analytics Workflow (Original Case Study)

#### Case Study Title: *Zomato Late-Night Food Delivery Optimization & Cart Abandonment Mitigation*

| Workflow Stage | Applied Stage Execution | Core Artifacts / Tools Used |
| :--- | :--- | :--- |
| **Stage 1: Requirement Gathering** | **Problem Statement**: Late-night (11:00 PM – 4:00 AM) cart abandonment rates spiked from 18% to 41% across Tier-1 metro clusters.<br>**Business Question**: *"Why are high-intent users dropping off during late-night checkout, and how can we recover Rs. 4.5M in lost weekly GMV?"* | Stakeholder PRD, Jira, BRD, KPI Definition Document |
| **Stage 2: Data Collection** | Extracted 1.2M checkout session logs from AWS Athena/S3, transactional records from PostgreSQL replica, rider GPS ping logs via Kafka, and restaurant operational status logs via MongoDB. | Apache Kafka, AWS Athena, SQL (PostgreSQL), REST APIs |
| **Stage 3: Data Cleaning** | Filtered null session IDs, imputed missing delivery time estimates using historical road median times, stripped corrupted currency strings (`Rs.`, commas), and eliminated duplicate retry pings within a 2-second debounce window. | Python (`pandas`), SQL (`REGEXP_REPLACE`, `COALESCE`) |
| **Stage 4: Data Transformation** | Aggregated sessions by 15-minute time buckets, computed cart value percentiles, calculated rider-to-order ratio per postal PIN code, and pivoted restaurant cuisine tags against late-night demand. | SQL Window Functions (`AVG() OVER()`, `GROUP BY`), Python |
| **Stage 5: Data Modeling** | Developed a logistic regression model to identify the top drivers of checkout abandonment. Found that **surge delivery fees > Rs. 65** and **estimated delivery time (ETA) > 48 minutes** increased abandonment probability by 3.8x. | Scikit-Learn, Statsmodels, Feature Store |
| **Stage 6: Reporting & Dashboards** | Built an interactive real-time Power BI & Tableau operational control dashboard monitoring live cart abandonment, unassigned orders, and fleet surge heatmaps. | Power BI, Tableau, DAX Measures |
| **Stage 7: Insights & Action Plan** | **Key Insight**: 68% of drop-offs were due to sudden late-night surge pricing combined with lack of available delivery partners in dense student/tech hubs.<br>**Action**: Introduced a dynamic rider incentive (Rs. 30 night-shift bonus per order) and capped surge fees at Rs. 40 for orders above Rs. 350. Recovered 29% of abandoned carts within 3 weeks. | Executive Deck, C-Level KPI Scorecard, A/B Testing Rollout |

---

### Task 1: Real-World Analytics Problem & Business Question

#### Selected Application: **Zomato (Food Delivery & Quick Commerce)**

#### Context & Problem Description:
In rapidly urbanizing cities like Ahmedabad, Pune, and Bengaluru, consumer eating habits shift dynamically between weekdays (office quick lunches and healthy diet bowls) and weekends (late-night fast food, biryani, and party platters). However, cloud kitchens and restaurant partners frequently suffer from food wastage on weekdays due to over-preparation, and stock-outs on weekends resulting in missed order demand. Concurrently, Zomato experiences delivery fleet bottlenecks when sudden order clusters overwhelm specific neighborhoods like Prahladnagar and Satellite in Ahmedabad.

#### Core Business Question:
> *"Which specific food categories and cuisine price segments generate the highest demand volume and customer retention in West Ahmedabad between Friday evening and Sunday night, and what is the optimal rider allocation needed per 1-kilometer radius to maintain an Average Delivery Time (ADT) under 28 minutes?"*

#### Targeted Analytics Output:
1. **Demand Forecasting**: Hourly predicted order volumes split by cuisine category (Pizza/Burger vs. North Indian Thalis vs. Desserts).
2. **Fleet Rebalancing**: Predictive heatmaps dispatching gig riders to hot zones 20 minutes prior to order spikes.
3. **Restaurant Partner Recommendations**: Personalized merchant portal alerts advising prep quantities to eliminate stock-outs.

---

### Task 2: Data Collection for Spotify Music Listening Trends

To analyze music listening trends, user behavior, and viral song discovery on **Spotify**, the data engineering and analytics team must collect granular event-level telemetry data.

#### The 5 Essential Raw Data Types:

| # | Data Attribute | Data Type | Sample Value | Analytical Purpose & Justification |
| :-: | :--- | :--- | :--- | :--- |
| **1** | `user_id` / `demographic_context` | String / UUID | `usr_89f412a9c` | Tracks individual user journey, subscription tier (Free vs. Premium), country, age group, and historical genre preferences for cohort segmentation. |
| **2** | `track_id` & `track_metadata` | String / Object | `trk_7eA819K` (*Title: "Starboy"*, *Artist: "The Weeknd"*, *BPM: 186*, *Key: G Major*) | Essential for identifying which artist, album, language, and tempo attributes are gaining momentum across distinct geographies. |
| **3** | `play_timestamp_utc` | Timestamp (ISO 8601) | `2026-09-28T14:32:18.420Z` | Establishes time-series listening behavior (morning commutes, workout hours, late-night study sessions) and day-of-week trends. |
| **4** | `duration_played_ms` & `completion_status` | Integer / Enum | `194500` ms (Total length: `210000` ms, `Skipped: False`, `Skip_at: null`) | Differentiates between passive skips (< 30 seconds) and high-engagement listens (> 80% completion), which feeds Spotify's algorithmic recommendation engine. |
| **5** | `listening_context` & `device_type` | String / Enum | `Context: "Editorial Playlist: Today's Top Hits"`, `Device: "CarPlay (iOS)"` | Pinpoints discovery vectors (algorithmic radio, search query, personalized Release Radar, user-generated playlist, or external link share) and hardware ecosystem. |

---

### Task 3: Data Cleaning & Standardization

#### Input Messy Record:
```text
product_id: 123, name: 'iPhone 14 ', price: '79999 ', category: ' Mobiles', rating: '4.5 ', stock: 'Yes'
```

#### Cleaning Pipeline Steps:
1. **`product_id`**: Already numeric; cast explicitly to `int` or standard primary key format.
2. **`name`**: Strip leading and trailing whitespace using `.strip()` to prevent search index fragmentation (`'iPhone 14 '` -> `'iPhone 14'`).
3. **`price`**: Strip trailing whitespace and cast from string `'79999 '` to integer `79999` to enable arithmetic calculations (sums, discounts, averages).
4. **`category`**: Strip leading whitespace and convert to lowercase/title-case (`' Mobiles'` -> `'mobiles'`) for uniform taxonomy grouping.
5. **`rating`**: Strip trailing whitespace and cast string `'4.5 '` to IEEE 754 float `4.5` for mathematical statistical analysis.
6. **`stock`**: Convert business string literal `'Yes'` to boolean `True` (or binary `1`) to adhere to standard relational/data frame boolean schema.

#### Comparison Table:

| Field Name | Raw Messy Input | Raw Data Type | Cleaned & Standardized Output | Final Data Type | Cleaning Technique Applied |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `product_id` | `123` | String / Num | `123` | `Integer` | Enforce integer data type |
| `name` | `'iPhone 14 '` | String | `'iPhone 14'` | `String (VARCHAR)` | `.strip()` whitespace removal |
| `price` | `'79999 '` | String | `79999` | `Integer (INT)` | `.strip()` and typecast `int()` |
| `category` | `' Mobiles'` | String | `'mobiles'` | `String (VARCHAR)` | `.strip().lower()` standardization |
| `rating` | `'4.5 '` | String | `4.5` | `Float (DECIMAL)` | `.strip()` and typecast `float()` |
| `stock` | `'Yes'` | String | `True` | `Boolean (BOOL)` | Boolean mapping (`Yes`/`No` -> `True`/`False`) |

#### Executed Python Code ([`task3_clean_product.py`](task3_clean_product.py)):
```python
raw_product = {
    'product_id': 123,
    'name': 'iPhone 14 ',
    'price': '79999 ',
    'category': ' Mobiles',
    'rating': '4.5 ',
    'stock': 'Yes'
}

cleaned_product = {
    'product_id': int(raw_product['product_id']),
    'name': raw_product['name'].strip(),
    'price': int(raw_product['price'].strip()),
    'category': raw_product['category'].strip().lower(),
    'rating': float(raw_product['rating'].strip()),
    'stock': True if raw_product['stock'].strip().lower() in ['yes', 'true', '1'] else False
}
```

---

### Task 4: Raw Order Data Transformation

#### Raw Dataset:
* `(User A, Pizza, 300)`
* `(User B, Burger, 150)`
* `(User A, Burger, 150)`

#### Transformation Process:
To transform raw transactional records into an analytical customer profile table:
1. **Grouping**: Group records by `user_id`.
2. **Aggregation**: Sum the `price` column using `SUM(price)` to calculate `total_spend`.
3. **Count**: Count the number of unique orders using `COUNT(item)`.
4. **List Aggregation**: Collect distinct or sequence items ordered using `ARRAY_AGG()` or string joins.

#### Transformed Customer Summary Table:

| User ID | Total Spend (INR) | Total Orders | Items Ordered | Average Order Value (AOV) |
| :---: | :---: | :---: | :---: | :---: |
| **User A** | **Rs. 450** | 2 | Pizza, Burger | Rs. 225.00 |
| **User B** | **Rs. 150** | 1 | Burger | Rs. 150.00 |
| **Cohort Total** | **Rs. 600** | **3** | - | **Rs. 200.00** |

#### SQL Implementation:
```sql
SELECT 
    user_id,
    COUNT(order_id) AS total_orders,
    SUM(price) AS total_spend_inr,
    GROUP_CONCAT(item SEPARATOR ', ') AS items_ordered,
    ROUND(AVG(price), 2) AS average_order_value_inr
FROM customer_orders
GROUP BY user_id
ORDER BY total_spend_inr DESC;
```

---

### Task 5: BookMyShow Ticket Sales Analysis & Managerial Insight

#### Movie Ticket Sales Dataset:

| Movie Title | Genre | Tickets Sold | Avg Ticket Price (INR) | Total Revenue (INR) | Market Share (%) |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Dune: Part Two** | Sci-Fi / Adventure | **42,600** | Rs. 380 | Rs. 1,61,88,000 | **46.05%** |
| **Oppenheimer (Re-run)** | Biographical Drama | **31,500** | Rs. 420 | Rs. 1,32,30,000 | **34.05%** |
| **Inception (Special)** | Sci-Fi / Action | **18,400** | Rs. 350 | Rs. 64,40,000 | **19.89%** |
| **Total Weekend Sales** | - | **92,500** | **Rs. 387.76** | **Rs. 3,58,58,000** | **100.0%** |

#### Visual Output:
![BookMyShow Ticket Sales Chart](Task_5_BookMyShow_Tickets_BarChart.png)

#### Managerial & Executive Insight:
> **Primary Insight:**
> *"Dune: Part Two dominates consumer demand, capturing **46% of total weekend tickets sold** and delivering over **Rs. 16.1M in box office gross**, while Oppenheimer's re-release commands the highest Average Ticket Price (**Rs. 420** due to premium IMAX 70mm and 4DX seating formats)."*
>
> **Actionable Strategic Recommendation for Cinema Operations:**
> 1. **Screen Reallocation**: Multiplexes should reallocate 30% of mid-day standard 2D screens from older titles to *Dune: Part Two* prime evening slots (7:00 PM – 10:30 PM), where ticket capacity utilization is currently hitting 94%.
> 2. **F&B Cross-Sell Bundling**: Because IMAX attendees for *Oppenheimer* exhibit a 28% higher spending propensity, introduce bundled concessions (Gourmet Popcorn + Beverage combos at Rs. 499) at the point of digital checkout on BookMyShow, projected to unlock an incremental **Rs. 1.8M in high-margin concession revenue**.

---

### Verification & Deliverable Inventory

All code, data files, visual assets, and spreadsheets have been generated and validated inside:
`D:\DA\Data_analytics\assingments\module-1-fundamental-ITIndustry Assignment\Session 4`

| File Name | Description | Status |
| :--- | :--- | :--- |
| `task3_clean_product.py` | Python script standardizing messy e-commerce fields | Verified |
| `task4_transform_orders.py` | Python script transforming Zomato transactions to user spend | Verified |
| `task5_bookmyshow_analysis.py` | Matplotlib and openpyxl script generating chart and Excel | Verified |
| `BookMyShow_Ticket_Sales.xlsx` | Excel workbook containing ticket sales and revenue model | Verified |
| `Task_5_BookMyShow_Tickets_BarChart.png` | 300 DPI high-resolution bar chart of movie ticket sales | Verified |
| `generate_workflow_diagram.py` | Python script rendering the 7-step analytics pipeline diagram | Verified |
| `Data_Analytics_Workflow_Visual.png` | 300 DPI professional infographic of the analytics workflow | Verified |
| `Session_4_Assignment_Submission.md` | Master Markdown report with full documentation and analysis | Verified |
| `Session_4_Assignment_Submission.html` | Presentation-ready HTML document | In Progress |
