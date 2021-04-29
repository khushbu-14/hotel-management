select Guest_id,guest_name , preferences, vip_status
from guest a
join preferences  b
on a.prf_id = b.prf_id;


select a.hotel_name,b.city, b.state, b.zipcode
from
hotel a
join
location b
on a.location_id = b.location_id;


select a.guest_id, guest_name,
sum(a.amount) as amount_paid from
room_booking a
join guest b
on a.guest_id = b.guest_id
group by a.guest_id,guest_name;


