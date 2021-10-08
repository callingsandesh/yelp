INSERT INTO fact_checkin
WITH cte_checkin AS (
SELECT
	business_id,
	unnest(string_to_array("date", ',')) as checkin
FROM raw_checkin
)
SELECT business_id, MIN(cast(checkin AS TIMESTAMP)) as first_checkin , MAX(cast(checkin AS TIMESTAMP)) AS last_checkin,COUNT(*) AS total_checkin
FROM cte_checkin
GROUP BY business_id