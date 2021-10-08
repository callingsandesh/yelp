create table total_tip_count(
	business_id VARCHAR(255) primary KEY,
	total_tip_count smallint,
	
	constraint fk_total_tip_count_fact_business
	foreign key(business_id) references fact_business(business_id)
)