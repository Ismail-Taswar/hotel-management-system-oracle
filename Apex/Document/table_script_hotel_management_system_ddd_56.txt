 --1.

--===============
--Table User_type
--===============

drop table user_type cascade constraint;
 
create table user_type
(
 user_type_id          number,
 user_type_name        varchar2(100) constraint user_type_user_type_name_nn not null
                                     constraint user_type_user_type_name_uk unique,
 user_type_description varchar2(250),
 action_user           varchar2(100) default user,
 action_date_time      date          default sysdate
);

alter table user_type
add         constraint user_type_user_type_id_pk primary key(user_type_id);



--2.
--==================
--Table User_Status
--==================

drop table user_Status cascade constraint;
 
create table user_Status
(
 user_Status_id               number,
 user_Status_name             varchar2(100) constraint user_Status_user_Status_name_nn not null
                                            constraint user_Status_user_Status_name_uk unique,
 user_status_description      varchar2(250),
 action_user                  varchar2(100) default user,
 action_date_time             date          default sysdate
);

alter table user_Status
add         constraint user_Status_user_Status_id_pk primary key(user_Status_id);



--3.

--============
--Branch Table
--============

drop table branch cascade constraint;

create table branch
 (
  branch_id           number,
  branch_name         varchar2(100)  constraint branch_branch_name_nn not null
                                     constraint branch_branch_name_uk unique,
  cell_number         varchar2(100)  constraint branch_phone_number_uk unique,
  branch_address      varchar2(250),
  email               varchar2(100)  constraint branch_email_uk unique,
  branch_description  varchar2(250),
  action_user         varchar2(100)   default user,
  action_date_time    date            default   sysdate
 );

alter table branch
add constraint branch_branch_id_pk primary key(branch_id);


--4.
--================ 
--Table Department
--================

drop table Department cascade constraint;

create table department
(
 department_id          number,
 department_name        varchar2(100) constraint department_department_name_nn not null
                                      constraint department_department_name_uk unique,
 department_location    varchar2(250),
 department_country     varchar2(100),
 department_description varchar2(250),
 action_User            varchar2(100) default user,
 action_date_time       date          default sysdate
);

alter table department
add   constraint department_department_id_pk primary key(department_id);



--5.
--================= 
--Table Designation
--=================

drop table Designation cascade constraint;

create table designation
(
 designation_id          number,
 designation_name        varchar2(100)  constraint designation_designation_name_nn not null
                                        constraint designation_designation_name_uk unique,
 designation_description varchar2(250),
 action_User             varchar2(100)  default user,
 action_date_time        date           default sysdate
);

alter table designation
add         constraint designation_designation_id_pk primary key(designation_id);


--6.

--=============== 
--Table Employee
--===============

drop table Employee cascade constraint;

create table Employee
(
 employee_ID           number,
 department_id         number,
 designation_id        number,
 branch_ID             number,
 first_name            varchar2(100) constraint Employee_Employee_First_name_nn not null,
 last_name             varchar2(100), 
 mother_name           varchar2(100),	
 father_name           varchar2(100),	
 present_address       varchar2(250),	
 Permanent_address     varchar2(250),	
 salary                Number        constraint Employee_salary_ck check(Salary > 0),	
 join_Date             Date          Default Sysdate,
 nid                   Number        constraint Employee_Nid_uk Unique,	
 email                 Varchar2(100) constraint Employee_Email_uk Unique,	
 Cell_Number           varchar2(100) constraint Employee_Cell_Number_uk Unique,	
 Date_of_Birth         Date,	
 Gender                varchar2(100),	
 Religion              varchar2(100),	
 Nationality           varchar2(100),	
 Blood_Group           varchar2(100),	
 employee_image        Blob,	
 action_User           varchar2(100)  Default user,	
 action_date_Time      date           Default Sysdate
);	
	
alter table Employee
add         constraint Employee_Employee_ID_pk primary key(Employee_ID);

alter table Employee
add         constraint Employee_department_id_fk foreign key(department_id)
references  department(department_id);

