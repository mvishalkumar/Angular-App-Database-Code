CREATE OR REPLACE FUNCTION angularapi.ext_lov_uom_conversion()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT ITEM_NO, NO_OF_BASE_UNITS, BASE_UOM, NO_OF_CONVERSION_UNITS, CONV_UOM FROM V_UOM_CONVERTION ORDER BY BASE_UOM) row;
	 
return V_JSON; 
END $function$
;
