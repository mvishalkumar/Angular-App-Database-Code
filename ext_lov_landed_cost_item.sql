CREATE OR REPLACE FUNCTION angularapi.ext_lov_landed_cost_item()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT ITEM_NO,ITEM_DESCRIPTION ,ITEM_TYPE  FROM IM_ITEMS WHERE BACKFLUSH_PICKING_METHOD='NON_STOCK' AND INACTIVE ='N' ORDER BY ITEM_NO) row;
	 
return V_JSON; 
END $function$
;