alter table Employee
add         constraint Employee_designation_id_fk foreign key(designation_id)
references  designation(designation_id);

alter table Employee
add         constraint Employee_Branch_ID_fk foreign key(Branch_ID)
references  Branch(Branch_ID);


--7.
--=============== 
--Table User_Info
--===============

drop table User_Info cascade constraint;

create table User_Info
(
 User_Info_id             number,
 Username                 varchar2(100)  constraint User_Info_user_Username_nn not null
                                         constraint User_Info_user_Username_uk unique,
 password                 varchar2(100), 
 User_type_id             number,
 user_status_id           number,
 user_image               blob,
 action_User              varchar2(100)  default user,
 action_date_time         date           default sysdate
);

alter table User_Info
add         constraint user_info_User_Info_id_pk primary key(User_Info_id);

alter table User_Info
add         constraint user_info_User_type_id_fk foreign key(User_type_id)
references  User_type(User_type_id);



alter table User_Info
add         constraint user_info_User_status_id_fk foreign key(User_status_id)
references  User_status(User_status_id);




--8.

--====================
--Table Expence_type
--===================
drop table expense_type cascade constraint;


create table Expense_type
(
 Expense_Type_ID           Number,	
 Expense_Type_Name         Varchar2(100)  constraint Expense_Type_Expense_Type_Name_nn not null
                                          constraint Expense_Type_Expense_Type_Name_UK unique,
 expense_type_description  varchar2(250),
 action_User               Varchar2(100)  Default user,	
 action_Date_Time          Date           Default Sysdate	
);

alter table Expense_Type
add constraints Expense_Type_Expense_Type_ID_pk primary key(Expense_Type_ID);




--9.
--============== 
--Table Expence_M
--==============
drop table expense_m cascade constraint;


create table Expense_M
(
 Expense_M_ID       Number,
 Branch_id          Number,	
 Expense_Date       Date,
 action_User        Varchar2(100) default user,
 action_date_time   Date          default sysdate
);

alter table Expense_M
add constraints  Expense_M_ID_pk primary key(Expense_M_ID);

alter table Expense_M
add constraints  Expense_M_Branch_id_fk foreign key(Branch_id)
references Branch(Branch_id);





--10.

--===============
--Table Expense_D
--===============

drop table Expense_D cascade constraint;


create table Expense_D
(
 Expense_d_id       number,
 Expense_Type_ID    Number,
 Expense_M_ID       Number,        	
 Expense_Amount     Number        constraint Expense_D_Expense_Amount_nn not null,	
 Payment_mode       Number,
 Expense_by         Number,	
 Description        Varchar2(250),                           	
 action_User        Varchar2(100) default user,
 action_date_time   Date          default sysdate
);

alter table expense_d
add    constraints  expense_d_expense_d_id_pk  primary key(expense_d_id);


alter table Expense_D
add constraints Expense_D_Expense_Type_ID_fk Foreign key(Expense_Type_ID)
references Expense_Type(Expense_Type_ID);


alter table Expense_D
add constraints Expense_D_Expense_M_ID_fk foreign key(Expense_M_ID)
references Expense_M(Expense_M_ID);

alter table Expense_D
add constraints Expense_D_Payment_mode_fk foreign key(Payment_mode)
references Payment_mode(Payment_mode_id);

alter table Expense_D
add constraints Expense_D_Expense_by_fk foreign key(Expense_by)
references Payment_mode(Employee_id);

--11.
--===============
--Table guest				
--===============

drop table guest cascade constraint;

create table guest
(
guest_id            number,	
first_name          varchar2(100) constraint guest_guest_name_nn not null,
last_name           varchar2(100),	
cell_number         varchar2(100)  constraint guest_cell_number_uk unique,
email               varchar2(100)  constraint guest_email_uk unique,
gender              varchar2(100),
address             varchar2(250),	
city                varchar2(100),
country             varchar2(100),
nid_number  	    number         constraint nid_number_uk unique,
passport_number     varchar2(100)  constraint passport_number_uk unique,
image               blob,	
action_user         varchar2(100)  default  user,
action_date_time    date           default  sysdate
);


