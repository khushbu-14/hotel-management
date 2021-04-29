set serveroutput on;

create or replace 
procedure  update_email(new_email in varchar2, id1 in varchar2)
as
begin
dbms_output.put_line('Updating Email');
update guest_db 
set  email= new_email  where guest_id = id1;
commit;
dbms_output.put_line('Update Complete');
end;
/

exec update_email('johnny@gmail.com',8);
exec update_email('abc@gmail.com',2);


--select * from guest_db;

set serveroutput on;

create or replace 
procedure  delete_location
as
begin
dbms_output.put_line('Deleting Booking');
delete from Location_DB
where location_id not in (select location_id from hotel_db);
commit;
dbms_output.put_line('Delete Complete');
end;
/



insert into location_db values(90,'sdds','dcs',76765);
exec delete_location;

--select * from location_db;


