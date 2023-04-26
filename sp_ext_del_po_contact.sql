CREATE OR REPLACE PROCEDURE angularapi.sp_ext_del_po_contact(p_vendor_no character varying, p_contact_id integer DEFAULT NULL::integer)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN
	delete from po_contacts
	where VENDOR_NO=p_vendor_no
	and CONTACT_ID=p_contact_id;

end;
$procedure$
;
