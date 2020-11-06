--query 6
--finding revenue of all the shops in August 2020
--used . operator for using distinguishing common attributes
-- used IN operator to find orders in August 2020
WITH A1 AS(
SELECT PRODUCTS_IN_ORDERS.SHOPSID as S_ID,SUM(PRODUCTS_IN_ORDERS.Price_In_Order*PRODUCTS_IN_ORDERS.Quantity_In_Order) AS REVENUE
FROM PRODUCTS_IN_ORDERS 
WHERE PRODUCTS_IN_ORDERS.ORDERSID IN(SELECT ORDERS.ID
FROM ORDERS
WHERE MONTH(ORDERS.Date_time) = 8
AND YEAR(ORDERS.Date_time) = 2020)
GROUP BY PRODUCTS_IN_ORDERS.SHOPSID) 
--finding shops with maximum revenue
SELECT S_ID, sName
FROM A1,SHOPS
WHERE REVENUE = (SELECT MAX(REVENUE) FROM A1)
AND S_ID = ID;

