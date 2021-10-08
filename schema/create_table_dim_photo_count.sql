create table dim_photo_count(
	business_id VARCHAR(255),
	total_photos smallint,
	
	constraint fk_dim_photo_count_fact_business_total_photos
	foreign key(business_id) references fact_business(business_id)
	
)