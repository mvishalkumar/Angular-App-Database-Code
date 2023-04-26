CREATE OR REPLACE PROCEDURE angularapi.sp_ext_del_po_line(p_po_no character varying, p_line_no integer DEFAULT NULL::integer)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN
	delete from PO_LINE
	where PO_NO=p_po_no
	and LINE_NO=p_line_no;

end;
$procedure$
;
