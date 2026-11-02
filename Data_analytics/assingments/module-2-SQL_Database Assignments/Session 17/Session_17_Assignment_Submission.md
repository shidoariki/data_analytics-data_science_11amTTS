# Session 17 – CASE WHEN (Conditional Logic)
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** Conditional Expressions, On-the-Fly Categorization, and Value Binning  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Concepts Overview

The `CASE` statement provides conditional branching logic directly within SQL queries (analogous to `if-then-else` constructs in procedural languages). In data analytics, `CASE` expressions are vital for:
1. **Value Binning**: Grouping continuous numerical variables (spend, duration, ratings) into discrete operational buckets (Budget, Standard, Premium).
2. **Label Standardizing**: Mapping coded status values into business-friendly descriptors.
3. **Conditional Aggregation**: Counting or summing specific segments within a single `SELECT` block.

### Anatomy of CASE WHEN Expression
```sql
CASE
    WHEN condition_1 THEN result_1
    WHEN condition_2 THEN result_2
    ELSE fallback_result
END AS output_column_alias
```

---

## 2. Assignment Tasks & SQL Solutions

### Demo: Customer Value Segmentation
```sql
SELECT 
    customer_id,
    customer_name,
    total_spend,
    CASE 
        WHEN total_spend >= 10000 THEN 'High Value'
        WHEN total_spend >= 3000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_tier
FROM customers
ORDER BY total_spend DESC;
```

### Task 1: Food Order Size Categorization
```sql
SELECT 
    order_id,
    customer_name,
    total_amount,
    order_date,
    CASE 
        WHEN total_amount < 300 THEN 'Small'
        WHEN total_amount BETWEEN 300 AND 999 THEN 'Medium'
        ELSE 'Large'
    END AS order_size_category
FROM FoodOrders
ORDER BY total_amount DESC;
```

### Task 2: Movie Popularity Classification
```sql
SELECT 
    movie_id,
    movie_title,
    genre,
    rating,
    CASE 
        WHEN rating >= 8.0 THEN 'Blockbuster'
        WHEN rating >= 5.0 THEN 'Hit'
        ELSE 'Average'
    END AS popularity
FROM Movies
ORDER BY rating DESC;
```

### Task 3: Flipkart Product Price Binning
```sql
SELECT 
    product_id,
    product_name,
    category,
    price,
    CASE 
        WHEN price < 500 THEN 'Budget'
        WHEN price BETWEEN 500 AND 2000 THEN 'Standard'
        ELSE 'Premium'
    END AS price_category
FROM FlipkartProducts
ORDER BY price DESC;
```

### Task 4: Spotify Track Duration Labeling
```sql
SELECT 
    track_id,
    track_title,
    artist,
    duration_seconds,
    CASE 
        WHEN duration_seconds < 180 THEN 'Short'
        WHEN duration_seconds BETWEEN 180 AND 300 THEN 'Medium'
        ELSE 'Long'
    END AS duration_label
FROM SpotifyTracks
ORDER BY duration_seconds DESC;
```

---

## 3. Execution & Verification Output

```text
--- DEMO: Customer Value Segmentation ---
(4, 'Ananya Iyer', 18900, 'High Value')
(1, 'Aarav Patel', 15400, 'High Value')
(5, 'Kabir Mehta', 6500, 'Medium Value')
(2, 'Diya Sharma', 4200, 'Medium Value')
(3, 'Rohan Verma', 850, 'Low Value')

--- TASK 1: Food Order Size Categorization ---
(106, 'Sneha Joshi', 2100, 'Large')
(104, 'Ananya Iyer', 1450, 'Large')
(103, 'Rohan Patel', 850, 'Medium')
(102, 'Priya Verma', 350, 'Medium')
(101, 'Aarav Patel', 240, 'Small')
(105, 'Kabir Mehta', 120, 'Small')

--- TASK 2: Movie Popularity Classification ---
(201, 'The Dark Knight', 'Action', 9, 'Blockbuster')
(202, 'Oppenheimer', 'Drama', 8.9, 'Blockbuster')
(204, 'Fast X', 'Action', 5.8, 'Hit')
(203, 'Brahmastra', 'Fantasy', 5.6, 'Hit')
(205, 'Adipurush', 'Mythology', 3.8, 'Average')
(206, 'Housefull 4', 'Comedy', 3.5, 'Average')

--- TASK 3: Flipkart Product Price Binning ---
(306, 'Smart Watch', 'Wearables', 8999, 'Premium')
(304, 'Mechanical Keyboard', 'Gaming', 3499, 'Premium')
(303, 'Bluetooth Speaker', 'Audio', 1699, 'Standard')
(302, 'Wireless Mouse', 'Electronics', 799, 'Standard')
(305, 'Cotton T-Shirt', 'Fashion', 450, 'Budget')
(301, 'USB-C Cable', 'Accessories', 299, 'Budget')

--- TASK 4: Spotify Track Duration Labeling ---
(404, 'All Too Well (10 Min)', 'Taylor Swift', 613, 'Long')
(405, 'Bohemian Rhapsody', 'Queen', 354, 'Long')
(402, 'Kesariya', 'Arijit Singh', 268, 'Medium')
(403, 'Shape of You', 'Ed Sheeran', 233, 'Medium')
(406, 'Levitating', 'Dua Lipa', 158, 'Short')
(401, 'Stay', 'Kid LAROI & Justin Bieber', 141, 'Short')

Session 17 Verification Successful!
```