alter table guest 
add constraint guest_guest_id_pk primary key(guest_id);


--12.
--===============
--Table room_type				
--===============


drop table room_type cascade constraint;

create table room_type
(
room_type_id         number,
room_type_name       varchar2(100)   constraint room_type_room_type_name_uk unique,
description          varchar2(250),    
action_user          varchar2(100)   Default User,
action_date_time     date            Default  Sysdate
);

alter table room_type
add   constraint room_type_room_type_id_pk primary key(room_type_id);






--13.
--====================
--Table room_category				
--====================

drop table room_category cascade constraint;


create table room_category
(
room_category_id         number,
room_category_name       varchar2(100)    constraint room_category_room_category_name_uk unique,
description              Varchar2(250),    
action_user              varchar2(100)    default User,
action_date_time         date             default  sysdate
);  


alter table room_category
add   constraint room_category_room_category_id_pk primary key(room_category_id);







--14.
--===============
--Table floor				
--===============

drop table floor cascade constraint;

create table floor
(
floor_id          number,
floor_name        varchar2(100)   constraint floor_floor_name_uk unique,
description       varchar2(250),    
action_user       varchar2(100)   default user,
action_date_time  date            default sysdate
);

alter table floor
add   constraint floor_floor_id_pk primary key(floor_id);


--15.
--===============
--Table room			
--===============


drop table room cascade constraint;

create table room
(
room_id            number,
room_number        varchar2(100),
room_type_id       number,
room_category_id   number,
floor_id           number,	
number_of_bed      varchar2(100),		
room_rent          number,	
action_user        varchar2(100)  default user,
action_date_time   date           default sysdate
);

alter table room
add   constraint room_room_id_pk primary key(room_id);


alter table room
add         constraint room_room_type_id_fk foreign key(room_type_id)
references  room_type(room_type_id);


alter table room
add         constraint room_room_category_id_fk foreign key(room_category_id)
references  room_category(room_category_id);


alter table room
add         constraint room_floor_id_fk foreign key(floor_id)
references  floor(floor_id);




--16.
--=============
--payment_mode
--=============            


drop table payment_mode cascade constraint ;


create table payment_mode
(
payment_mode_id            number,
payment_mode_name          varchar2(100) constraint payment_mode_payment_mode_name_nn not null
                                         constraint payment_mode_payment_mode_name_uk unique,
payment_mode_description   varchar2(250),
action_user                varchar2(100) default user,
action_date_time           date default sysdate
);

alter table payment_mode
add   constraint payment_mode_payment_mode_id_pk primary key(payment_mode_id);




--17.
--=========
--BOOKING_M
--=========             


drop table BOOKING_M cascade constraint ;


create table BOOKING_M
(
Booking_M_ID	           Number,	
Guest_ID	           Number,
payment_mode_id            number,
Booking_D2_ID              number,	 
Booking_ID	           Varchar2(100)     constraint BOOKING_M_Booking_ID_uk unique
                                             constraint BOOKING_M_Booking_ID_nn not null,	
Booking_M_Date	           Date	             Default Sysdate,
Total_Amount	           Number,	
Discount	           Number,	
Grand_Total	           Number,	
Advanced_Paid	           Number,	
Due	                   Number,
Payment_Status	           Varchar2(100),
number_of_adult            number,
number_of_children         number,	
Check_In_Date	           Date,
Check_Out_date	           Date,
Total_Booked_Days	   number,	
Emergency_Cell_Number	   varchar2(100)        constraint BOOKING_M_Emergency_Cell_Number_uk unique,	
Action_user	           Varchar2(100)	Default User,
Action_Date_Time	   Date          	Default Sysdate
) ;



alter  table BOOKING_M
add    constraint BOOKING_M_BOOKING_M_id_pk primary key(BOOKING_M_id) ;


alter        table BOOKING_M
add          constraint BOOKING_M_Guest_ID_fk foreign key(Guest_ID)
references   guest(Guest_ID);

