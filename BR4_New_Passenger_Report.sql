 /* Business Request- 4 : Identify Cities with Highest and Lowest Total New Passengers */

WITH new_passenger_rank AS (
    -- Assign ranks based on total new passengers (descending and ascending) --
    SELECT 
        c.city_name,
        SUM(ps.new_passengers) AS total_new_passenger,
        ROW_NUMBER() OVER (ORDER BY SUM(ps.new_passengers) DESC) AS desc_rank,
        ROW_NUMBER() OVER (ORDER BY SUM(ps.new_passengers) ASC) AS asc_rank
    FROM 
        dim_city c
    JOIN 
        fact_passenger_summary ps
        ON c.city_id = ps.city_id
    GROUP BY 
        c.city_name
),
new_city_category AS (
    -- Categorize cities as Top 3 or Bottom 3 --
    SELECT 
        city_name,
        total_new_passenger,
        CASE 
            WHEN desc_rank <= 3 THEN 'Top 3'
            WHEN asc_rank <= 3 THEN 'Bottom 3'
            ELSE NULL
        END AS city_category
    FROM 
        new_passenger_rank
)
SELECT 
    city_name, 
    total_new_passenger, 
    city_category
FROM 
    new_city_category
WHERE 
    city_category IS NOT NULL
ORDER BY 
    total_new_passenger DESC;
