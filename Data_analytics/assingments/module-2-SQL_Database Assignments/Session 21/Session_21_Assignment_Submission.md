# Session 21 – SQL + Excel Integration (Advanced)
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** Advanced Excel & SQL Integration, Power Query M-Engine, Cell-Bound Parameterized Queries & Live Dynamic Refresh  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Integration Architecture

Power Query connects Microsoft Excel directly to SQL Server / relational engines to automate repetitive reporting. By shifting heavy filtering and aggregation to the database server (SQL pushdown) and exposing user-friendly cell parameters in Excel worksheets, business users obtain interactive dashboards without writing raw SQL.

---

## 2. Assignment Tasks & Technical Implementations

### Task 1: Connect Excel Workbook to SQL Server via Power Query
- **Navigation Path**: `Data Ribbon > Get Data > From Database > From SQL Server Database`.
- **Server**: `localhost` | **Database**: `analytics_db` | **Table**: `Restaurants`.
- **Loaded Columns**: `name`, `cuisine`, `rating`, `cost_for_two`, `city`.

### Task 2: Parameterized Query in Power Query Bound to an Excel Cell
- **Objective**: Filter `Restaurants` dynamically based on a value entered in Excel Cell `B2` (Named Range: `SelectedCuisine`).
- **Power Query M-Code Implementation**:
  ```powerquery
  let
      // 1. Read parameter value dynamically from Excel named range
      CuisineParam = Excel.CurrentWorkbook(){[Name="SelectedCuisine"]}[Content]{0}[Column1],

      // 2. Pass parameter safely into SQL Native Query
      Source = Sql.Database("localhost", "analytics_db", [
          Query = "SELECT name, cuisine, rating, cost_for_two, city FROM Restaurants WHERE cuisine = '" & Text.Replace(CuisineParam, "'", "''") & "' ORDER BY rating DESC"
      ])
  in
      Source
  ```
- **Test Results**:
  - Filter `'South Indian'`: Returned Taaza Thindi (4.7), Vidyarthi Bhavan (4.6), MTR (4.5), Udupi Upahar (3.6).
  - Filter `'Chinese'`: Returned Mainland China (4.2), Bangalore Mandarin (4.1), Chung Wah (3.8), Street Wok (3.2).

### Task 3: Enabling Dynamic One-Click and Automated Refresh
To enable instant synchronization when records are added or updated in SQL Server:
1. Open **Queries & Connections** pane in Excel.
2. Right-click the SQL query connection > select **Properties**.
3. Under the **Usage** tab:
   - Check **Enable background refresh**.
   - Check **Refresh data when opening the file**.
   - Set **Refresh every 15 minutes** for near real-time operational feeds.
4. **Manual Refresh Trigger**: Press `Ctrl + Alt + F5` ("Refresh All") or right-click any table cell and select `Refresh`.

### Task 4: Filter Rating > 4.0 with Dashboard Table & Bar Chart
- **SQL Source**:
  ```sql
  SELECT name, cuisine, rating, cost_for_two, city
  FROM Restaurants
  WHERE rating > 4.0
  ORDER BY rating DESC;
  ```
- **Generated Workbook**: `restaurants_dashboard.xlsx` featuring:
  - Formatted styled Excel Table of high-rated venues.
  - Native embedded Excel **Clustered Column / Bar Chart** plotting restaurant ratings against names.

### Task 5: AI-Assisted Dual-Parameterized Query (Rating Range: Min to Max)
- **Power Query Native SQL Formulation**:
  ```sql
  SELECT name, cuisine, rating, cost_for_two, city
  FROM Restaurants
  WHERE rating BETWEEN @MinRating AND @MaxRating
  ORDER BY rating DESC;
  ```
- **Power Query M Script**:
  ```powerquery
  let
      MinR = Text.From(Excel.CurrentWorkbook(){[Name="MinRating"]}[Content]{0}[Column1]),
      MaxR = Text.From(Excel.CurrentWorkbook(){[Name="MaxRating"]}[Content]{0}[Column1]),
      Source = Sql.Database("localhost", "analytics_db", [
          Query = "SELECT name, cuisine, rating, cost_for_two, city FROM Restaurants WHERE rating BETWEEN " & MinR & " AND " & MaxR & " ORDER BY rating DESC"
      ])
  in
      Source
  ```
- **Test Output (Range: 3.5 to 5.0)**:
  Retrieved 15 restaurants from Corner House Ice Cream (4.8) down to Udupi Upahar (3.6).

---

## 3. Verification & Execution Summary

```text
Generated Excel Dashboard: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 21\restaurants_dashboard.xlsx

--- TASK 1: Power Query Initial Load ---
('Mavalli Tiffin Room (MTR)', 'South Indian', 4.5, 300, 'Bangalore')
('Vidyarthi Bhavan', 'South Indian', 4.6, 200, 'Bangalore')
('Taaza Thindi', 'South Indian', 4.7, 150, 'Bangalore')
('Mainland China', 'Chinese', 4.2, 1400, 'Bangalore')
('Chung Wah', 'Chinese', 3.8, 700, 'Bangalore')

--- TASK 2: Parameterized Filter by Cuisine ('South Indian') ---
('Taaza Thindi', 'South Indian', 4.7, 150, 'Bangalore')
('Vidyarthi Bhavan', 'South Indian', 4.6, 200, 'Bangalore')
('Mavalli Tiffin Room (MTR)', 'South Indian', 4.5, 300, 'Bangalore')
('Udupi Upahar', 'South Indian', 3.6, 200, 'Bangalore')

--- TASK 3: Dynamic Refresh Simulation ---
Total restaurants after live insertion: 16

--- TASK 4: High Rated Restaurants (Rating > 4.0) ---
('Corner House Ice Cream', 'Desserts', 4.8)
('Taaza Thindi', 'South Indian', 4.7)
('New Paradise Biryani', 'Biryani', 4.7)
('Vidyarthi Bhavan', 'South Indian', 4.6)
('Toit Brewpub', 'Continental', 4.6)
('Mavalli Tiffin Room (MTR)', 'South Indian', 4.5)
('Truffles', 'Continental', 4.5)
('Meghana Foods', 'Biryani', 4.5)
('Punjab Grill', 'North Indian', 4.4)
('Nagarjuna', 'Andhra', 4.3)
('Mainland China', 'Chinese', 4.2)
('Bangalore Mandarin', 'Chinese', 4.1)

Session 21 Verification Successful!
```
