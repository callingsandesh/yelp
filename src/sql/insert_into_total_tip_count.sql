INSERT INTO total_tip_count 
SELECT 
    business_id,
    count(*) FROM fact_tip
GROUP BY business_id
ORDER BY count DESC