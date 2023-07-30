-- Daily Pizza Analysis
-- This query calculates the following metrics for each day of the week:
-- Number of pizzas sold
-- Total revenue
-- Maximum order price
-- Minimum order price
-- Average order price

SELECT
  DATENAME(WEEKDAY, order_date) AS Days,
  COUNT(quantity) AS NumPizza,
  ROUND(SUM(total_price),2) AS TotalRevenue,
  ROUND(MAX(total_price),2) AS MaxPrice,
  MIN(total_price) AS MinPrice,
  ROUND(AVG(total_price),2) AS AvgPrice,
  GROUPING(DATENAME(WEEKDAY, order_date)) AS Grouping
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY TotalRevenue DESC

-- Busiest day and time
-- This query calculates the busiest day and time of day for pizza sales.

SELECT
  DATENAME(WEEKDAY, order_date) AS Days,
  DATEPART(HOUR, order_time) AS Hours,
  COUNT(quantity) AS NumPizza
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY
  DATENAME(WEEKDAY, order_date),
  DATEPART(HOUR, order_time)
ORDER BY
  COUNT(quantity) DESC

-- Quantity of pizza made during peak hour
-- This query calculates the quantity of pizza made during the busiest hour of the day.

SELECT
  DATEPART(HOUR, order_time) AS Hours,
  SUM(quantity) AS NumPizza
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY DATEPART(HOUR, order_time)
ORDER BY SUM(quantity) DESC

-- Average order value
-- This query calculates the average order value for all orders.

SELECT
  ROUND(AVG(total_price),2) AS AvgPrice
FROM [dbo].[Data Model - Pizza Sales]

-- Best and worst selling pizza
-- This query calculates the best and worst selling pizzas.

SELECT
  pizza_name AS PizzaName,
  SUM(quantity) AS TotalPizza
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY pizza_name
ORDER BY TotalPizza DESC

-- How well are we utilizing our seating capacity?
-- This query calculates the table turnover rate per day.

DECLARE @TotalTable INT = 15;
DECLARE @SeatPerTable INT = 4;
DECLARE @AvailableSeats INT = @TotalTable * @SeatPerTable;

DECLARE @OccupiedSeats INT;
SELECT @OccupiedSeats = COUNT(*) FROM [dbo].[Data Model - Pizza Sales] 
WHERE MONTH(order_date) = '1' AND YEAR(order_date) = '2015'

DECLARE @TableTurnOverRate FLOAT = ROUND(CAST(@OccupiedSeats AS FLOAT) / @AvailableSeats ,2);
DECLARE @TableTurnOverDay FLOAT = ROUND(@TableTurnOverRate / 30 ,2)
SELECT @TableTurnOverDay AS TableTurnOverDay

-- 

