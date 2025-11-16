SELECT*
FROM case_study2.car.sales_car
LIMIT 10;

--- Revenue and discount price
 SELECT seller,
        SUM(sellingprice) AS revenue,
        SUM(mmr) AS promotional_price
 FROM case_study2.car.sales_car
 group by seller;

 ---Opening and closing time for dealership(seller)
 SELECT MIN(TO_CHAR(TO_TIMESTAMP(SALEDATE, 'DY MON DD YYYY HH24:MI:SS'), 'HH24:MI:SS')) as opening_time,
        MAX(TO_CHAR(TO_TIMESTAMP(SALEDATE, 'DY MON DD YYYY HH24:MI:SS'), 'HH24:MI:SS'))as closing_time
FROM case_study2.car.sales_car;

---Which colour have the highest revenue and made most sales 
SELECT  color,
       SUM(sellingprice) AS revenue,
       COUNT(seller) AS Most_sold
FROM case_study2.car.sales_car
GROUP BY Color;

---
SELECT SUM(mmr) AS promotional_price,
        transmission
FROM  case_study2.car.sales_car     
GROUP BY transmission;


 ----------------------------------------------------------------------------------------------------------------------------------------------------
 ---
SELECT  make,
        model,
        body,
        odometer,
        seller AS dealership,

CASE 
WHEN odometer BETWEEN 70000 AND 100000 THEN 'High'
WHEN Odometer BETWEEN 20000 AND 69000 THEN 'Medium'
WHEN odometer BETWEEN 0 AND 19900 THEN 'Low'
ELSE  'Damged_engine'
END AS Kilometers_Used,

saledate,
 --- Re-arrangement of saledate
    TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') AS ts_value,

    -- Date and time
    CAST(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') AS DATE) AS only_date,
    TO_CHAR(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'HH24:MI:SS') AS only_time,

    --- Individual date parts
    EXTRACT(YEAR   FROM TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS year_val,
    EXTRACT(MONTH  FROM TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS month_val,
    EXTRACT(DAY    FROM TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS day_val,
    RTRIM(TO_CHAR(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'),'MON')) AS month_name,
    --- Day name full & short
    RTRIM(TO_CHAR(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'DAY')) AS day_name,
    TO_CHAR(TO_TIMESTAMP(SALEDATE, 'DY MON DD YYYY HH24:MI:SS'), 'DY') AS day_short,

    --- Time parts
    EXTRACT(HOUR   FROM TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS hour_val,
    EXTRACT(MINUTE FROM TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS minute_val,
    EXTRACT(SECOND FROM TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS second_val,
    
CASE
WHEN only_time BETWEEN '00:00:00' AND '06:59:59' THEN  '01.Early_morming'
WHEN only_time BETWEEN '07:00:00' AND '11:59:59' THEN  '02.Morning'
WHEN only_time BETWEEN '12:00:00' AND '15:59:59' THEN  '03.Afternoon'
WHEN only_time BETWEEN '16:00:00' AND '19:59:59' THEN  '04.Evening'
WHEN only_time >= '20:00:00' THEN 'Night'
END AS time_interval,
CASE
WHEN TO_CHAR(TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'DY') IN ('Sat' , 'Sun') THEN 'Weekend'
ELSE 'Weekday'
END AS day_classification,


-----Categorial Data
---Number of sales
  make,
 COUNT(seller) AS number_of_sales,


---Integer Data
        SUM(sellingprice) AS revenue,

        SUM(mmr) AS promotional_price,

FROM case_study2.car.sales_car 
GROUP BY All;

