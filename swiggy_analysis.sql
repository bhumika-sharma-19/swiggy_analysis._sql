CREATE DATABASE Swiggy_analysis;
USE Swiggy_analysis;

CREATE TABLE restaurant_table(
 restaurant_id int primary key,
 restaurant_name varchar(100),
 city varchar(50),
 state varchar(50),
 location varchar(100),
 catagory varchar(100),
 rating int,
 rating_count int
 );
CREATE TABLE Orders_table(
order_id INT AUTO_INCREMENT PRIMARY KEY,
restaurant_id INT,
order_date DATE,
CONSTRAINT FK_Restaurant
FOREIGN KEY(restaurant_id) 
REFERENCES restaurent_table(restaurant_id) 
on delete cascade
); 
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);
SELECT SUM(`Price (INR)`) as total_revenue
from swiggy_data;
SELECT SUM(`Rating Count`) as total_ratingcount
from swiggy_data;
SELECT SUM(Rating) as total_rating
from swiggy_data;
select*from swiggy_analysis;
select database();
describe swiggy_data;
SELECT COUNT(*) AS order_date
FROM swiggy_data;
SELECT AVG(Rating) as average_rating
FROM swiggy_data;
SELECT AVG(`Price (INR)`) as average_price
FROM swiggy_data;
SELECT AVG(`Rating Count`) as average_price
FROM swiggy_data;
select Rating,
SUM(Rating) as total_rating
From`swiggy_data`
Group by Rating
ORDER BY total_rating desc
LIMIT 5;
SELECT 
	`Dish Name`,
    COUNT(*) AS total_orders,
    SUM(`Price (INR)`) AS total_revenue,
    AVG(`Price (INR)`) AS average_order
FROM `swiggy_data`
Group by `Dish Name`
ORDER BY total_revenue desc
LIMIT 5;
SELECT 
    `City`,
    COUNT(*) AS total_orders,              -- Number of orders per customer
    SUM(`Price (INR)`) AS total_revenue,  -- Total revenue per customer
    AVG(`Price (INR)`) AS average_order   -- Average order value per customer
FROM `swiggy_data`
GROUP BY `City`                     -- Group orders by customer
ORDER BY `city` DESC               -- Sort by highest revenue
LIMIT 5;
                                 -- Show top 5 customers

SELECT 
    `Restaurant Name`,
   C
SELECT 
    `Order Date`,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY `Order Date`) AS running_total
FROM (
    SELECT 
        `Order Date`,
        SUM(`Price (INR)`) AS daily_revenue
    FROM Swiggy_Data
    GROUP BY `Order Date`
) t;

WITH revenue_cte AS (
SELECT 
`RESTAURANT NAME`,
SUM(`Price (INR)`) AS total_revenue,
RANK() OVER(ORDER BY SUM(`Price (INR)`)DESC) AS rank_position
FROM swiggy_data
GROUP BY `Restaurant Name`
)
SELECT *
FROM revenue_cte
WHERE rank_position =1;

WITH rating_counts
 AS (
SELECT 
   `Restaurant Name`,
   `Dish Name`,
   COUNT(*) AS rating_count
   from swiggy_data
   GROUP BY`Restaurant Name`,`Dish Name`
),

max_rating AS (
   SELECT 
   `Restaurant Name`,
   MAX(rating_count) AS max_rating_count
   FROM rating_counts
   GROUP BY `Restaurant Name`
   )
   
SELECT 
rc.`Restaurant Name`,
rc.`Dish Name`,
rc. rating_count
FROM rating_counts rc
JOIN max_rating mr
ON rc.`Restaurant Name` = mr.`Restaurant Name`
AND rc.rating_count = mr.max_rating_count;

CREATE VIEW monthly_revenue as (
SELECT `City` ,
  MONTH(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS month,
  SUM(`Price (INR)`) AS total_revenue
  FROM swiggy_data
  WHERE `City` = 'Bengaluru'
  GROUP BY `City`,MONTH(STR_TO_DATE(`Order Date`, '%d-%m-%Y'))
);
SELECT * FROM monthly_revenue;
DROP VIEW monthly_revenue;
SELECT COUNT(*) FROM swiggy_data;
SELECT SUM(`Price (INR)`) FROM swiggy_data;
SELECT `Price (INR)` FROM swiggy_data LIMIT 5;

CREATE INDEX idx_city 
ON swiggy_data(City(50));

CREATE INDEX idx_restaurant ON swiggy_data(`Restaurant Name`(50));

CREATE INDEX idx_date ON swiggy_data(`Order Date`(100));
SHOW INDEX FROM swiggy_data;

DELIMITER //
CREATE PROCEDURE get_top_restaurent(IN city_name VARCHAR(100))
BEGIN
SELECT 
`Restaurant Name`,
 SUM(`Price (INR)`) AS total_revenue
 FROM swiggy_data
 WHERE `City` = city_name 
 GROUP BY `Restaurant Name`
 ORDER  BY total_revenue DESC
 LIMIT 5;
END //
DELIMITER ;

CALL get_top_restaurent('Bengaluru');