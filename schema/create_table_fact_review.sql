create table fact_review(
	review_id VARCHAR(255) primary KEY,
	user_id VARCHAR(255) ,
	business_id VARCHAR(255),
	stars NUMERIC,
	date DATE,
	text text,
	usefull INT,
	funny INT,
	cool INT,
	
	constraint fk_review_fact_user_user_id 
	foreign KEY(user_id) references fact_user(user_id),
	
	constraint fk_review_review_fact_business_business_id
	foreign KEY(business_id) references fact_business(business_id)
)