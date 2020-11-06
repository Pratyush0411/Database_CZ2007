--Addition query
--Find the 5 lowest complaint rate products on the whole website. (i.e., if there are 10 items of a product purchased and 1 of them is complained, the rate for
--this product is 10%)
WITH TAB1 AS(
select PRODUCTS_IN_ORDERS.PRODUCTSID, COUNT(COMPLAINTS_ON_ORDERS.ORDERSID) AS no_complaints
from PRODUCTS_IN_ORDERS JOIN COMPLAINTS_ON_ORDERS ON PRODUCTS_IN_ORDERS.ORDERSID = COMPLAINTS_ON_ORDERS.ORDERSID
group by PRODUCTS_IN_ORDERS.PRODUCTSID
),

TAB2 AS(
select PRODUCTS_IN_ORDERS.PRODUCTSID, COUNT (PRODUCTS_IN_ORDERS.PRODUCTSID) as order_numbers
from PRODUCTS_IN_ORDERS
GROUP BY PRODUCTS_IN_ORDERS.PRODUCTSID
)

SELECT TOP 5 WITH TIES TAB1.PRODUCTSID, (cast(round(no_complaints*100/order_numbers,2) as numeric(36,2) )) AS rate
FROM TAB1,TAB2 
WHERE TAB1.PRODUCTSID = TAB2.PRODUCTSID
order by RATE;
*/