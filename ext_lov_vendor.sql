CREATE OR REPLACE FUNCTION angularapi.ext_lov_vendor()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (select VENDOR_NO,NAME,street,city,state_code,postal_code,country,phone,fax,email,TERMS_CODE
		from PO_VENDORS
		WHERE COALESCE(NULLIF(INACTIVE,''),'N')='N' ORDER BY VENDOR_NO) row;
	
return V_JSON; 
END $function$
;
