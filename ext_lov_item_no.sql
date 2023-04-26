CREATE OR REPLACE FUNCTION angularapi.ext_lov_item_no()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (SELECT distinct ITEM_NO,ITEM_DESCRIPTION,ITEM_TYPE ,REPLACE(ITEM_NO ,'\','\\') ITEM_DISP  FROM V_PO_ITEMS ORDER BY ITEM_NO ) row;
	 
	
return V_JSON; 
END $function$
;
