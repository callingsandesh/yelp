create table fact_tip(
	user_id VARCHAR(255),
	business_id VARCHAR(255),
	text TEXT,
	date TEXT,
	compliment_count VARCHAR(255),
	
	constraint fk_fact_tip_fact_fact_user_user_id
	foreign KEY(user_id) references fact_user(user_id),
	
	constraint fk_fact_tip_fact_business_business_id
	foreign key(business_id) references fact_business(business_id)
	
)