
============ Booking Cancellation ===============
--=========
--Cancellations
--========= 

drop table Cancellations cascade constraint ;

create table Cancellation
(
 cancellation_id       number,
 booking_M_id	       number,
 cancellation_date     date,
 cancellation_fee      number,
 refund_amount         number,
 cancellation_reason   varchar2(250),
 action_user	       varchar2(100)   default user,
 action_date_time      date	       default sysdate
) ;


alter  table cancellation
add    constraint cancellation_cancellation_id_pk primary key(cancellation_id) ;


alter  table cancellation
add          constraint cancellation_booking_M_id foreign key(booking_M_id)
references   booking_m(booking_m_id);

==============trigger for booking_m booking_status =================
 
create or replace TRIGGER update_booking_M_status_booking_cancel
  AFTER INSERT
  ON CANCELLATION
  FOR EACH ROW
DECLARE
  booking_m_id CANCELLATION.booking_m_id%TYPE;
BEGIN
  -- Update the status of the related room_status record to 'Cancel'
  UPDATE booking_m
  SET BOOKING_STATUS = 'Cancelled'  -- Make sure the value matches the room_status.STATUS datatype and accepted values
  WHERE booking_m_id = :NEW.booking_m_id;  -- Use :NEW to refer to the new row in the CANCELLATION table
END;
/


==============trigger for Room_Status status =================

create or replace TRIGGER update_room_status_booking_cancel
  AFTER INSERT
  ON CANCELLATION
  FOR EACH ROW
DECLARE
 booking_m_id CANCELLATION.booking_m_id%TYPE;
BEGIN
  -- Update the status of the related room_status record to 'Cancel'
  UPDATE ROOM_STATUS
  SET STATUS = 'Cancelled'  -- Make sure the value matches the room_status.STATUS datatype and accepted values
  WHERE booking_m_id = :NEW.booking_m_id;  -- Use :NEW to refer to the new row in the CANCELLATION table
END;
/



===================== Dynamic Action Cancelation fee and refund =============
booking_m_id te dynamic action korte hobe


DECLARE  
 v_grand_total     NUMBER;  
 v_days            NUMBER; 
 v_fee             NUMBER; 
 v_adv             number ; 
BEGIN 


  select        ADVANCED_PAID
  into          v_adv 
  from          booking_m 
  where         booking_m_id = :P75_BOOKING_M_ID  ; 


  SELECT grant_total 
  INTO v_grand_total 
  FROM booking_m 
  WHERE booking_m_id = :P75_BOOKING_M_ID; 

  SELECT TO_DATE(SYSDATE, 'MM/DD/YYYY') - booking_m_date
  INTO v_days
  FROM booking_m 
  WHERE booking_m_id = :P75_BOOKING_M_ID;

  IF v_days < 1 THEN 
    :P75_CANCELLATION_FEE := 0 ; 
  ELSIF v_days > 1 AND v_days <= 2 THEN 
    :P75_CANCELLATION_FEE := nvl((v_grand_total * 0.10), 0); 
  ELSIF v_days > 2 THEN 
    :P75_CANCELLATION_FEE := nvl((v_grand_total * 0.20), 0); 
  END IF; 

  :P75_REFUND_AMOUNT :=  v_adv -  :P75_CANCELLATION_FEE   ; 

END;
