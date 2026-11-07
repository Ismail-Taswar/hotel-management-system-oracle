
--User Type--
--================

CREATE TABLE USER_TYPE
   (	USER_TYPE_ID            NUMBER, 
	USER_TYPE_NAME          VARCHAR2(100)  CONSTRAINT USER_TYPE_USER_TYPE_NAME_NN NOT NULL 
                                               CONSTRAINT USER_TYPE_USER_TYPE_NAME_UK UNIQUE,
	USER_TYPE_DESCRIPTION   VARCHAR2(250), 
	ACTION_USER             VARCHAR2(100) DEFAULT user, 
	ACTION_DATE_TIME        DATE DEFAULT sysdate
   );

alter table user_type
add         constraint user_type_user_type_id_pk primary key(user_type_id);



--User info--
--================
 

    CREATE TABLE USER_INFO
   (	
        USER_INFO_ID      NUMBER, 
	USER_TYPE_ID      NUMBER, 
	USERNAME          VARCHAR2(100)      CONSTRAINT USER_INFO_USER_USERNAME_NN NOT NULL 
                                             CONSTRAINT USER_INFO_USER_USERNAME_UK UNIQUE, 
	PASSWORD          VARCHAR2(100), 
	USER_IMAGE        BLOB, 
	ACTION_USER       VARCHAR2(100) DEFAULT user, 
	ACTION_DATE_TIME  DATE DEFAULT sysdate
     );


       alter table User_Info
       add         constraint user_info_User_Info_id_pk primary key(User_Info_id);

       alter table User_Info
       add         constraint user_info_User_type_id_fk foreign key(User_type_id)
       references  User_type(User_type_id);

      


--===========--
-- DEPARTMENT--
--===========--
CREATE TABLE DEPARTMENT
(
DEPARTMENT_ID              NUMBER, 
DEPARTMENT_NAME            VARCHAR2(100)  CONSTRAINT DEPARTMENT_DEPARTMENT_NAME_UK UNIQUE
                                          CONSTRAINT DEPARTMENT_DEPARTMENT_NAME_NN NOT NULL,
DEPARTMENT_LOCATION        VARCHAR2(250), 
DEPARTMENT_COUNTRY         VARCHAR2(100), 
DEPARTMENT_DESCRIPTION     VARCHAR2(250), 
ACTION_USER                VARCHAR2(100) DEFAULT user, 
ACTION_DATE_TIME           DATE          DEFAULT sysdate
) ;

alter table department
add   constraints department_id_pk primary key(department_id);

--===========--
--DESIGNATION--
--===========--
CREATE  TABLE DESIGNATION
(	
DESIGNATION_ID          NUMBER, 
DESIGNATION_NAME        VARCHAR2(100)    CONSTRAINT DESIGNATION_DESIGNATION_NAME_UK UNIQUE
                                         CONSTRAINT DESIGNATION_DESIGNATION_NAME_NN NOT NULL,
DESIGNATION_DESCRIPTION VARCHAR2(250), 
ACTION_USER             VARCHAR2(100)     DEFAULT user, 
ACTION_DATE_TIME        DATE              DEFAULT sysdate 
) ;

alter table designation
add         constraints designation_id_pk primary key(designation_id);


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



--============
--EXPENSE_M
--============

create table Expense_M
(
EXPENSE_M_ID	NUMBER,
BRANCH_ID	NUMBER,
EXPENSE_DATE	DATE,
ACTION_USER	VARCHAR2(100) default user,
ACTION_DATE_TIME   DATE       Default sysdate
);

alter table Expense_M
add constraints  Expense_M_ID_pk primary key(Expense_M_ID);

alter table Expense_M
add constraints  Expense_M_Branch_id_fk foreign key(Branch_id)
references Branch(Branch_id);


--==========
--EXPENSE_D
============

create table Expense_D
(
EXPENSE_D_ID	NUMBER,
EXPENSE_TYPE_ID	NUMBER,
EXPENSE_M_ID	NUMBER,
EXPENSE_AMOUNT	NUMBER       constraint Expense_D_Expense_Amount_nn not null,
PAYMENT_MODE	VARCHAR2(100) constraint Expense_D_Payment_mode_nn not null,
EXPENSE_BY	VARCHAR2(100),
DESCRIPTION	VARCHAR2(250),
ACTION_USER	VARCHAR2(100) default user,
ACTION_DATE_TIME   DATE       Default sysdate
);

alter table EXPENSE_D
add    constraints  EXPENSE_D_EXPENSE_D_ID_pk  primary key(EXPENSE_D_ID);


alter table Expense_D
add constraints Expense_D_Expense_Type_ID_fk Foreign key(Expense_Type_ID)
references Expense_Type(Expense_Type_ID);

alter table Expense_D
add constraints Expense_D_Expense_M_ID_fk foreign key(Expense_M_ID)
references Expense_M(Expense_M_ID);


      
