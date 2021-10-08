create table total_user_tip_count(
	user_id VARCHAR(255) primary key ,
	total_tip_count smallint,
	constraint fk_total_user_tip_count
	foreign key(user_id) references fact_user(user_id)
)