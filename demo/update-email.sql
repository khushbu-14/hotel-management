set serveroutput on;

declare 
    g_id number;
    g_email varchar2(255) := 'NARENDRA.MODI@GMAIL.COM';
begin
        dbms_output.put_line('----------------------------------------------------------------------------------');
        
        select guest_id into g_id from guest where email = g_email;
        print_guest(g_id);
        dbms_output.put_line('----------------------------------------------------------------------------------');

        dbms_output.put_line('Call update_email() procedure to update email');

        update_email('MODI@GOV.IN', g_id);

        dbms_output.put_line('----------------------------------------------------------------------------------');
        print_guest(g_id);

        dbms_output.put_line('----------------------------------------------------------------------------------');
    end;
/

--select * from guest where guest_id = 1;
--select * from guest_discount where mem_type = 'SILVER';

-- revert data
--select * from guest;
--execute insrt_member('SILVER',TO_DATE('2022/05/22 23:59:59', 'yyyy/mm/dd hh24:mi:ss'),1);
--update guest set mem_id = 4 where guest_id = 1;
