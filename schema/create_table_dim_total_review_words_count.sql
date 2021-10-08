create table dim_total_review_words_count(
	business_id VARCHAR(255) primary KEY,
	total_review_words_count BIGINT,
	total_review_distinct_words_count BIGINT,
	constraint k_dim_total_review_words_count_business_id
	foreign KEY(business_id) references fact_business(business_id)
)