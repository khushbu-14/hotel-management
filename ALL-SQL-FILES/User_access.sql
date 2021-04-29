
---------------------------------------------------FrontDesk-----------------------------

drop user frontdesk;
create user frontdesk identified by Database1234#;
grant connect to frontdesk;
grant create session to frontdesk;
grant unlimited tablespace to frontdesk;
grant select,insert,update on ADMIN.guest to frontdesk;
grant select,insert,update on ADMIN.room_booking to frontdesk;
grant select,insert,update on ADMIN.preferences to frontdesk;
grant select,insert,update on ADMIN.room to frontdesk;
grant select on ADMIN.room_type to frontdesk;
grant select on ADMIN.amenity to frontdesk;
grant execute on get_booking_amount to frontdesk;
grant execute on insrt_room_booking to frontdesk;
GRANT SELECT ON guest_discount to frontdesk; 
GRANT SELECT ON hotel_rates to frontdesk; 

----------------------------------------------------HouseKeeping----------------------------
drop user housekeeping;
create user housekeeping identified by Database1234#;
grant connect,resource to housekeeping;
grant create session to housekeeping;
grant unlimited tablespace to housekeeping;
grant select,insert on admin.house_keeping to housekeeping;
grant select,insert on admin.room_status to housekeeping;
grant select,insert on admin.room to housekeeping;
grant execute on insrt_house_keeping to housekeeping;

------------------------------------------------------Manager--------------------------------
drop user manager;
create user manager identified by Database1234#;
grant connect,resource to manager;
grant create session to manager;
grant unlimited tablespace to manager;
grant select,insert,update on admin.guest to manager;
grant select,insert,update on admin.annual_rate to manager;
grant select,insert,update on admin.staff to manager;
grant select,insert,update on admin.member to manager;
grant select,insert,update on admin.preferences to manager;
grant select,insert,update on admin.check_in to manager;
grant select,insert,update on admin.discount to manager;
grant select,insert,update on admin.department to manager;
grant select on admin.designation to manager;
grant select,insert,update on admin.amenity to manager;

