/* Business Request- 6 : Repeat Passenger Rate Analysis */
    
    SELECT 
    c.city_name,
    MONTHNAME(ps.month) AS month,
    ps.total_passengers,
    ps.repeat_passengers,
    ROUND((ps.repeat_passengers * 100) / ps.total_passengers, 2) AS 'monthly_repeat_passenger_rate(%)',
    ROUND(
        SUM(ps.repeat_passengers) OVER (PARTITION BY c.city_name) * 100 / 
        SUM(ps.total_passengers) OVER (PARTITION BY c.city_name),2
	) AS 'city_repeat_passenger_rate(%)'
FROM 
    dim_city c
JOIN 
    fact_passenger_summary ps 
    ON c.city_id = ps.city_id
GROUP BY 
    c.city_name, 
    ps.month, 
    ps.total_passengers, 
    ps.repeat_passengers
ORDER BY 
    c.city_name, 
    ps.month;