alter        table BOOKING_M
add          constraint BOOKING_M_payment_mode_id_fk foreign key(payment_mode_id)
references   payment_mode(payment_mode_id );


alter        table BOOKING_M
add          constraint BOOKING_M_Booking_D2_ID_fk foreign key(Booking_D2_ID)
references   Booking_D2(Booking_D2_ID);




--18.
--=========
--BOOKING_D
--=========

drop table BOOKING_D cascade constraint ;


create table BOOKING_D
(
Booking_D_ID	        Number,	
Booking_M_ID	        Number,
Room_ID  	        Number,    
Action_User	        Varchar2(100)	Default User,
Action_Date_Time        Date	        Default Sysdate
);


alter  table BOOKING_D
add    constraint BOOKING_D_BOOKING_D_ID_pk primary key(BOOKING_D_ID) ;

alter        table BOOKING_D
add          constraint BOOKING_D_BOOKING_M_ID_fk foreign key(BOOKING_M_ID)
references   BOOKING_M(BOOKING_M_ID);

alter        table BOOKING_D
add          constraint BOOKING_D_ROOM_ID_fk foreign key(ROOM_ID)
references   ROOM(ROOM_ID);




--19.
--==========
--BOOKING_D2
--==========

drop table BOOKING_D2 cascade constraint ;


create table BOOKING_D2
(
Booking_D2_ID	        Number,
name                    varchar2(100) constraint   booking_d2_name_nn not null,
NID                     number        constraint   booking_d2_nid_uk unique,
cell_number             varchar2(100) constraint   booking_d2_cell_number_uk unique,
relation_with_guest     varchar2(100),                	
Action_User	        Varchar2(100)	Default User,
Action_Date_Time        Date	        Default Sysdate
);


alter  table BOOKING_D2
add    constraint BOOKING_D2_BOOKING_D2_ID_pk primary key(BOOKING_D2_ID) ;


--21.
--===============
--Table Check_In				
--===============

drop table Check_In cascade constraint;
 
create table Check_In
(
 Check_In_id         number,
 Booking_M_ID        number,
 Guest_id            number,
 Check_In_Date       date,
 Status              varchar2(250),
 action_user         varchar2(100) default user,
 action_date_time    date          default sysdate
);

alter table Check_In
add   constraint Check_In_Check_In_id_pk primary key(Check_In_id) ;

alter        table Check_In
add          constraint Check_In_Booking_M_ID _fk foreign key(Booking_M_ID )
references   Booking_M(Booking_M_ID);

alter        table Check_In
add          constraint Check_In_guest_ID_fk foreign key(guest_ID)
references   guest(guest_ID);


--22.
--===============
--Table Service				
--===============

drop table Service cascade constraint;
 
create table Service
(
 Service_id          number,
 Service_Name	     Varchar2(100) constraint Service_Service_Name_uk unique,
 Service_rate        number,
 Description         varchar2(250),     
 action_user         varchar2(100) default user,
 action_date_time    date          default sysdate
);

alter table Service
add   constraint Service_Service_id_pk primary key(Service_id) ;



--23.
--===============
--Table Service_M		
--===============

drop table Service_M cascade constraint;
 
create table Service_M
(
 Service_M_id        number,
 Booking_M_ID        number,
 invoice_number      varchar2(100) constraint Service_M_invoice_number_uk unique,
 Service_Date        date          default sysdate,
 action_user         varchar2(100) default user,
 action_date_time    date          default sysdate
);

alter table Service_M
add   constraint Service_M_Service_M_id_pk primary key(service_m_id) ;


alter table Service_M
add         constraint Service_M_Booking_M_ID_fk foreign key(Booking_M_ID)
references  Booking_M(Booking_M_ID);


--24.
--================
--Table Service_D		
--================

drop table Service_D cascade constraint;
 
create table Service_D
(
 Service_D_id        number,
 Service_ID          number,
 Service_M_ID        number,
 Service_Duration    number,
 action_user         varchar2(100) default user,
 action_date_time    date          default sysdate
);

alter table Service_D
add   constraint Service_D_Service_D_id_pk primary key(Service_D_id) ;


