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
SELECT SAM_PRODUCTS.Name, COUNT(DISTINCT PRODUCTS_IN_SHOPS.SHOPSID) as ShopNumber 
FROM SAM_PRODUCTS
LEFT JOIN PRODUCTS_IN_SHOPS 
ON PRODUCTS_IN_SHOPS.PRODUCTSID = SAM_PRODUCTS.ID
GROUP BY SAM_PRODUCTS.Name ;

