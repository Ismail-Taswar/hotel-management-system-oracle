

--employee_view :
--=========================

create or replace view employee_view
as
select employee_id ,first_name, last_name,e.branch_id,b.branch_name,e.department_id,d.department_name, 
       e.designation_id,g.designation_name,mother_name, father_name, e.email, e.cell_number, date_of_birth,
       nid,present_address, permanent_address,religion,gender,join_date,salary, employee_image
from   employee e, department d, designation g,branch b
where  e.department_id=d.department_id
and    e.designation_id=g.designation_id
and    e.branch_id=b.branch_id
order by employee_id desc;


--user_info_view
--=================

create or replace view user_info_view
As
select  user_info_id,username,user_type.user_type_name,user_image,user_info.action_user,user_info.action_date_time
from    user_info , user_type
where   user_info.user_type_id=user_type.user_type_id
order by user_info_id;




--employee_lov_view:
--==========================

create or replace view employee_lov_view
as
select  e.branch_id,b.branch_name||'-('||count(e.employee_id)||')' Branch_name
from   employee e, branch b
where e.branch_id=b.branch_id
group by e.branch_id,b.branch_name
order by b.branch_name;


--GUEST_view:
--===============================

create or replace view GUEST_view
as
select   GUEST_ID,FIRST_NAME,LAST_NAME,CELL_NUMBER,EMAIL,GENDER,
         ADDRESS,CITY,COUNTRY,NID_NUMBER,PASSPORT_NUMBER,IMAGE,
         ACTION_USER,ACTION_DATE_TIME
from     guest
order by GUEST_ID ;



--user_view :
--===============================
create or replace view user_view 
as
select USER_INFO_ID, USER_INFO.user_type_id, USER_TYPE_NAME,USERNAME, USER_IMAGE,
        user_info.ACTION_USER ,  user_info.ACTION_DATE_TIME 
from   USER_INFO,  USER_TYPE
where  USER_INFO.USER_TYPE_ID = USER_TYPE.USER_TYPE_ID
order  by  USER_INFO_ID ;



--CHECK_IN_VIEW
--=======================

CREATE OR REPLACE VIEW CHECK_IN_VIEW
AS
SELECT CHECK_IN.CHECK_IN_ID,CHECK_IN.STATUS,CHECK_IN.CHECK_IN_DATE,BOOKING_M.BOOKING_M_ID,BOOKING_M.BOOKING_ID,
       GUEST.GUEST_ID,GUEST.FIRST_NAME,GUEST.LAST_NAME,BOOKING_M.CHECK_OUT_DATE
FROM   CHECK_IN,BOOKING_M,GUEST
WHERE  BOOKING_M.BOOKING_M_ID=CHECK_IN.BOOKING_M_ID
AND    BOOKING_M.GUEST_ID = GUEST.GUEST_ID(+);




--CHECK_OUT_VIEW
--=======================

CREATE OR REPLACE VIEW CHECK_OUT_VIEW
AS
SELECT CHECK_OUT.CHECK_OUT_ID,CHECK_OUT.PAID,BOOKING_M.CHECK_OUT_DATE,BOOKING_M.BOOKING_M_ID,
       GUEST.GUEST_ID,GUEST.FIRST_NAME,GUEST.LAST_NAME,BOOKING_M.BOOKING_ID,CHECK_IN.CHECK_IN_ID
FROM   CHECK_OUT,GUEST,CHECK_IN,BOOKING_M
WHERE  CHECK_OUT.CHECK_IN_ID=CHECK_IN.CHECK_IN_ID
AND    CHECK_IN.BOOKING_M_ID=BOOKING_M.BOOKING_M_ID
AND    BOOKING_M.GUEST_ID=GUEST.GUEST_ID;


--SERVICE_view
=====================

create or replace view SERVICE_view
as
select SERVICE_D.SERVICE_M_ID, SERVICE_M.BOOKING_M_ID, INVOICE_NUMBER, SERVICE_DATE, 
       SERVICE_M.ACTION_USER, SERVICE_M.ACTION_DATE_TIME,
       SERVICE_D_ID, SERVICE_D.SERVICE_ID, SERVICE_DURATION, SERVICE.SERVICE_AMOUNT,
       BOOKING_M.GUEST_ID,BOOKING_ID,SERVICE_NAME,FIRST_NAME, LAST_NAME
from   SERVICE_M,SERVICE_D,SERVICE,BOOKING_M,GUEST
where  SERVICE_D.SERVICE_M_ID = SERVICE_M.SERVICE_M_ID
and    SERVICE_D.SERVICE_ID = SERVICE.SERVICE_ID
and    SERVICE_M.BOOKING_M_ID = BOOKING_M.BOOKING_M_ID
and    BOOKING_M.GUEST_ID = GUEST.GUEST_ID
order  by INVOICE_NUMBER


