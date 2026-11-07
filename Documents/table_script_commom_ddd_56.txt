1.
--===============
--Table User_type
--===============

drop table user_type cascade constraint;
 
create table user_type
(
 user_type_id        number,
 user_type_name      varchar2(100) constraint user_type_user_type_name_nn not null
                                   constraint user_type_user_type_name_uk unique,
 user_description    varchar2(250),
 action_user         varchar2(100) default user,
 action_date_time    date         default sysdate
);

alter table user_type
add         constraint user_type_user_type_id_pk primary key(user_type_id);



2.
--===============
--Table User_Status
--===============

drop table user_Status cascade constraint;
 
create table user_Status
(
 user_Status_id        number,
 user_Status_name      varchar2(100) constraint user_Status_user_Status_name_nn not null
                                     constraint user_Status_user_Status_name_uk unique,
 user_status_description      varchar2(250),
 action_user           varchar2(100) default user,
 action_date_time      date         default sysdate
);

alter table user_Status
add         constraint user_Status_user_Status_id_pk primary key(user_Status_id);



3.

--============
--Branch Table
--============

drop table branch cascade constraint;

create table branch
 (
  branch_id           number,
  branch_name         varchar2(100)  constraint branch_branch_name_nn not null,
  phone_number        varchar2(100)  constraint branch_phone_number_uk unique,
  branch_address      varchar2(250),
  email               varchar2(100)  constraint branch_email_uk unique,
  bracnch_description varchar2(250),
  action_user         varchar2(100)   default user,
  action_date_time    date  default  sysdate
 );

alter table branch
add constraint branch_branch_id_pk primary key(branch_id);


4.
--================ 
--Table Department
--================

drop table Department cascade constraint;

create table department
(
 department_id        number,
 department_name      varchar2(100) constraint department_department_name_nn not null
                                    constraint department_department_name_uk unique,
 department_location  varchar2(250),
 department_country   varchar2(100),
 department_description varchar2(250),
 action_User          varchar2(100) default user,
 action_date_time     date          default sysdate
);

alter table department
add   constraint department_department_id_pk primary key(department_id);



5.
--================= 
--Table Designation
--=================

drop table Designation cascade constraint;

create table designation
(
 designation_id          number,
 designation_name        varchar2(100)  constraint designation_designation_name_nn not null,
 designation_description varchar2(250),
 action_User             varchar2(100)  default user,
 action_date_time        date           default sysdate
);

alter table designation
add         constraint designation_designation_id_pk primary key(designation_id);


6.

--=============== 
--Table Employee
--===============

drop table Employee cascade constraint;

create table Employee
(
 Employee_ID           number,
 department_id         number,
 designation_id        number,
 Branch_ID             number,
 First_name            varchar2(100) constraint Employee_Employee_First_name_nn not null,
 last_name             varchar2(100) constraint Employee_Employee_last_name_nn not null,
 Mother_name           varchar2(100),	
 Father_Name           varchar2(100),	
 Present_Address       varchar2(250),	
 Permanent_Address     varchar2(250),	
 Salary                Number        constraint Employee_salary_ck check(Salary > 0),	
 Join_Date             Date          Default Sysdate,
 Nid                   Number        constraint Employee_Nid_uk Unique,	
 Email                 Varchar2(100) constraint Employee_Email_uk Unique,	
 Cell_Number           varchar2(100) constraint Employee_Cell_Number_uk Unique,	
 Date_of_Birth         Date,	
 Gender                varchar2(100),	
 Religion              varchar2(100),	
 Nationality           varchar2(100),	
 Blood_Group           varchar2(100),	
 Employee_image        Blob,	
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


7.
--=============== 
--Table User_Info
--===============

drop table User_Info cascade constraint;

create table User_Info
(
 User_Info_id             number,
 User_type_id             number,
 Username                 varchar2(100)  constraint User_Info_user_Username_nn not null
                                         constraint User_Info_user_Username_uk unique,
 password                 varchar2(100), 
 user_image               blob,
 action_User              varchar2(100)  default user,
 action_date              date          default sysdate
);

alter table User_Info
add         constraint user_info_User_Info_id_pk primary key(User_Info_id);

alter table User_Info
add         constraint user_info_User_type_id_fk foreign key(User_type_id)
references  User_type(User_type_id);


8.

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




9.
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
 action_date        Date default sysdate
);

alter table Expense_M
add constraints  Expense_M_ID_pk primary key(Expense_M_ID);

alter table Expense_M
add constraints  Expense_M_Branch_id_fk foreign key(Branch_id)
references Branch(Branch_id);





10.

--===============
--Table Expense_D
--===============

drop table Expense_D cascade constraint;


create table Expense_D
(
 Expense_d_id       number,
 Expense_M_ID       Number,
 Expense_Type_ID    Number,        	
 Expense_Amount     Number        constraint Expense_D_Expense_Amount_nn not null,	
 Payment_mode       Varchar2(100) constraint Expense_D_Payment_mode_nn not null,
 Expense_by         Varchar2(100),	
 Description        Varchar2(250),                           	
 action_User        Varchar2(100) default user,
 action_date        Date default sysdate
);

alter table expense_d
add    constraints  expense_d_expense_d_id_pk  primary key(expense_d_id);


alter table Expense_D
add constraints Expense_D_Expense_Type_ID_fk Foreign key(Expense_Type_ID)
references Expense_Type(Expense_Type_ID);


alter table Expense_D
add constraints Expense_D_Expense_M_ID_fk foreign key(Expense_M_ID)
references Expense_M(Expense_M_ID);





































































































































































