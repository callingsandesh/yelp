INSERT INTO dim_review_count
SELECT 
    business_id ,
    count(*) AS  review_count
FROM fact_review fr 
GROUP BY business_id
ORDER BY review_count desc