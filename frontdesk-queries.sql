set serveroutput on;
-- view sister properties
select * from admin.sister_property;

select * from admin.guest_frontdesk;

-- login as front desk
-- excute below query
select * from admin.room_booking;

EXECUTE admin.insrt_room_booking(31,3,3,3,13,1,1,2,TO_DATE('2021/04/24', 'YYYY-MM-DD'),TO_DATE('2021/05/03', 'YYYY-MM-DD'));