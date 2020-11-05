-- query 1
SELECT AVG(Price) as AvgPrice
FROM PRICE_HISTORY, PRODUCTS_IN_SHOPS, PRODUCTS p
WHERE Start_date >= '08-01-2020' AND End_date <= '08-31-2020'
   AND PRICE_HISTORY.ID = PRODUCTS_IN_SHOPS.ID
   AND PRODUCTS_IN_SHOPS.PRODUCTSID = p.ID
   AND p.Name LIKE 'iPhone Xs%';

-- query 2
SELECT pName, oID, sName, ROUND(AVG(Rating),2) AS Average_Rating
FROM PRODUCTS-IN-ORDERS PIO, Feedback F
WHERE PIO.pName IN 
    	(SELECT pName
	 FROM Feedback 
	 WHERE Rating = 5 
	 AND Date-time >= '2020-08-01' AND Date-time < ='2020-08-31'
    	 GROUP BY pName 
	 HAVING COUNT(Rating) >= 100) 
GROUP BY PIO.pName ORDER BY Average_Rating DESC;

-- query 3
SELECT AVG(ABS(DATEDIFF(day, Date_time, Delivery_Date))) AS Average_DeliveryTime
FROM (SELECT  p.Name, pio.Delivery_Date, o.Date_time
	  FROM PRODUCTS_IN_ORDERS pio, PRODUCTS p, ORDERS o
	  WHERE pio.PRODUCTSID = p.ID and 
	  pio.ORDERSID = o.ID and
	  pio.Status = 'Delivered' and
	  o.Date_time >='2020-06-01' and
	  o.Date_time <= '2020-06-30')
	  AS ProductOrder;

-- query 4
-- Create a temporary view called minLatency to find the employee ID with the minumum latency
WITH minLatency AS
(
SELECT TOP 1 EMPLOYEESID, AVG(datediff(second, Filed_date_time, Handled_date_time)) AS latency
FROM COMPLAINTS
GROUP BY EMPLOYEESID
)
-- Find the employee name from table 
SELECT name
FROM EMPLOYEES, minLatency
WHERE EMPLOYEES.ID = minLatency.EMPLOYEESID;

--query 5
WITH SAM_PRODUCTS AS 
(SELECT Name, ID 
FROM PRODUCTS 
WHERE maker = 'Samsung')
SELECT SAM_PRODUCTS.Name, COUNT(PRODUCTS_IN_SHOPS.SHOPSID) 
FROM SAM_PRODUCTS
LEFT JOIN PRODUCTS_IN_SHOPS 
ON PRODUCTS_IN_SHOPS.PRODUCTSID = SAM_PRODUCTS.ID
GROUP BY SAM_PRODUCTS.Name ;

--query 6
--finding revenue of all the shops in August 2020
--used . operator for using distinguishing common attributes
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

--query 7
-- view of the user complaints most
WITH TopComplainer AS 
(
SELECT TOP 1 USERID, COUNT(*) as numOfComplaints FROM COMPLAINTS
GROUP BY USERID
ORDER BY numOfComplaints DESC
),
-- view of the most expensive product purchased by top complainer
mostExpensivePurchased AS
(
SELECT TOP 1 PRODUCTSID FROM PRODUCTS_IN_ORDERS, TopComplainer WHERE ORDERSID = (SELECT ID FROM ORDERS WHERE USERID = TopComplainer.USERID)
ORDER BY Price_In_Order DESC
)
-- Select the name of the top complainer and the most expensive purchased-product name 
SELECT U.name AS userName, P.name AS productName FROM USERS AS U, PRODUCTS AS P, mostExpensivePurchased AS MEP, TopComplainer AS TP
WHERE U.ID = TP.USERID AND P.ID = MEP.PRODUCTSID;

--query 8
SELECT TOP(5) WITH TIES Name, sum(Quantity_In_Order) as TotalQty
FROM ORDERS o, PRODUCTS_IN_ORDERS pio, PRODUCTS p
WHERE pio.ORDERSID = o.ID AND pio.PRODUCTSID = p.ID
AND o.Date_time >= '2020-08-01'
AND o.Date_time <= '2020-08-31'
GROUP BY Name
HAVING COUNT(DISTINCT o.USERID) < (SELECT COUNT(DISTINCT ID) FROM users)
ORDER BY SUM(pio.Quantity_In_Order) DESC

--query 9
create view T1 as(
SELECT PRODUCTS_IN_ORDERS.PRODUCTSID, MONTH(ORDERS.Date_time) as mon, YEAR(ORDERS.Date_time)AS yr, SUM(PRODUCTS_IN_ORDERS.Quantity_In_Order) AS purchases
FROM PRODUCTS_IN_ORDERS
JOIN ORDERS ON PRODUCTS_IN_ORDERS.ORDERSID = ORDERS.ID
GROUP BY PRODUCTS_IN_ORDERS.PRODUCTSID, MONTH(ORDERS.Date_time), YEAR(ORDERS.Date_time))
go
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
SELECT Name 
From T2, PRODUCTS
WHERE T2.PRODUCTSID = PRODUCTS.ID;
