CREATE OR REPLACE FUNCTION angularapi.fill_purchase_shipto_add_info()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT SHIPPING_NAME, SHIPPING_STREET,SHIPPING_CITY,SHIPPING_STATE_CODE,SHIPPING_POSTAL_CODE,SHIPPING_COUNTRY,SHIPPING_PHONE,SHIPPING_FAX,SHIPPING_EMAIL FROM V_VENDOR_SHIPTO_ADDRESS) row;
	 
return V_JSON; 
END $function$
;