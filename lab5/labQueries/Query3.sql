SELECT AVG(ABS(DATEDIFF(day, Date_time, Delivery_Date))) AS Average_DeliveryTime
FROM (SELECT  p.Name, pio.Delivery_Date, o.Date_time
	  FROM PRODUCTS_IN_ORDERS pio, PRODUCTS p, ORDERS o
	  WHERE pio.PRODUCTSID = p.ID and 
	  pio.ORDERSID = o.ID and
	  pio.Status = 'Delivered' and
	  o.Date_time >='2020-06-01' and
	  o.Date_time <= '2020-06-30')
	  AS ProductOrder;
