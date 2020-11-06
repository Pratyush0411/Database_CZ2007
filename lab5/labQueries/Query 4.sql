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
