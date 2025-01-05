 /* Business Request- 5 : Identify Month with Highest Revenue for Each City */
    
WITH revenue_rank AS (
    SELECT 
        c.city_name,
        MONTHNAME(t.date) AS highest_revenue_month,
        SUM(t.fare_amount) AS revenue,
        SUM(SUM(t.fare_amount)) OVER (PARTITION BY c.city_name) AS city_total_revenue,
        RANK() OVER (PARTITION BY c.city_name ORDER BY SUM(t.fare_amount) DESC) AS ranking
    FROM 
        fact_trips t
    JOIN 
        dim_city c 
        ON t.city_id = c.city_id
    GROUP BY 
        c.city_name, 
        MONTHNAME(t.date)
)
SELECT 
    city_name, 
    highest_revenue_month, 
    revenue,
    CONCAT(
        ROUND((revenue * 100) / city_total_revenue, 2),"%"
    ) AS percentage_contribution
FROM 
    revenue_rank
WHERE 
    ranking = 1
ORDER BY 
    city_name;
