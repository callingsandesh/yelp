create table dim_review_count(
	business_id VARCHAR(255) primary key,
	review_count smallint,
	constraint fk_dim_review_count_fact_business_business_id
	foreign key(business_id) references fact_business(business_id)
)