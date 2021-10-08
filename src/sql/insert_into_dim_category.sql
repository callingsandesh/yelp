INSERT into dim_category(name) 
WITH cte_categoty as (
SELECT 
	   business_id,
       ltrim( UNNEST(string_to_array(categories, ',')) , ' ') as category
FROM raw_business rb
)
SELECT COUNT(distinct category) FROM cte_categoty