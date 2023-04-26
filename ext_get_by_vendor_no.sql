CREATE OR REPLACE FUNCTION angularapi.ext_get_by_vendor_no(p_vendor_no character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
	v_JSON json; 
begin
select json_agg(row)  into v_json
from ( SELECT * FROM po_vendors WHERE vendor_no=p_vendor_no) row;
return V_JSON; 
END $function$
;
