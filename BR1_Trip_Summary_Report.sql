 /* Business Request- 1 : City Level Fare and Trip Summary Report */
 
WITH trip_summary AS
(
SELECT 
    city_name,
    COUNT(trip_id) AS `total_trips`,
    ROUND(SUM(fare_amount) / SUM(distance_travelled_km), 2) AS `avg_fare_per_km`,
    ROUND(SUM(fare_amount) / COUNT(trip_id), 2) AS `avg_fare_per_trip`,
    CONCAT(ROUND(COUNT(trip_id) * 100 / (SELECT COUNT(*) FROM fact_trips), 2),
		'%') AS `%_contribution_of_total_trips`
FROM
    fact_trips
JOIN 
    dim_city 
	ON fact_trips.city_id = dim_city.city_id
GROUP BY 
     city_name
)
SELECT 
    *
FROM
    trip_summary;
   

