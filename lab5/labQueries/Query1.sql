-- record with start date: 08-02-2020 and end date : 09-11-2020 is also counted assuming the timestamps do not overlap
SELECT AVG(Price) as AvgPrice
FROM PRICE_HISTORY, PRODUCTS_IN_SHOPS, PRODUCTS p
WHERE  Start_date <= '08-31-2020' AND End_date >= '08-01-2020'
	AND PRICE_HISTORY.PRODUCTS_IN_SHOPSID = PRODUCTS_IN_SHOPS.ID
   AND PRODUCTS_IN_SHOPS.PRODUCTSID = p.ID
   AND p.Name LIKE 'iPhone Xs%';

