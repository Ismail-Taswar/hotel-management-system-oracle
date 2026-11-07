--=====================================================
-- Menu / form access-control tables (Forms 10g)
-- Required by FORM_INFORMATION and USER_ACCESSS_PRIVILEGE
--=====================================================

--=============================
--FORM_INFORMATION
--=============================

drop table FORM_INFORMATION cascade constraint ;

CREATE TABLE FORM_INFORMATION
(
FORM_INFORMATION_ID              NUMBER   NOT NULL,
FORM_NAME                        VARCHAR2(100),
MENU_NAME                        VARCHAR2(100)
) ;

ALTER TABLE FORM_INFORMATION
ADD CONSTRAINT FORM_INFORMATION_ID_PK PRIMARY KEY ( FORM_INFORMATION_ID ) ;


--=============================
--USER_FORM_M
--=============================

drop table USER_FORM_M cascade constraint ;

CREATE TABLE USER_FORM_M
(
USER_FORM_M_ID               NUMBER NOT NULL,
USER_ID                      VARCHAR2(100),
USER_NAME                    VARCHAR2(100)
) ;

ALTER TABLE USER_FORM_M
ADD CONSTRAINT USER_FORM_M_ID_PK PRIMARY KEY ( USER_FORM_M_ID ) ;


--=============================
--USER_FORM_D
--=============================

drop table USER_FORM_D cascade constraint ;

CREATE TABLE USER_FORM_D
(
USER_FORM_D_ID                     NUMBER NOT NULL,
USER_FORM_M_ID                     NUMBER,
FORM_INFORMATION_ID                NUMBER,
FORM_NAME                          VARCHAR2(100),
STATUS                             VARCHAR2(100),
INSERT_USER                        VARCHAR2(100)
) ;

ALTER TABLE USER_FORM_D
ADD CONSTRAINT USER_FORM_D_ID_PK PRIMARY KEY ( USER_FORM_D_ID ) ;

ALTER TABLE USER_FORM_D
add CONSTRAINT USER_FORM_M_ID_FK FOREIGN KEY ( USER_FORM_M_ID )
REFERENCES USER_FORM_M ( USER_FORM_M_ID ) ;
