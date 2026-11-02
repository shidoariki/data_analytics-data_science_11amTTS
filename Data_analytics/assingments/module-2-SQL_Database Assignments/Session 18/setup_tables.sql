-- =====================================================================
-- SESSION 18: Views
-- Setup Script: Database Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Table: daily_sales
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS daily_sales;
CREATE TABLE daily_sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE NOT NULL,
    category VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO daily_sales (sale_id, sale_date, category, amount) VALUES
(1, '2024-04-01', 'Electronics', 12500.00),
(2, '2024-04-01', 'Fashion', 3200.00),
(3, '2024-04-02', 'Electronics', 18900.00),
(4, '2024-04-02', 'Grocery', 4500.00),
(5, '2024-04-03', 'Fashion', 6100.00);

-- ---------------------------------------------------------------------
-- Task 1 & 2 Tables: restaurants & restaurant_reviews
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS restaurant_reviews;
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE restaurant_reviews (
    review_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL,
    review_text VARCHAR(255),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

INSERT INTO restaurants (restaurant_id, restaurant_name, city) VALUES
(1, 'Truffles', 'Bangalore'),
(2, 'Empire Restaurant', 'Bangalore'),
(3, 'Corner House Ice Cream', 'Bangalore'),
(4, 'Meghana Foods', 'Bangalore'),
(5, 'Street Cafe', 'Bangalore');

INSERT INTO restaurant_reviews (review_id, restaurant_id, rating, review_text) VALUES
(101, 1, 4.5, 'Amazing burgers!'),
(102, 1, 4.7, 'Great ambiance'),
(103, 1, 4.3, 'Good fries'),
(104, 2, 3.8, 'Decent food, slow service'),
(105, 2, 3.9, 'Average taste'),
(106, 3, 4.8, 'Death by Chocolate is unmatched'),
(107, 3, 4.9, 'Best ice cream in town'),
(108, 4, 4.6, 'Biryani was flavorful and spicy'),
(109, 4, 4.4, 'Consistent quality'),
(110, 5, 2.5, 'Cold food, unhygienic'),
(111, 5, 2.8, 'Not worth it');

-- ---------------------------------------------------------------------
-- Task 4 Table: swiggy_orders
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS swiggy_orders;
CREATE TABLE swiggy_orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL
);

-- Note: We include recent dates (within 30 days) and old dates (>30 days)
INSERT INTO swiggy_orders (order_id, order_date, order_amount) VALUES
(1, '2024-04-01', 350.00),
(2, '2024-04-01', 420.00),
(3, '2024-04-02', 650.00),
(4, '2024-04-03', 280.00),
(5, '2024-04-03', 590.00),
(6, '2024-04-04', 850.00),
(7, '2024-01-10', 500.00),  -- Old order (> 30 days)
(8, '2024-01-12', 300.00);  -- Old order (> 30 days)
