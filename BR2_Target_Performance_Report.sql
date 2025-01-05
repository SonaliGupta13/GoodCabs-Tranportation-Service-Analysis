 /* Business Request- 2 : Monthly City-Level Trips Target Performance Report */
 
 WITH target_performance AS
 (
SELECT 
    c.city_name, 
    MONTHNAME(mt.month) AS month_name, 
    COUNT(ft.trip_id) AS actual_trips,
    mt.total_target_trips AS target_trips,
    CASE 
      WHEN count(ft.trip_id)>mt.total_target_trips THEN "Above Target"  
      ELSE "Below Target"
	END AS performance_status,
	CONCAT(
       ROUND(
             ((COUNT(ft.trip_id)-mt.total_target_trips)*100)/mt.total_target_trips,
		    2),
		 "%") AS '%_difference'
FROM 
    monthly_target_trips mt
JOIN 
    trips_db.dim_city c
    ON c.city_id = mt.city_id
JOIN 
    trips_db.fact_trips ft
    ON ft.city_id = mt.city_id
	AND MONTH(ft.date) = MONTH(mt.month)    
GROUP BY 
    c.city_name, MONTH(mt.month),mt.month,mt.total_target_trips
ORDER BY 
    c.city_name,MONTH(mt.month)
)
SELECT 
    *
FROM
    target_performance;
