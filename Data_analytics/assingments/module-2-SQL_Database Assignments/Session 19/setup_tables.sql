-- =====================================================================
-- SESSION 19: Indexing & Query Optimization
-- Setup Script: Database Tables & Schemas
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Orders Table (Populated with 15,000+ rows via populate_orders.py)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(20) NOT NULL
);

-- ---------------------------------------------------------------------
-- Products Table (For Category Indexing & Avoiding Full Table Scans)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

INSERT INTO products (product_id, product_name, category, price, stock_quantity) VALUES
(1, 'iPhone 15 Pro', 'Electronics', 134900.00, 50),
(2, 'Samsung Galaxy S24', 'Electronics', 79999.00, 65),
(3, 'OnePlus 12', 'Electronics', 64999.00, 80),
(4, 'Men''s Slim Fit Jeans', 'Apparel', 1499.00, 200),
(5, 'Women''s Kurta', 'Apparel', 999.00, 150),
(6, 'Casual Sneakers', 'Footwear', 2499.00, 120),
(7, 'Running Shoes', 'Footwear', 3999.00, 90),
(8, 'Organic Green Tea', 'Grocery', 350.00, 500),
(9, 'Cold Pressed Olive Oil', 'Grocery', 890.00, 300),
(10, 'Stainless Steel Water Bottle', 'Home & Kitchen', 650.00, 400);
