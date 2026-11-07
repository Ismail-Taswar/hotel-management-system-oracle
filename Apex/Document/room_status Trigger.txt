
create or replace TRIGGER Room_Status_id_PK_TRIG
before
insert on Room_Status
for each row
begin
select nvl(max(to_number(Room_Status_id)), 0) + 1
into :new.Room_Status_id
from Room_Status ;
end;
/


create or replace TRIGGER update_room_status
after INSERT OR UPDATE
ON booking_D
FOR EACH ROW
DECLARE
 v_Check_in_Date    booking_m.Check_in_Date%type ;
 v_Check_out_date   booking_m.Check_out_date%type ;
 V_BOOKING_M_ID     booking_m.BOOKING_M_ID%type ;
BEGIN
 select Check_in_Date,Check_out_date,BOOKING_M_ID
 into   v_Check_in_Date,v_Check_out_date,V_BOOKING_M_ID
 from   booking_m
 where  booking_m_id = :NEW.booking_M_id ;
    IF INSERTING THEN
        INSERT INTO room_status (booking_D_id,BOOKING_M_ID, Room_id,STATUS, action_user,Check_in_Date,Check_out_date)
        VALUES (:NEW.booking_D_id,V_BOOKING_M_ID, :NEW.Room_id, 'Booked', :NEW.action_user,v_Check_in_Date,v_Check_out_date);
    ELSIF UPDATING THEN
        UPDATE room_status
        SET booking_D_id = :NEW.booking_D_id,
            Room_id = :NEW.Room_id,
            action_user = :NEW.action_user
        WHERE booking_d_id = :OLD.booking_d_id;
    END IF;
END;
/



CREATE OR REPLACE TRIGGER delete_Room_status
before DELETE ON booking_d
FOR EACH ROW
DECLARE
BEGIN
 DELETE FROM room_status
 WHERE booking_d_id = :OLD.booking_d_id;
 end ;
/

create or replace trigger update_room_status_booking_cancel
insert 
on CANCELLATION
for each row
declare
begin
 update booking_m
 set    BOOKING_STATUS = :new.'Cancel'
 where  bookin_m_id = old.booking_m_id 
end;