--Booking_view
=====================
create or replace view Booking_view
as
select  BOOKING_D.BOOKING_M_ID,BOOKING_M.BOOKING_ID,BOOKING_M.BOOKING_M_DATE,GUEST.FIRST_NAME,
        GUEST.LAST_NAME,BOOKING_M.GUEST_ID,BOOKING_M.TOTAL_AMOUNT,BOOKING_M.DISCOUNT,BOOKING_M.GRANT_TOTAL,
        BOOKING_M.ADVANCED_PAID,BOOKING_M.DUE,BOOKING_M.PAYMENT_STATUS,
        BOOKING_M.NUMBER_OF_ADULT,BOOKING_M.NUMBER_OF_CHILDREN,BOOKING_M.CHECK_IN_DATE,BOOKING_M.CHECK_OUT_DATE,
        BOOKING_M.PAYMENT_MODE_ID,PAYMENT_MODE.PAYMENT_MODE_NAME,BOOKING_M.ACTION_USER, BOOKING_M.ACTION_DATE_TIME,
        BOOKING_D.BOOKING_D_ID,BOOKING_D.ROOM_ID,ROOM.ROOM_NUMBER,ROOM.ROOM_RENT,ROOM.ROOM_TYPE_ID, ROOM_TYPE_NAME,TOTAL_BOOKED_DAYS
from    BOOKING_D,BOOKING_D2,BOOKING_M,GUEST,ROOM,PAYMENT_MODE,ROOM_TYPE
where   BOOKING_D.BOOKING_M_ID = BOOKING_M.BOOKING_M_ID
and     BOOKING_D2.BOOKING_M_ID = BOOKING_M.BOOKING_M_ID(+)
and     BOOKING_M.GUEST_ID = GUEST.GUEST_ID
and     BOOKING_D.ROOM_ID = ROOM.ROOM_ID
and     BOOKING_M.PAYMENT_MODE_ID = PAYMENT_MODE.PAYMENT_MODE_ID
and     ROOM.ROOM_TYPE_ID = ROOM_TYPE.ROOM_TYPE_ID
order   by BOOKING_M.BOOKING_ID ;

select * from Booking_view


--FOOD_VIEW
=================
CREATE OR REPLACE VIEW FOOD_VIEW
AS
SELECT FOOD.FOOD_CATEGORY_ID,FOOD_CATEGORY.FOOD_CATEGORY_NAME,
       FOOD.FOOD_TYPE_ID,FOOD_TYPE.FOOD_TYPE_NAME,
       GUEST.FIRST_NAME||' '||LAST_NAME GUEST_NAME,BOOKING_M.GUEST_ID,
       FOOD_D.FOOD_ID,FOOD.FOOD_NAME,FOOD.FOOD_RATE,
       FOOD_D.FOOD_M_ID,BOOKING_M.BOOKING_ID,FOOD_M.INVOICE_NUMBER,FOOD_M.ORDER_DATE,
       FOOD_M.BOOKING_M_ID,FOOD_M.ACTION_USER,FOOD_M.ACTION_DATE_TIME,
       FOOD_D.FOOD_D_ID,FOOD_D.FOOD_QUANTITY,FOOD_D.DESCRIPTION
FROM   FOOD_TYPE,FOOD_M,FOOD_D,FOOD_CATEGORY,FOOD,GUEST,BOOKING_M
WHERE  FOOD_D.FOOD_M_ID = FOOD_M.FOOD_M_ID
AND    FOOD_D.FOOD_ID = FOOD.FOOD_ID
AND    FOOD_M.BOOKING_M_ID = BOOKING_M.BOOKING_M_ID
AND    FOOD.FOOD_CATEGORY_ID = FOOD_CATEGORY.FOOD_CATEGORY_ID
AND    FOOD.FOOD_TYPE_ID = FOOD_TYPE.FOOD_TYPE_ID
AND    BOOKING_M.GUEST_ID = GUEST.GUEST_ID
ORDER  BY  FOOD_M.FOOD_M_ID

