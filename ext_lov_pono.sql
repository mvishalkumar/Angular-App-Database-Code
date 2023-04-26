CREATE OR REPLACE FUNCTION angularapi.ext_lov_pono()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
	
		select json_agg(row) into V_JSON 
		from (select po_no ,name,vendor_no from po_header ORDER BY po_no) row;
	 
return V_JSON; 
END $function$
;
