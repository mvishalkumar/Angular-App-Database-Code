CREATE OR REPLACE PROCEDURE angularapi.sp_ext_delete_po_header(p_po_no character varying)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
	v_id character;
BEGIN
	select po_no into v_id
	from PO_HEADER
	where po_no=p_po_no;

	delete from PO_LINE 
	where po_no=v_id;
	
	delete from PO_HEADER 
	where po_no=v_id;
end $procedure$
;
