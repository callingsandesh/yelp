create table fact_checkin(
	business_id VARCHAR(255) primary KEY,
	first_checkin TIMESTAMP,
	last_checkin TIMESTAMP,
	total_checkin INT,
	constraint fk_fact_checkin_fact_business_business_id
	foreign key(business_id) references fact_business(business_id)
)