alter table Service_D
add         constraint Service_D_Service_ID_fk foreign key(Service_ID)
references  Service(Service_ID);


alter table Service_D
add         constraint Service_D_Service_M_ID_fk foreign key(Service_m_ID)
references  Service_m(Service_m_ID);



--25.
--===============
--Table Check_Out				
--===============

drop table Check_Out cascade constraint;
 
create table Check_Out
(
 Check_Out_ID         number,
 Check_In_ID          number,
 guest_id             number,
 booking_m_id         number,
 Check_Out_Date       Date,
 Paid                 number,
 action_user          varchar2(100) default user,
 action_date_time     date          default sysdate
);

alter table Check_Out
add   constraint Check_Out_Check_Out_id_pk primary key(Check_Out_id) ;


alter table Check_Out
add         constraint Check_Out_Check_In_ID_fk foreign key(Check_In_ID)
references  Check_In(Check_In_ID);


alter        table Check_Out
add          constraint Check_out_guest_ID_fk foreign key(guest_ID)
references   guest(guest_ID);


alter        table Check_Out
add          constraint Check_out_booking_m_id_fk foreign key(booking_m_id)
references   booking_m(booking_m_id);




--26.
--===============
--FOOD_CATEGORY
--===============

drop table food_category cascade constraint ;

create table food_category
(
food_category_id      number,
food_category_name    varchar2(100)  constraint food_category_food_category_name_uk unique ,
description           varchar2(250), 
action_user           varchar2(100)  default user,
action_date_time      date           default sysdate 
) ;  


alter  table  food_category
add    constraint food_category_food_category_id_pk primary key(food_category_id) ;



--27.
--=========
--FOOD_TYPE
--=========
drop table food_type cascade constraint ;

create table food_type
(
food_type_id       number,
food_type_name     varchar2(100)   constraint food_type_food_type_name_uk unique ,
description        varchar2(250), 
action_user        varchar2(100)   default user,
action_user_date   date            default sysdate 
) ;


alter  table  food_type
add    constraint food_type_food_type_id_pk primary key(food_type_id) ;




--28.
--========
-- FOOD ---
--==========

drop table food cascade constraint;

create table food
(
food_id                number,
food_name              varchar2(100) constraint food_food_name_uk unique,	
food_category_id       number,
food_type_id           number,
food_rate              number,	
action_user            varchar2(100) default user,
action_date_time       date  default sysdate
);

alter table food
add   constraint food_food_id_pk primary key(food_id);


alter table food
add         constraint food_food_category_id_fk foreign key(food_category_id)
references  food_category(food_category_id);


alter table food
add         constraint food_food_type_id_fk foreign key(food_type_id)
references  food_type(food_type_id);


--29.
--===============
--Table FOOD_M				
--===============

drop table FOOD_M cascade constraint;
create table FOOD_M
(
 food_m_id            number,
 Booking_M_ID         number,
 invoice_number       varchar2(100) constraint food_M_invoice_number_uk unique,
 Order_Date           Date default sysdate,
 action_user          varchar2(100) default user,
 action_date_time     date          default sysdate
);

alter table FOOD_M
add   constraint FOOD_M_FOOD_M_id_pk primary key(FOOD_M_id) ;


alter table FOOD_M
add         constraint food_m_Booking_M_ID_fk foreign key(Booking_M_ID)
references  Booking_M(Booking_M_ID);


--30.
--=========
--FOOD_D
--========= 


drop table FOOD_D cascade constraint ;


create table FOOD_D
(
food_d_id	        number,
food_m_id	        number,
food_id	                number,
food_quantity	        number,	
action_user	        varchar2(100)   default user,
action_date_time        date	        default sysdate
) ;


alter  table FOOD_D
add    constraint FOOD_D_FOOD_D_id_pk primary key(FOOD_D_id) ;


alter        table FOOD_D
add          constraint FOOD_D_food_m_id_fk foreign key(food_m_id)
references   FOOD_M(food_m_id);


alter        table FOOD_D
add          constraint FOOD_D_food_id_fk foreign key(food_id)
references   FOOD(food_id);

