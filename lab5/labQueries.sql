-- query4
SELECT name FROM EMPLOYEES E, 
(SELECT TOP 1 C.EMPLOYEESID, AVG(datediff(second, C.Filed_date_time, C.Handled_date_time)) AS Latency 
FROM COMPLAINTS AS C                                          
GROUP BY C.EMPLOYEESID
ORDER BY Latency) AS L
WHERE E.ID = L.EMPLOYEESID;

-- query 4, steps
-- Create a temporary view for to find the employee ID with the shortest latency
WITH shortest_Latency AS
(
SELECT TOP 1 EMPLOYEESID, AVG(datediff(second, Filed_date_time, Handled_date_time)) AS latency
FROM COMPLAINTS
GROUP BY EMPLOYEESID
ORDER BY latency
)

-- Find the employee name
SELECT name 
FROM EMPLOYEES E, shortest_Latency S
WHERE E.ID = S.EMPLOYEESID;



--query 7
SELECT TOP 1 U.name AS userName, P.name AS productName FROM USERS AS U, ORDERS AS O, PRODUCTS_IN_ORDERS AS PIO, PRODUCTS P,
(SELECT TOP 1 USERID, COUNT(*) as numOfComplaints FROM COMPLAINTS
GROUP BY USERID
ORDER BY numOfComplaints DESC) AS TopComplainer
WHERE U.ID = TopComplainer.USERID AND U.ID = O.USERID AND PIO.ORDERSID = O.ID AND P.ID = PRODUCTSID
ORDER BY Price_In_Order DESC;

-- query 7, steps
-- view of the user complaints most
CREATE VIEW TopComplainer AS 
SELECT TOP 1 USERID, COUNT(*) as numOfComplaints FROM COMPLAINTS
GROUP BY USERID
ORDER BY numOfComplaints DESC;

-- view of the most expensive product purchased by top complainer
CREATE VIEW mostExpensivePurchased AS
SELECT TOP 1 PRODUCTSID FROM PRODUCTS_IN_ORDERS, TopComplainer WHERE ORDERSID = (SELECT ID FROM ORDERS WHERE USERID = TopComplainer.USERID)
ORDER BY Price_In_Order DESC;

-- Select the name of the top complainer and the most expensive purchased-product name 
SELECT U.name AS userName, P.name AS productName FROM USERS AS U, PRODUCTS AS P, mostExpensivePurchased AS MEP, TopComplainer AS TP
WHERE U.ID = TP.USERID AND P.ID = MEP.PRODUCTSID;


