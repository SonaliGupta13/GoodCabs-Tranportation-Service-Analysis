 /* Business Request- 3 : City-Level Repeat Passenger Trip Frequency Report */

WITH repeat_passenger AS (
    SELECT 
        c.city_name,
        rtp.trip_count,
        rtp.repeat_passenger_count AS rpc
    FROM 
        dim_repeat_trip_distribution rtp
    JOIN 
        dim_city c 
        ON c.city_id = rtp.city_id
)
SELECT 
    city_name,
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '2-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '2-Trips',
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '3-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '3-Trips',
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '4-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '4-Trips',
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '5-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '5-Trips',
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '6-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '6-Trips',
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '7-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '7-Trips',
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '8-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '8-Trips',
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '9-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '9-Trips',
    CONCAT(ROUND(SUM(CASE WHEN trip_count = '10-Trips' THEN rpc ELSE 0 END) 
                 / SUM(rpc) * 100, 2), "%") AS '10-Trips'
FROM 
    repeat_passenger
GROUP BY 
    city_name;
