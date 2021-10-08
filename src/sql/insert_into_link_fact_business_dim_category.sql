insert into link_fact_business_dim_category
WITH cte_categoty as (
select 
	   business_id,
       unnest(string_to_array(categories, ',')) as category
from raw_business rb
)
select business_id , id from cte_categoty
inner join dim_category d
on cte_categoty.category = d.name