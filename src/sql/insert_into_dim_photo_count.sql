INSERT INTO dim_photo_count
SELECT business_id, count(*) as total_photos
    FROM raw_photo rp 
    GROUP BY business_id 
    ORDER BY total_photos DESC