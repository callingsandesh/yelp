insert into dim_elite
SELECT 
	   user_id,
       unnest(string_to_array(elite, ',')) as elite_year
from (
--data cleaning 
select user_id,replace(elite,'20,20','2020') as elite
from raw_user ru 
)r