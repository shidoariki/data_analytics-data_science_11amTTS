-- =====================================================================
-- SESSION 21: SQL + Excel Integration (Advanced)
-- Setup Script: Database Table DDL & Sample Ingestion
-- Database: analytics_db (SQL Server / MySQL / SQLite Compatible)
-- =====================================================================

DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2,1) NOT NULL,
    cost_for_two INT NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO Restaurants (restaurant_id, name, cuisine, rating, cost_for_two, city) VALUES
(1, 'Mavalli Tiffin Room (MTR)', 'South Indian', 4.5, 300, 'Bangalore'),
(2, 'Vidyarthi Bhavan', 'South Indian', 4.6, 200, 'Bangalore'),
(3, 'Taaza Thindi', 'South Indian', 4.7, 150, 'Bangalore'),
(4, 'Mainland China', 'Chinese', 4.2, 1400, 'Bangalore'),
(5, 'Chung Wah', 'Chinese', 3.8, 700, 'Bangalore'),
(6, 'Bangalore Mandarin', 'Chinese', 4.1, 900, 'Bangalore'),
(7, 'Truffles', 'Continental', 4.5, 900, 'Bangalore'),
(8, 'Toit Brewpub', 'Continental', 4.6, 2000, 'Bangalore'),
(9, 'Empire Restaurant', 'North Indian', 3.9, 750, 'Bangalore'),
(10, 'Punjab Grill', 'North Indian', 4.4, 2200, 'Bangalore'),
(11, 'Meghana Foods', 'Biryani', 4.5, 600, 'Bangalore'),
(12, 'Nagarjuna', 'Andhra', 4.3, 800, 'Bangalore'),
(13, 'Corner House Ice Cream', 'Desserts', 4.8, 350, 'Bangalore'),
(14, 'Street Wok', 'Chinese', 3.2, 350, 'Bangalore'),
(15, 'Udupi Upahar', 'South Indian', 3.6, 200, 'Bangalore');
