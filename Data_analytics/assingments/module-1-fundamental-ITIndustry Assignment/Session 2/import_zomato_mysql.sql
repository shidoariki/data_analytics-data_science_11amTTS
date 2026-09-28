CREATE DATABASE IF NOT EXISTS zomato_db;
USE zomato_db;

DROP TABLE IF EXISTS zomato_restaurants;
CREATE TABLE zomato_restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city VARCHAR(50),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1),
    cost_for_two INT,
    online_order VARCHAR(10)
);

INSERT INTO zomato_restaurants VALUES
(101, 'Barbeque Nation', 'Mumbai', 'North Indian', 4.6, 1600, 'Yes'),
(102, 'Bawarchi', 'Hyderabad', 'Biryani', 4.3, 800, 'Yes'),
(103, 'Peter Cat', 'Kolkata', 'Continental', 4.5, 1200, 'No'),
(104, 'Karim''s', 'Delhi', 'Mughlai', 4.4, 900, 'Yes'),
(105, 'Toit Brewpub', 'Bengaluru', 'Italian', 4.7, 1800, 'No'),
(106, 'Indian Accent', 'New Delhi', 'Modern Indian', 4.9, 4500, 'No'),
(107, 'Haldiram''s', 'Nagpur', 'Street Food', 4.2, 500, 'Yes'),
(108, 'Saravana Bhavan', 'Chennai', 'South Indian', 4.4, 600, 'Yes');

SELECT * FROM zomato_restaurants;
