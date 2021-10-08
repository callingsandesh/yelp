INSERT into fact_business 
WITH CTE_all_business as (
	select  
	*,
	replace(replace(replace(cast(attributes::json->'WheelchairAccessible' as text),'True','1'),'False','0'),'"','') as WheelchairAccessible,
	replace(replace(replace(replace(replace(cast(attributes::json->'BusinessParking' as text),'"',''),'''','"'),'False','0'),'True','1'),'None','null')::json as BusinessParking,
	replace(replace(replace(cast(attributes::json->'BusinessAcceptsCreditCards' as text),'True','1'),'False','0'),'"','') as BusinessAcceptsCreditCards,
	replace(replace(replace(cast(attributes::json->'OutdoorSeating' as text),'True','1'),'False','0'),'"','') as OutdoorSeating,
	replace(cast(attributes::json->'NoiseLevel' as text),'"','') as NoiseLevel,
	replace(replace(replace(cast(attributes::json->'RestaurantsDelivery' as text),'True','1'),'False','0'),'"','') as RestaurantsDelivery,
	replace(cast(attributes::json->'WiFi' as text),'"','') as wifi,
	replace(cast(attributes::json->'RestaurantsAttire' as text),'"','') as RestaurantsAttire,
	replace(replace(replace(cast(attributes::json->'RestaurantsGoodForGroups' as text),'True','1'),'False','0'),'"','') as RestaurantsGoodForGroups,
	replace(replace(replace(cast(attributes::json->'Corkage' as text),'True','1'),'False','0'),'"','') as Corkage,
	replace(replace(replace(cast(attributes::json->'Caters' as text),'True','1'),'False','0'),'"','') as Caters,
	replace(replace(replace(cast(attributes::json->'RestaurantsReservations' as text),'True','1'),'False','0'),'"','') as RestaurantsReservations,
	replace(cast(attributes::json->'Alcohol' as text),'"','') as Alcohol,
	replace(replace(replace(cast(attributes::json->'GoodForKids' as text),'True','1'),'False','0'),'"','') as GoodForKids,
	replace(replace(cast(attributes::json->'RestaurantsPriceRange2' as text),'None','null'),'"','') as RestaurantsPriceRange2,
	replace(replace(replace(cast(attributes::json->'RestaurantsTakeOut' as text),'True','1'),'False','0'),'"','') as RestaurantsTakeOut,
	replace(replace(replace(replace(replace(cast(attributes::json->'Ambience' as text),'"',''),'''','"'),'False','0'),'True','1'),'None','null')::json as Ambience,
	replace(replace(replace(replace(replace(cast(attributes::json->'GoodForMeal' as text),'"',''),'''','"'),'False','0'),'True','1'),'None','null')::json as GoodForMeal,
	replace(replace(replace(cast(attributes::json->'BikeParking' as text),'True','1'),'False','0'),'"','') as BikeParking,
	replace(replace(cast(attributes::json->'BYOBCorkage' as text),'"',''),'''','') as BYOBCorkage,
	replace(replace(replace(cast(attributes::json->'HasTV' as text),'True','1'),'False','0'),'"','') as HasTV,
	replace(replace(replace(cast(attributes::json->'ByAppointmentOnly' as text),'True','1'),'False','0'),'"','') as ByAppointmentOnly,
	replace(replace(replace(cast(attributes::json->'HappyHour' as text),'True','1'),'False','0'),'"','') as HappyHour,
	replace(replace(replace(cast(attributes::json->'RestaurantsTableService' as text),'True','1'),'False','0'),'"','') as RestaurantsTableService,
	replace(replace(replace(cast(attributes::json->'DogsAllowed' as text),'True','1'),'False','0'),'"','') as DogsAllowed,
	replace(replace(cast(attributes::json->'Smoking' as text),'"',''),'''','') as Smoking,
	replace(replace(replace(replace(replace(cast(attributes::json->'Music' as text),'"',''),'''','"'),'False','0'),'True','1'),'None','null')::json as Music,
	replace(replace(replace(cast(attributes::json->'BYOB' as text),'True','1'),'False','0'),'"','') as BYOB,
	replace(replace(replace(cast(attributes::json->'CoatCheck' as text),'True','1'),'False','0'),'"','') as CoatCheck,
	replace(replace(replace(replace(replace(cast(attributes::json->'BestNights' as text),'"',''),'''','"'),'False','0'),'True','1'),'None','null')::json as BestNights,
	replace(replace(replace(cast(attributes::json->'GoodForDancing' as text),'True','1'),'False','0'),'"','') as GoodForDancing,
	replace(cast(hours::json->'Monday' as text),'"','') as hours_monday,
	replace(cast(hours::json->'Tuesday' as text),'"','') as hours_Tuesday,
	replace(cast(hours::json->'Wednesday' as text),'"','') as hours_Wednesday,
	replace(cast(hours::json->'Thursday' as text),'"','') as hours_Thursday,
	replace(cast(hours::json->'Friday' as text),'"','') as hours_Friday,
	replace(cast(hours::json->'Saturday' as text),'"','') as hours_Saturday,
	replace(cast(hours::json->'Sunday' as text),'"','') as hours_Sunday 
	
	from raw_business rb
	)
	select 
		business_id,
		name,
		address,
		city,
		state,
		postal_code,
		POINT(latitude::numeric,longitute::numeric),
		cast(stars as numeric),
		review_count::int ,
		is_open::boolean ,
		hours_monday,
		hours_tuesday,
		hours_wednesday,
		hours_thursday,
		hours_friday,
		hours_saturday,
		hours_sunday,
		
		case when WheelchairAccessible='None' then null
		else WheelchairAccessible::boolean
		end WheelchairAccessible,
		
		case when cast(BusinessParking->'garage' as text)='null' THEN null
		else cast(cast(BusinessParking->'garage' as text) as boolean)
		end as parking_garage,
		case when cast(BusinessParking->'street' as text)='null' then null
		else cast(cast(BusinessParking->'street' as text) as boolean) 
		end as parking_street,
		case when cast(BusinessParking->'validated' as text)='null' then null
		else cast(cast(BusinessParking->'validated' as text) as boolean) 
		end as parking_validated,
		case when cast(BusinessParking->'lot' as text)='null' then null
		else cast(cast(BusinessParking->'lot' as text)as boolean) 
		end as  parking_lot,
		case when cast(BusinessParking->'valet' as text)='null' then null
		else cast(cast(BusinessParking->'valet' as text)as boolean) 
		end as parking_valet,
		
		case when BusinessAcceptsCreditCards='None' then null
		else BusinessAcceptsCreditCards::boolean
		end BusinessAcceptsCreditCards,
		
		case when OutdoorSeating='None' then null
		else OutdoorSeating::boolean
		end OutdoorSeating,
		
		case when noiselevel='None' then null
		else noiselevel
		end as noiselevel,
		
		case when RestaurantsDelivery='None' then null
		else RestaurantsDelivery::boolean
		end RestaurantsDelivery,
		
		case when WiFi='None' then null
		else WiFi
		end as WiFi,
		

		case when RestaurantsAttire='None' then null
		else RestaurantsAttire
		end as RestaurantsAttire,
		
		case when RestaurantsGoodForGroups='None' then null
		else RestaurantsGoodForGroups::boolean
		end RestaurantsGoodForGroups,
		
		case when Corkage='None' then null
		else Corkage::boolean
		end Corkage,
		
		case when Caters='None' then null
		else Caters::boolean
		end Caters,
		
		case when RestaurantsReservations='None' then null
		else RestaurantsReservations::boolean
		end RestaurantsReservations,
		
		case when Alcohol='None' then null
		else Alcohol
		end as Alcohol,
		
		case when GoodForKids='None' then null
		else GoodForKids::boolean
		end GoodForKids,
		
		case when RestaurantsPriceRange2='null' then null
		else RestaurantsPriceRange2::int
		end RestaurantsPriceRange2,
		
		case when RestaurantsTakeOut='None' then null
		else RestaurantsTakeOut::boolean
		end RestaurantsTakeOut,
		
		
		case when cast(Ambience->'touristy' as text)='null' then null
	    else cast(cast(Ambience->'touristy' as text) as boolean)
	    end as ambience_touristy,
	    case when cast(Ambience->'intimate' as text)='null' then null
	    else cast(cast(Ambience->'intimate' as text) as boolean)
	    end as ambience_intimate,
	    case when cast(Ambience->'romantic' as text)='null' then null
	    else cast(cast(Ambience->'romantic' as text) as boolean)
	    end as ambience_romantic,
	    case when cast(Ambience->'hipster' as text)='null' then null
	    else cast(cast(Ambience->'hipster' as text) as boolean)
	    end as ambience_hipster,
	    case when cast(Ambience->'divey' as text)='null' then null
	    else cast(cast(Ambience->'divey' as text) as boolean)
	    end as ambience_divey,
	    case when cast(Ambience->'classy' as text)='null' then null
	    else cast(cast(Ambience->'classy' as text) as boolean)
	    end as ambience_classy,
	    case when cast(Ambience->'trendy' as text)='null' then null
	    else cast(cast(Ambience->'trendy' as text) as boolean)
	    end as ambience_trendy,
	    case when cast(Ambience->'upscale' as text)='null' then null
	    else cast(cast(Ambience->'upscale' as text) as boolean)
	    end as ambience_upscale,
	    case when cast(Ambience->'casual' as text)='null' then null
	    else cast(cast(Ambience->'casual' as text) as boolean)
	    end as ambience_casual,
		

	    case when cast(GoodForMeal->'dessert' as text)='null' then null
	    else cast(cast(GoodForMeal->'dessert' as text) as boolean)
	    end as GoodForMeal_dessert,
	    case when cast(GoodForMeal->'latenight' as text)='null' then null
	    else cast(cast(GoodForMeal->'latenight' as text) as boolean)
	    end as GoodForMeal_latenight,
	    case when cast(GoodForMeal->'lunch' as text)='null' then null
	    else cast(cast(GoodForMeal->'lunch' as text) as boolean)
	    end as GoodForMeal_lunch,
	    case when cast(GoodForMeal->'dinner' as text)='null' then null
	    else cast(cast(GoodForMeal->'dinner' as text) as boolean)
	    end as GoodForMeal_dinner,
	    case when cast(GoodForMeal->'brunch' as text)='null' then null
	    else cast(cast(GoodForMeal->'brunch' as text) as boolean)
	    end as GoodForMeal_brunch,
	    case when cast(GoodForMeal->'breakfast' as text)='null' then null
	    else cast(cast(GoodForMeal->'breakfast' as text) as boolean)
	    end as GoodForMeal_breakfast,
		
		
		
		case when BikeParking='None' then null
		else BikeParking::boolean
		end BikeParking,
		
		case when BYOBCorkage='None' then null
		when BYOBCorkage='no' then '0'::boolean
		when BYOBCorkage='uno' then '0'::boolean
		when BYOBCorkage='uyes_corkage' then '1'::boolean
		when BYOBCorkage='uyes_free' then '1'::boolean
		when BYOBCorkage='yes_corkage' then '1'::boolean
		WHEN BYOBCorkage='yes_free' then '1'::boolean
		end as BYOBCorkage,
		
		case when HasTV='None' then null
		else HasTV::boolean
		end HasTV,
		
		case when ByAppointmentOnly='None' then null
		else ByAppointmentOnly::boolean
		end ByAppointmentOnly,
		
		case when HappyHour='None' then null
		else HappyHour::boolean
		end HappyHour,
		
		case when RestaurantsTableService='None' then null
		else RestaurantsTableService::boolean
		end RestaurantsTableService,
		
		case when DogsAllowed='None' then null
		else DogsAllowed::boolean
		end DogsAllowed,
		
		case when smoking='None' then null
		when smoking='uoutdoor' then 'outdoor'
		when smoking='uno' then 'no'
		when smoking='uyes' then 'yes'
		end as smoking,
		cast(Music as text),
		
		case when BYOB='None' then null
		else BYOB::boolean
		end BYOB,
		
		case when CoatCheck='None' then null
		else CoatCheck::boolean
		end CoatCheck,
		
		cast(BestNights as text),
		
		case when GoodForDancing='None' then null
		else GoodForDancing::boolean
		end GoodForDancing
		
	from CTE_all_business
	
	