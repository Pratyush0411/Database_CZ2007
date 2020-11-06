--query 9
-- finding purchases of every product for every month in every year
WITH ProductsMonthlySales as(
SELECT PRODUCTS_IN_ORDERS.PRODUCTSID, MONTH(ORDERS.Date_time) as mon, YEAR(ORDERS.Date_time)AS yr, SUM(PRODUCTS_IN_ORDERS.Quantity_In_Order) AS purchases
FROM PRODUCTS_IN_ORDERS
JOIN ORDERS ON PRODUCTS_IN_ORDERS.ORDERSID = ORDERS.ID
GROUP BY PRODUCTS_IN_ORDERS.PRODUCTSID, MONTH(ORDERS.Date_time), YEAR(ORDERS.Date_time)
),

increasing AS(
SELECT  distinct A1.PRODUCTSID
FROM ProductsMonthlySales A1, ProductsMonthlySales A2, ProductsMonthlySales A3
WHERE (A1.PRODUCTSID = A2.PRODUCTSID AND A3.PRODUCTSID = A2.PRODUCTSID)
AND( (A1.yr = A2.yr AND A2.yr = A3.yr AND (A2.mon - A1.mon) = 1 AND (A3.mon - A2.mon) =1 )
OR  (A1.yr = (A2.yr-1) AND A2.yr = A3.yr AND A1.mon = 12 AND A2.mon =1 AND A3.mon = 2 )
OR (A1.yr = A2.yr AND A2.yr = A3.yr-1 AND A1.mon=11 AND A2.mon = 12 AND A3.mon =1 ))
AND (A1.purchases < A2.purchases AND A2.purchases < A3.purchases)
)
-- finding product name for those products
SELECT Name 
From increasing, PRODUCTS
WHERE increasing.PRODUCTSID = PRODUCTS.ID;


