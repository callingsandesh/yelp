INSERT INTO dim_total_review_words_count
WITH arranged AS
(
  SELECT 
  		business_id, 
  		UNNEST(STRING_TO_ARRAY(REGEXP_REPLACE(
    	REGEXP_SPLIT_TO_TABLE("text", ','), '[^\w\s]', '', 'g'), ' ')) as "word"
  FROM fact_review
) 
SELECT a.business_id, COUNT(a.word) as total_words,COUNT(distinct a.word)
FROM arranged a
WHERE LENGTH(word) > 0
GROUP BY a.business_id