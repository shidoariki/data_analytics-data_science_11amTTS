-- =====================================================================
-- SESSION 5: DISTINCT, ORDER BY, LIMIT
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- 1. Demo Table: products_catalog (Top 10 highest selling products)
DROP TABLE IF EXISTS products_catalog;
CREATE TABLE products_catalog (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    units_sold INT NOT NULL,
    revenue DECIMAL(12,2)
);

INSERT INTO products_catalog (product_id, product_name, category, units_sold, revenue) VALUES
(1, 'Apple iPhone 15 (128GB)', 'Electronics', 14500, 108750000.00),
(2, 'boAt Rockerz 450 Bluetooth Headphone', 'Audio', 32000, 48000000.00),
(3, 'OnePlus Nord CE 3 Lite 5G', 'Electronics', 28500, 57000000.00),
(4, 'Puma Men Stride Running Shoes', 'Footwear', 19800, 39600000.00),
(5, 'Sony WH-1000XM5 ANC Headphones', 'Audio', 6200, 18600000.00),
(6, 'Samsung Galaxy S23 5G', 'Electronics', 16400, 114800000.00),
(7, 'Philips Air Fryer HD9200', 'Home Appliances', 11200, 67200000.00),
(8, 'Mi Smart Band 8 Active', 'Wearables', 24100, 48200000.00),
(9, 'Prestige Iris 750W Mixer Grinder', 'Home Appliances', 17900, 53700000.00),
(10, 'Levi''s Men 511 Slim Jeans', 'Fashion', 15300, 38250000.00),
(11, 'Realme Pad 2 WiFi Tablet', 'Electronics', 8900, 17800000.00),
(12, 'Noise Pulse 2 Max Smartwatch', 'Wearables', 21500, 32250000.00),
(13, 'Amazon Fire TV Stick 4K', 'Electronics', 22400, 89600000.00),
(14, 'Fastrack Limitless FS1 Smartwatch', 'Wearables', 18300, 27450000.00),
(15, 'Logitech MK215 Wireless Combo', 'Accessories', 13100, 19650000.00);

-- 2. Task 1 Table: orders (Food delivery app orders)
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_name VARCHAR(100),
    amount DECIMAL(8,2),
    payment_method VARCHAR(50) NOT NULL,
    order_status VARCHAR(30)
);

INSERT INTO orders (order_id, user_id, restaurant_name, amount, payment_method, order_status) VALUES
(1001, 101, 'Dominos Pizza', 450.00, 'UPI', 'Delivered'),
(1002, 102, 'Biryani By Kilo', 620.00, 'Credit Card', 'Delivered'),
(1003, 103, 'Subway', 280.00, 'Cash on Delivery', 'Delivered'),
(1004, 104, 'McDonalds', 390.00, 'UPI', 'Delivered'),
(1005, 105, 'KFC', 540.00, 'Debit Card', 'Delivered'),
(1006, 101, 'Haldirams', 310.00, 'Net Banking', 'Delivered'),
(1007, 106, 'Burger King', 250.00, 'UPI', 'Delivered'),
(1008, 107, 'Pizza Hut', 780.00, 'Credit Card', 'Delivered'),
(1009, 108, 'Starbucks Coffee', 420.00, 'Digital Wallet', 'Delivered'),
(1010, 109, 'Chai Point', 150.00, 'UPI', 'Delivered'),
(1011, 110, 'Taco Bell', 490.00, 'Cash on Delivery', 'Delivered'),
(1012, 102, 'Barbeque Nation', 1250.00, 'Digital Wallet', 'Delivered');

-- 3. Task 2 Table: users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50)
);

INSERT INTO users (user_id, username, city, state) VALUES
(1, 'rohan_sharma', 'Mumbai', 'Maharashtra'),
(2, 'priya_patel', 'Ahmedabad', 'Gujarat'),
(3, 'amit_kumar', 'Bengaluru', 'Karnataka'),
(4, 'ananya_sen', 'Kolkata', 'West Bengal'),
(5, 'vikram_singh', 'Jaipur', 'Rajasthan'),
(6, 'neha_gupta', 'Delhi', 'Delhi NCR'),
(7, 'rahul_deshmukh', 'Pune', 'Maharashtra'),
(8, 'siddharth_joshi', 'Ahmedabad', 'Gujarat'),
(9, 'deepa_nair', 'Chennai', 'Tamil Nadu'),
(10, 'kavita_iyer', 'Bengaluru', 'Karnataka'),
(11, 'suresh_reddy', 'Hyderabad', 'Telangana'),
(12, 'pooja_verma', 'Mumbai', 'Maharashtra'),
(13, 'manoj_tiwari', 'Varanasi', 'Uttar Pradesh'),
(14, 'tanya_bhatia', 'Chandigarh', 'Punjab'),
(15, 'arjun_mehta', 'Surat', 'Gujarat');

-- 4. Task 3 Table: bookings (Movie bookings)
DROP TABLE IF EXISTS bookings;
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_name VARCHAR(100) NOT NULL,
    theater_name VARCHAR(100),
    tickets_count INT,
    booking_date DATETIME NOT NULL
);

INSERT INTO bookings (booking_id, user_id, movie_name, theater_name, tickets_count, booking_date) VALUES
(501, 101, 'Dune: Part Two', 'PVR Forum IMAX', 2, '2024-03-25 14:30:00'),
(502, 104, 'Oppenheimer', 'INOX Megaplex', 3, '2024-03-26 18:15:00'),
(503, 108, 'Kung Fu Panda 4', 'Cinepolis Alpha', 4, '2024-03-27 11:00:00'),
(504, 102, 'Fighter', 'PVR Icon Gold', 2, '2024-03-28 20:45:00'),
(505, 109, 'Godzilla x Kong', 'Miraj Cinemas', 2, '2024-03-29 16:20:00'),
(506, 115, 'Shaitaan', 'PVR Acropolis', 3, '2024-03-30 21:00:00'),
(507, 103, 'Manjummel Boys', 'INOX Nexus', 2, '2024-03-31 15:10:00'),
(508, 120, 'Bade Miyan Chote Miyan', 'PVR PALLADIUM', 5, '2024-04-01 19:30:00');

-- 5. Task 4 Table: products (Flipkart-style)
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    sold_count INT NOT NULL,
    rating DECIMAL(2,1)
);

INSERT INTO products (id, name, category, sold_count, rating) VALUES
(201, 'boAt Airdopes 131', 'Audio', 85400, 4.1),
(202, 'SanDisk 128GB Pen Drive', 'Storage', 62300, 4.3),
(203, 'Noise ColorFit Icon Buzz', 'Wearables', 48900, 4.2),
(204, 'Fire-Boltt Ninja Call Pro', 'Wearables', 54100, 4.0),
(205, 'realme C53', 'Mobiles', 71200, 4.4),
(206, 'Poco M6 Pro 5G', 'Mobiles', 68400, 4.3),
(207, 'Zebronics Wired Mouse', 'Accessories', 39100, 3.9),
(208, 'Boult Audio Z40', 'Audio', 77800, 4.2),
(209, 'Portronics 6-in-1 Type C Hub', 'Accessories', 29400, 4.0),
(210, 'Mi Power Bank 3i 20000mAh', 'Accessories', 58700, 4.4),
(211, 'Samsung Galaxy M14 5G', 'Mobiles', 64500, 4.2),
(212, 'OnePlus Bullets Wireless Z2', 'Audio', 81200, 4.3),
(213, 'Ambrane 20W Fast Charger', 'Accessories', 35600, 4.1),
(214, 'Syska 12W LED Bulb Pack', 'Home', 44200, 4.0);
