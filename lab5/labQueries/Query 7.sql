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
