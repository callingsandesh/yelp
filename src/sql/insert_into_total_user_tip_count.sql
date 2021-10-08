INSERT INTO total_user_tip_count
SELECT 
    user_id,
    count(*) as total_tip_count
FROM fact_tip
GROUP BY user_id
ORDER BY total_tip_count DESC