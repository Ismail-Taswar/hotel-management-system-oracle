  CREATE OR REPLACE  VIEW SERVICE_VIEW  AS 
  select SERVICE_D.SERVICE_M_ID, SERVICE_M.BOOKING_M_ID, INVOICE_NUMBER, SERVICE_DATE, 
       SERVICE_M.ACTION_USER, SERVICE_M.ACTION_DATE_TIME,
       SERVICE_D_ID, SERVICE_D.SERVICE_ID, SERVICE_DURATION, SERVICE.SERVICE_RATE,
       BOOKING_M.GUEST_ID,BOOKING_ID,SERVICE_NAME,FIRST_NAME, LAST_NAME
from   SERVICE_M,SERVICE_D,SERVICE,BOOKING_M,GUEST
where  SERVICE_D.SERVICE_M_ID = SERVICE_M.SERVICE_M_ID
and    SERVICE_D.SERVICE_ID = SERVICE.SERVICE_ID
and    SERVICE_M.BOOKING_M_ID = BOOKING_M.BOOKING_M_ID
and    BOOKING_M.GUEST_ID = GUEST.GUEST_ID
order  by INVOICE_NUMBER;



  CREATE OR REPLACE VIEW FOOD_VIEW2  AS 
  select FD.food_m_id,fm.booking_M_Id,INVOICE_NUMBER,nvl(FOOD_QUANTITY,1) * nvl(FOOD_RATE,0) Total_rate
from   food_d FD,food_m fm, booking_m b
where  FD.food_m_id = fm.food_m_id
and    fm.booking_M_Id = b.booking_M_Id;

 CREATE OR REPLACE  VIEW BILL_VIEW 
AS 
  select  booking_m_id,Guest_Name,GUEST_ID,booking_id,due,sum(Total_rate) food_bill,service_bill
from (
select distinct b.booking_m_id,b.GUEST_ID,b.FIRST_NAME||' '||b.LAST_NAME Guest_Name, b.booking_id, b.due, nvl(FOOD_QUANTITY,1) * nvl(FOOD_RATE,0) Total_rate,
              sum(nvl(SERVICE_DURATION,1) * nvl(SERVICE_Rate,0)) service_bill
from   Booking_view b , FOOD_VIEW f,SERVICE_VIEW s
where f.booking_m_id = b.booking_m_id
and   s.booking_m_id = b.booking_m_id
group by  b.booking_m_id,b.GUEST_ID,b.FIRST_NAME||' '||b.LAST_NAME, b.booking_id, b.due,nvl(FOOD_QUANTITY,1) * nvl(FOOD_RATE,0)
)
group by booking_m_id,GUEST_ID,Guest_Name,booking_id,due,service_bill;


  CREATE OR REPLACE FORCE EDITIONABLE VIEW "BILL_R_VIEW" ("INVOICE_NUMBER", "BILL_DATE", "PAY", "PAYMENT_MODE_ID", "NET_PAY_BILL", "STATUS", "BOOKING_M_ID", "GUEST_ID", "GUEST_NAME", "BOOKING_ID", "BOOKING_DUE", "SERVICE_AMOUNT", "FOOD_AMOUNT", "PAYMENT_MODE_NAME") AS 
  select  bi.INVOICE_NUMBER, bi.BILL_DATE, bi.PAY, bi.PAYMENT_MODE_ID,bi.NET_PAY_BILL, bi.STATUS,b.booking_m_id,b.guest_id, b.Guest_Name, 
        b.booking_id, b.due booking_Due, service_bill Service_Rate,food_bill Food_Amount,p.PAYMENT_MODE_Name
from    BILL bi,Bill_VIEW b,PAYMENT_MODE p
where   b.BOOKING_M_ID = bi.BOOKING_M_ID
and     bi.PAYMENT_MODE_ID = p.PAYMENT_MODE_ID
order by INVOICE_NUMBER;