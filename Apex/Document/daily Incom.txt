select   ADVANCED_PAID
from     BOOKING_M 
where    to_char(booking_m_date,'DD-MON-RRRR') = to_char(sysdate,'DD-MON-RRRR') ; 


select   NET_PAY_BILL
from     BILL 
where    to_char(BILL_DATE,'DD-MON-RRRR') = to_char(sysdate,'DD-MON-RRRR')




create or replace view total_Daily_income_view
as
select   ADVANCED_PAID , nvl((select   NET_PAY_BILL
                         from     BILL 
                         where    to_char(BILL_DATE,'DD-MON-RRRR') = to_char(sysdate,'DD-MON-RRRR')), 0) BILL_TOTAL
from     BOOKING_M 
where    to_char(booking_m_date,'DD-MON-RRRR') = to_char(sysdate,'DD-MON-RRRR') ; 






create or replace view total_Daily_income_view1
as
select   nvl(ADVANCED_PAID,0) , null
from     BOOKING_M
where    to_char(booking_m_date,'DD-MON-RRRR') = to_char(sysdate,'DD-MON-RRRR')
union all
select   null , nvl(sum(NET_PAY_BILL),0)
from     BILL 
where    to_char(BILL_DATE,'DD-MON-RRRR') = to_char(sysdate,'DD-MON-RRRR')



select   sum(ADVANCED_PAID),BILL_TOTAL
from     total_Daily_income_view

create or replace view total_Daily_income_view1
as
select   sum(ADVANCED_PAID) + BILL_TOTAL total_bill
from     total_Daily_income_view
group by BILL_TOTAL

select total_bill
from   total_Daily_income_view1;
