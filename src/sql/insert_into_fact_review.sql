INSERT INTO fact_review
SELECT 
	review_id ,
	user_id ,
	business_id ,
	stars ,
	useful ,
	funny ,
	cool,
	text ,
	date 
	 
FROM raw_review rr 