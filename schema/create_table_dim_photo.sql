create table dim_photo(
	photo_id VARCHAR(255),
	business_id VARCHAR(255),
	caption text,
	label VARCHAR (255),
	
	constraint fk_dim_photo_fact_business_business_id
	foreign KEY(business_id) references fact_business(business_id)
)