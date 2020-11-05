--query 5
-- part 1 select where maker = 'Samsung'
SELECT Name, ID 
FROM PRODUCTS 
WHERE maker = 'Samsung';
-- part2
WITH SAM_PRODUCTS AS 
(SELECT Name, ID 
FROM PRODUCTS 
WHERE maker = 'Samsung')
-- perform left join because we need even the products not sold by any shop
SELECT SAM_PRODUCTS.Name, COUNT(DISTINCT PRODUCTS_IN_SHOPS.SHOPSID) 
FROM SAM_PRODUCTS
LEFT JOIN PRODUCTS_IN_SHOPS 
ON PRODUCTS_IN_SHOPS.PRODUCTSID = SAM_PRODUCTS.ID
GROUP BY SAM_PRODUCTS.Name ;

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
AND YEAR(ORDERS.Date_time) <= 2020)
GROUP BY PRODUCTS_IN_ORDERS.SHOPSID) 

--finding shops with maximum revenue
SELECT S_ID, sName
FROM A1,SHOPS
WHERE REVENUE = (SELECT MAX(REVENUE) FROM A1)
AND S_ID = ID;

--query 9
-- finding purchases of every product for every month in every year
create view T1 as(
SELECT PRODUCTS_IN_ORDERS.PRODUCTSID, MONTH(ORDERS.Date_time) as mon, YEAR(ORDERS.Date_time)AS yr, SUM(PRODUCTS_IN_ORDERS.Quantity_In_Order) AS purchases
FROM PRODUCTS_IN_ORDERS
JOIN ORDERS ON PRODUCTS_IN_ORDERS.ORDERSID = ORDERS.ID
GROUP BY PRODUCTS_IN_ORDERS.PRODUCTSID, MONTH(ORDERS.Date_time), YEAR(ORDERS.Date_time))
go
-- finding products increasingly sold over the past 3 months
create view T2 AS(
SELECT  distinct A1.PRODUCTSID
FROM T1 A1, T1 A2, T1 A3
WHERE (A1.PRODUCTSID = A2.PRODUCTSID AND A3.PRODUCTSID = A2.PRODUCTSID)
AND( (A1.yr = A2.yr AND A2.yr = A3.yr AND (A2.mon - A1.mon) = 1 AND (A3.mon - A2.mon) =1 )
OR  (A1.yr = (A2.yr-1) AND A2.yr = A3.yr AND A1.mon = 12 AND A2.mon =1 AND A3.mon = 2 )
OR (A1.yr = A2.yr AND A2.yr = A3.yr-1 AND A1.mon=11 AND A2.mon = 12 AND A3.mon =1 ))
AND (A1.purchases > A2.purchases AND A2.purchases > A3.purchases)
)
go
-- finding product name for those products
SELECT Name 
From T2, PRODUCTS
WHERE T2.PRODUCTSID = PRODUCTS.ID;

