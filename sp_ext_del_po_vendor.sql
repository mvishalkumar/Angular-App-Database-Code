CREATE OR REPLACE PROCEDURE angularapi.sp_ext_del_po_vendor(p_vendor_no character varying)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN
	delete from po_vendors
	where vendor_no=p_vendor_no;

end;
$procedure$
;
