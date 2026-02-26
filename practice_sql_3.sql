-- what is the minimum host response time in hours for quest inquiries in Jan 2024?

select
min(f.response_time_hours) as min_response_time
from fct_guest_inquiries f
where f.inquiry_date >='2024-01-01' & f.inquiry_date <'2024-02-02';

-- For guest inquiries made in Jan 2024, what is the average host response time rounded to the nearest hour?

select
round(avg(f.response_time_hours)) as average_response_time
from fct_guest_inquiries f
where f.inquiry_date >='2024-01-01' and f.inquiry_date <='2024-01-31';

-- list the inquiry_id and response_time_hours for guest inquiries between jan 16 and jan 31, 2024 that took longer than 2 hours to respond. this breakdown will help pinpoint hosts with slower response times

select
f.inquiry_id,
f.response_time_hours
from fct>guest_inquiries f
where f.inquiry_date >='2024-01-16' and f.inquiry_date <= '2024-01-31' and f.response_time_hours >2;
