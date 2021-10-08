INSERT INTO fact_user
	SELECT
		user_id,
		name,
		review_count::INT,
		yelping_since::TIMESTAMP,
		useful::INT,
		funny::INT,
		cool::INT,
		fans::INT,
		array_length(regexp_split_to_array(friends, ','), 1) as friends_count,
		average_stars::NUMERIC,
		compliment_hot::INT,
		compliment_more::INT,
		compliment_profile::INT,
		compliment_cute::INT,
		compliment_list::INT,
		comliment_note::INT,
		compliment_plain::INT,
		compliment_cool::INT,
		compliment_funny::INT,
		compliment_writer::INT,
		compliment_photos::INT
	FROM raw_user