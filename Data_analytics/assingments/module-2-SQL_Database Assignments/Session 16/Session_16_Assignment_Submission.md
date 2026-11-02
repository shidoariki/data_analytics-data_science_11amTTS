# Session 16 – String Functions
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** String Manipulation, Sanitization, Extraction, and Normalization  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Concepts Overview

Data in transactional systems is often unstandardized due to varied input sources. String functions provide the tooling necessary to sanitize, reformat, concatenate, and extract meaningful sub-patterns:

- **`CONCAT()`**: Merges multiple string attributes (e.g. names, full addresses).
- **`UPPER()` / `LOWER()`**: Normalizes case-sensitivity before joins or aggregations.
- **`TRIM()`**: Eliminates accidental whitespace padding that causes lookup misses.
- **`SUBSTR()`, `LEFT()`, `RIGHT()`**: Slices strings at fixed offsets or from string tails.
- **`REPLACE()`**: Transforms delimiters or replaces unwanted characters.

---

## 2. Assignment Tasks & SQL Solutions

### Demo: Clean Inconsistent Product Codes
```sql
SELECT 
    raw_id,
    raw_code,
    UPPER(TRIM(raw_code)) AS normalized_code,
    REPLACE(UPPER(TRIM(raw_code)), '-', '_') AS cleaned_standard_code
FROM dirty_product_codes;
```

### Task 1: Concatenate First and Last Names
```sql
-- MySQL Syntax:
SELECT 
    user_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email
FROM users;

-- SQLite Equivalent:
-- SELECT user_id, first_name || ' ' || last_name AS full_name, email FROM users;
```

### Task 2: Uppercase Song Titles
```sql
SELECT 
    id,
    song_title,
    UPPER(song_title) AS song_title_upper,
    artist
FROM playlists;
```

### Task 3: Trim Whitespace from Item Codes
```sql
SELECT 
    item_id,
    item_name,
    item_code AS raw_item_code,
    TRIM(item_code) AS cleaned_item_code
FROM food_items;
```

### Task 4: Extract IMDb Numeric Movie Number with `RIGHT()`
```sql
-- MySQL Syntax:
SELECT 
    movie_id,
    title,
    imdb_id,
    RIGHT(imdb_id, 7) AS movie_number
FROM movies;

-- SQLite Equivalent:
-- SELECT movie_id, title, imdb_id, SUBSTR(imdb_id, -7) AS movie_number FROM movies;
```

### Task 5: Replace Delimiters in SKU Codes with `REPLACE()`
```sql
SELECT 
    product_id,
    product_name,
    sku_code AS original_sku,
    REPLACE(sku_code, '-', '_') AS updated_sku_code
FROM products;
```

---

## 3. Execution & Verification Output

```text
--- DEMO: Clean Inconsistent Product Codes ---
(1, '  prd-901-nx  ', 'PRD-901-NX', 'PRD_901_NX')
(2, 'PRD-802-NY   ', 'PRD-802-NY', 'PRD_802_NY')
(3, '  prd-703-nz', 'PRD-703-NZ', 'PRD_703_NZ')
(4, 'Prd-604-NW  ', 'PRD-604-NW', 'PRD_604_NW')

--- TASK 1: CONCAT(first_name, ' ', last_name) ---
(1, 'Aarav Sharma', 'aarav.sharma@example.com')
(2, 'Priya Verma', 'priya.verma@example.com')
(3, 'Rohan Patel', 'rohan.patel@example.com')
(4, 'Ananya Iyer', 'ananya.iyer@example.com')
(5, 'Kabir Mehta', 'kabir.mehta@example.com')

--- TASK 2: Song Titles in UPPER() ---
(1, 'kesariya', 'KESARIYA', 'Arijit Singh')
(2, 'shape of you', 'SHAPE OF YOU', 'Ed Sheeran')
(3, 'blinding lights', 'BLINDING LIGHTS', 'The Weeknd')
(4, 'apna bana le', 'APNA BANA LE', 'Arijit Singh')
(5, 'stay', 'STAY', 'Justin Bieber')

--- TASK 3: TRIM(item_code) Whitespace Removal ---
1 | Paneer Butter Masala | Raw: '  PBM-101  ' -> Cleaned: 'PBM-101'
2 | Butter Naan | Raw: 'BN-202   ' -> Cleaned: 'BN-202'
3 | Chicken Biryani | Raw: '   CB-303' -> Cleaned: 'CB-303'
4 | Veg Hakka Noodles | Raw: '  VHN-404  ' -> Cleaned: 'VHN-404'
5 | Gulab Jamun | Raw: 'GJ-505 ' -> Cleaned: 'GJ-505'

--- TASK 4: RIGHT(imdb_id, 7) Extract Numeric ID ---
(1, 'The Shawshank Redemption', 'tt0111161', '0111161')
(2, 'The Godfather', 'tt0068646', '0068646')
(3, 'The Dark Knight', 'tt0468569', '0468569')
(4, '12 Angry Men', 'tt0050083', '0050083')
(5, "Schindler's List", 'tt0108052', '0108052')

--- TASK 5: REPLACE(sku_code, '-', '_') ---
(1, 'OnePlus 12 5G', 'MOB-123-XY', 'MOB_123_XY')
(2, 'Sony WH-1000XM5', 'AUD-456-ZZ', 'AUD_456_ZZ')
(3, 'MacBook Air M2', 'LAP-789-QW', 'LAP_789_QW')
(4, 'Apple Watch S9', 'WCH-321-AB', 'WCH_321_AB')
(5, 'Samsung Smart TV', 'TEL-654-CD', 'TEL_654_CD')

Session 16 Verification Successful!
```
