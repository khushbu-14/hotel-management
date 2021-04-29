set serveroutput on;

begin
        dbms_output.put_line('----------------------------------------------------------');
        dbms_output.put_line('Guest with silver membership');
        print_guest(1);
        dbms_output.put_line('----------------------------------------------------------');
end;
/

begin
        dbms_output.put_line('----------------------------------------------------------------------------------');
        dbms_output.put_line('Delete SILVER membership from member table using remove_member stored procedure');
        dbms_output.put_line('----------------------------------------------------------------------------------');
    end;
/
delete from member where mem_type = 'SILVER';

begin
    dbms_output.put_line('----------------------------------------------------------------------------------');
        print_guest(1);
    dbms_output.put_line('----------------------------------------------------------------------------------');
end;
/

--select * from guest where guest_id = 1;
--select * from guest_discount where mem_type = 'SILVER';

-- revert data
--select * from guest;
--execute insrt_member('SILVER',TO_DATE('2022/05/22 23:59:59', 'yyyy/mm/dd hh24:mi:ss'),1);
--update guest set mem_id = 4 where guest_id = 1;
