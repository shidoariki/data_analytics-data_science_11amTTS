-- =====================================================================
-- SESSION 9: ADVANCED JOINS (FULL OUTER, SELF JOIN, CROSS JOIN)
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 9
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Self Join on Employees Table -> Manager Relationship
-- Concept: A SELF JOIN joins a table to itself by creating two alias instances
--          (e.g., 'e' for employee and 'm' for manager) matching e.manager_id = m.id.
-- ---------------------------------------------------------------------
SELECT 
    e.id AS employee_id,
    e.name AS employee_name,
    e.department,
    COALESCE(m.name, 'Top Executive / No Manager') AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;


-- ---------------------------------------------------------------------
-- TASK 1: FULL OUTER JOIN between influencers and brands on city
-- Hint: Emulated via LEFT JOIN UNION RIGHT JOIN for cross-dialect compatibility
--       (Standard in MySQL and SQLite which lack native FULL OUTER JOIN keyword).
-- ---------------------------------------------------------------------
SELECT 
    i.influencer_name,
    b.brand_name,
    COALESCE(i.city, b.city) AS city
FROM influencers i
LEFT JOIN brands b ON i.city = b.city

UNION

SELECT 
    i.influencer_name,
    b.brand_name,
    COALESCE(i.city, b.city) AS city
FROM brands b
LEFT JOIN influencers i ON b.city = i.city;


-- ---------------------------------------------------------------------
-- TASK 2: SELF JOIN on Playlists (Nested Hierarchy)
-- Concept: Shows each playlist alongside its parent playlist's name.
-- ---------------------------------------------------------------------
SELECT 
    p.id AS playlist_id,
    p.playlist_name,
    COALESCE(parent.playlist_name, '[Top-Level Playlist]') AS parent_playlist_name
FROM playlists p
LEFT JOIN playlists parent ON p.parent_playlist_id = parent.id;


-- ---------------------------------------------------------------------
-- TASK 3: CROSS JOIN between users and offers
-- Concept: Produces a Cartesian product (M x N rows) pairing every user
--          with every promotional offer available.
-- Analytics Value: In e-commerce (e.g. Flipkart), a CROSS JOIN pre-populates
--                  a candidate scoring matrix. The recommendation engine
--                  subsequently filters and scores these pairs based on
--                  historical browsing and purchase propensity.
-- ---------------------------------------------------------------------
SELECT 
    u.user_name,
    o.offer_title,
    o.discount_pct
FROM users u
CROSS JOIN offers o
ORDER BY u.user_name;


-- ---------------------------------------------------------------------
-- TASK 4: SELF JOIN Employees with Managers & Filter for Top-Level Managers
-- Part A: Display each employee's name along with their manager's name
-- ---------------------------------------------------------------------
SELECT 
    e.name AS employee_name,
    m.name AS manager_name
FROM employees e
INNER JOIN employees m ON e.manager_id = m.id;

-- Part B: Modified query to ONLY show employees who do not have a manager
SELECT 
    e.id AS employee_id,
    e.name AS employee_name,
    e.department,
    'Top-Level Manager' AS role_status
FROM employees e
WHERE e.manager_id IS NULL;


-- ---------------------------------------------------------------------
-- TASK 5: AI-Assisted Query: Pairs of Users Living in the Same City
-- Query: Find all unique pairs of users residing in the same city.
-- Debugging / Improvement Insight:
-- Initial naive prompt used 'ON u1.city = u2.city AND u1.user_id != u2.user_id',
-- which produced duplicate reciprocal pairs (e.g., 'Aarav, Kabir' AND 'Kabir, Aarav').
-- The AI advised replacing '!=' with 'u1.user_id < u2.user_id', which simultaneously
-- eliminates self-comparisons and duplicate mirrored permutations.
-- ---------------------------------------------------------------------
SELECT 
    u1.user_name AS user_1,
    u2.user_name AS user_2,
    u1.city
FROM users u1
INNER JOIN users u2 ON u1.city = u2.city AND u1.user_id < u2.user_id
ORDER BY u1.city, user_1;
