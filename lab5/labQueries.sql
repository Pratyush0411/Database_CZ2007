-- query4
SELECT name FROM EMPLOYEES E, 
(SELECT TOP 1 C.EMPLOYEESID, AVG(datediff(second, C.Filed_date_time, C.Handled_date_time)) AS Latency 
FROM COMPLAINTS AS C                                          
GROUP BY C.EMPLOYEESID
ORDER BY Latency) AS L
WHERE E.ID = L.EMPLOYEESID;



--query 7
SELECT TOP 1 U.name AS userName, P.name AS productName FROM USERS AS U, ORDERS AS O, PRODUCTS_IN_ORDERS AS PIO, PRODUCTS P,
(SELECT TOP 1 USERID, COUNT(*) as numOfComplaints FROM COMPLAINTS
GROUP BY USERID
ORDER BY numOfComplaints DESC) AS TopComplainer
WHERE U.ID = TopComplainer.USERID AND U.ID = O.USERID AND PIO.ORDERSID = O.ID AND P.ID = PRODUCTSID
ORDER BY Price_In_Order DESC;