--31.
--=========
--Room_Status
--========= 

drop table Room_Status cascade constraint ;

create table Room_Status
(
 Room_Status_id	        number,
 booking_M_id	        number,
 room_id	        number,
 check_in_date          date,
 check_out_date         date,
 status                 varchar2(100),
 action_user	        varchar2(100)   default user,
 action_date_time       date	        default sysdate
) ;


alter  table Room_Status
add    constraint Room_Status_Room_Status_id_pk primary key(Room_Status_id) ;


alter  table Room_Status
add          constraint Room_Status_booking_M_id foreign key(booking_M_id)
references   booking_d(booking_d_id);


alter  table Room_Status
add          constraint Room_Status_room_id_fk foreign key(room_id)
references   room(room_id);



select USER_INFO_ID,USER_INFO.user_type_id,USER_TYPE_NAME,USER_INFO.user_status_id,USER_STATUS_NAME,USERNAME,password, USER_IMAGE,
        user_info.ACTION_USER , user_info.ACTION_DATE_TIME
from   USER_INFO, USER_TYPE, USER_STATUS
where  USER_INFO.USER_TYPE_ID = USER_TYPE.USER_TYPE_ID
AND    USER_INFO.USER_STATUS_ID=USER_STATUS.USER_STATUS_ID
order  by  USER_INFO_ID

  CREATE TABLE "BILL" 
   (	"BILL_ID" NUMBER, 
	"BOOKING_M_ID" NUMBER, 
	"SERVICE_M_ID" NUMBER, 
	"FOOD_M_ID" NUMBER, 
	"INVOICE_NUMBER" NUMBER, 
	"BILL_DATE" DATE, 
	"PAY" NUMBER, 
	"PAYMENT_MODE_ID" NUMBER, 
	"PAYMENT_DESC" VARCHAR2(350), 
	"ACTION_USER" VARCHAR2(100) DEFAULT user, 
	"ACTION_DATE_TIME" DATE DEFAULT sysdate, 
	"NET_PAY_BILL" NUMBER, 
	"STATUS" VARCHAR2(100)
   ) ;
  CREATE UNIQUE INDEX "BILL_INVOICE_NUMBER_UK" ON "BILL" ("INVOICE_NUMBER") 
  ;
  CREATE UNIQUE INDEX "BILL_BILL_ID_PK" ON "BILL" ("BILL_ID") 
  ;
ALTER TABLE "BILL" ADD CONSTRAINT "BILL_INVOICE_NUMBER_UK" UNIQUE ("INVOICE_NUMBER")
  USING INDEX "BILL_INVOICE_NUMBER_UK"  ENABLE;
ALTER TABLE "BILL" ADD CONSTRAINT "BILL_BILL_ID_PK" PRIMARY KEY ("BILL_ID")
  USING INDEX "BILL_BILL_ID_PK"  ENABLE;

  ALTER TABLE "BILL" ADD CONSTRAINT "BILL_SERVICE_M_ID_FK" FOREIGN KEY ("SERVICE_M_ID")
	  REFERENCES "SERVICE_M" ("SERVICE_M_ID") ENABLE NOVALIDATE;
  ALTER TABLE "BILL" ADD CONSTRAINT "BILL_FOOD_M_ID_FK" FOREIGN KEY ("FOOD_M_ID")
	  REFERENCES "FOOD_M" ("FOOD_M_ID") ENABLE NOVALIDATE;
  ALTER TABLE "BILL" ADD CONSTRAINT "BILL_PAYMENT_MODE_ID_FK" FOREIGN KEY ("PAYMENT_MODE_ID")
	  REFERENCES "PAYMENT_MODE" ("PAYMENT_MODE_ID") ENABLE NOVALIDATE;
  ALTER TABLE "BILL" ADD CONSTRAINT "BILL_BOOKING_M_ID_FK" FOREIGN KEY ("BOOKING_M_ID")
	  REFERENCES "BOOKING_M" ("BOOKING_M_ID") ENABLE NOVALIDATE;