--Bill_VIEW
=================
CREATE OR REPLACE VIEW Bill_VIEW
AS
select  booking_m_id,Guest_Name,GUEST_ID,booking_id,due,sum(Total_rate) food_bill,service_bill
from (
select distinct b.booking_m_id,b.GUEST_ID,b.FIRST_NAME||' '||b.LAST_NAME Guest_Name, b.booking_id, b.due, nvl(FOOD_QUANTITY,1) * nvl(FOOD_RATE,0) Total_rate,
              sum(nvl(SERVICE_DURATION,1) * nvl(SERVICE_AMOUNT,0)) service_bill
from   Booking_view b , FOOD_VIEW f,SERVICE_VIEW s
where f.booking_m_id = b.booking_m_id
and   s.booking_m_id = b.booking_m_id
group by  b.booking_m_id,b.GUEST_ID,b.FIRST_NAME||' '||b.LAST_NAME, b.booking_id, b.due,nvl(FOOD_QUANTITY,1) * nvl(FOOD_RATE,0)
)
group by booking_m_id,GUEST_ID,Guest_Name,booking_id,due,service_bill


CREATE OR REPLACE VIEW FOOD_VIEW2
AS
select FD.food_m_id,fm.booking_M_Id,INVOICE_NUMBER,nvl(FOOD_QUANTITY,1) * nvl(FOOD_RATE,0) Total_rate 
from   food_d FD,food_m fm, booking_m b
where  FD.food_m_id = fm.food_m_id
and    fm.booking_M_Id = b.booking_M_Id



CREATE OR REPLACE VIEW Bill_R_view
AS
select  bi.INVOICE_NUMBER, bi.BILL_DATE, bi.PAY, bi.PAYMENT_MODE_ID,bi.NET_PAY_BILL, bi.STATUS,b.booking_m_id,b.guest_id, b.Guest_Name, 
        b.booking_id, b.due booking_Due, service_bill Service_Amount,food_bill Food_Amount,p.PAYMENT_MODE_Name
from    BILL bi,Bill_VIEW b,PAYMENT_MODE p
where   b.BOOKING_M_ID = bi.BOOKING_M_ID
and     bi.PAYMENT_MODE_ID = p.PAYMENT_MODE_ID
order by INVOICE_NUMBER


select  select  distinct INVOICE_NUMBER, BILL_DATE, PAY, PAYMENT_MODE_ID,NET_PAY_BILL, STATUS, booking_m_id, guest_id, Guest_Name, 
        booking_id, booking_Due, Sum(Service_Amount), sum(Food_Amount),PAYMENT_MODE_Name
from    Bill_R_view
group by INVOICE_NUMBER, BILL_DATE, PAY, PAYMENT_MODE_ID,NET_PAY_BILL, STATUS, booking_m_id, guest_id, Guest_Name, 
        booking_id, booking_Due, PAYMENT_MODE_Name









create or replace view Booking_view
as
select  BOOKING_D.BOOKING_M_ID,BOOKING_M.BOOKING_ID,BOOKING_M.BOOKING_M_DATE,GUEST.FIRST_NAME,
        GUEST.LAST_NAME,BOOKING_M.GUEST_ID,BOOKING_M.TOTAL_AMOUNT,BOOKING_M.DISCOUNT,BOOKING_M.GRANT_TOTAL,
        BOOKING_M.ADVANCED_PAID,BOOKING_M.DUE,BOOKING_M.PAYMENT_STATUS,
        BOOKING_M.NUMBER_OF_ADULT,BOOKING_M.NUMBER_OF_CHILDREN,BOOKING_M.CHECK_IN_DATE,BOOKING_M.CHECK_OUT_DATE,
        BOOKING_M.PAYMENT_MODE_ID,PAYMENT_MODE.PAYMENT_MODE_NAME,BOOKING_M.ACTION_USER, BOOKING_M.ACTION_DATE_TIME,
        BOOKING_D.BOOKING_D_ID,BOOKING_D.ROOM_ID,ROOM.ROOM_NUMBER,ROOM.ROOM_RENT,ROOM.ROOM_TYPE_ID, ROOM_TYPE_NAME,TOTAL_BOOKED_DAYS
from    BOOKING_D,BOOKING_D2,BOOKING_M,GUEST,ROOM,PAYMENT_MODE,ROOM_TYPE
where   BOOKING_D.BOOKING_M_ID = BOOKING_M.BOOKING_M_ID
--and     BOOKING_D2.BOOKING_M_ID = BOOKING_M.BOOKING_M_ID(+)
and     BOOKING_M.GUEST_ID = GUEST.GUEST_ID(+)
and     BOOKING_D.ROOM_ID = ROOM.ROOM_ID(+)
and     BOOKING_M.PAYMENT_MODE_ID = PAYMENT_MODE.PAYMENT_MODE_ID(+)
and     ROOM.ROOM_TYPE_ID = ROOM_TYPE.ROOM_TYPE_ID(+)
order   by BOOKING_M.BOOKING_ID ;







