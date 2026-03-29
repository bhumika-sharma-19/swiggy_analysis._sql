# Swiggy Sales Data Analysis 🍽️

A comprehensive SQL-based analysis of Swiggy’s order data to uncover insights on top restaurants, dishes, cities, and revenue trends. This project demonstrates advanced SQL skills and database optimization techniques.

---

## Dataset
The dataset contains order-level details including:

- **Order Date**  
- **City & State**  
- **Restaurant Name & Location**  
- **Category & Dish Name**  
- **Price (INR)**  
- **Rating & Rating Count**

---

## Key Features & Skills Demonstrated
- **Data Modeling & Import:** Created normalized tables and imported raw Swiggy data ✅  
- **Advanced SQL Queries:** Used **JOINs, GROUP BY, WINDOW functions, CTEs, and Views** for deep analysis ✅  
- **Stored Procedures:** Dynamic queries to fetch top restaurants per city ✅  
- **Indexing:** Optimized query performance with indexes ✅  
- **Insights Generated:**  
  - Daily & cumulative revenue  
  - Top-performing restaurants and dishes  
  - City-wise order trends  
  - Customer behavior patterns  

---

## Example Queries
```sql
-- Total orders and revenue per city
SELECT City, COUNT(*) AS total_orders, SUM(`Price (INR)`) AS total_revenue
FROM Swiggy_Data
GROUP BY City;

-- Running total of daily revenue
SELECT `Order Date`,
       SUM(`Price (INR)`) AS daily_revenue,
       SUM(SUM(`Price (INR)`)) OVER (ORDER BY `Order Date`) AS running_total
FROM Swiggy_Data
GROUP BY `Order Date`;
