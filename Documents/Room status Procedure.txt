

create or replace procedure pro_re_admission_insert
(
 p_Re_Admission_id     in re_admission.re_admission_id%type,
 p_student_id          in re_admission.student_id%type, 
 p_Re_Admission_date   in re_admission.re_admission_date%type,
 p_current_shift_id    in re_admission.current_shift_id%type,
 p_current_class_id    in re_admission.current_class_id%type, 
 p_current_section_id  in re_admission.current_section_id%type,
 p_current_roll_number in re_admission.current_roll_number%type,
 p_new_shift_id        in re_admission.new_shift_id%type,
 p_new_class_id        in re_admission.new_class_id%type, 
 p_new_section_id      in re_admission.new_section_id%type,
 p_new_roll_number     in re_admission.new_roll_number%type,
 p_action_user         in re_admission.action_user%type
)
is
begin
 insert into re_admission(Re_Admission_id, student_id, Re_Admission_date, current_shift_id,
                          current_class_id, current_section_id, current_roll_number,
                          new_shift_id, new_class_id, new_section_id, new_roll_number,
                          action_user)
 values(p_Re_Admission_id, p_student_id, p_Re_Admission_date, p_current_shift_id, p_current_class_id,
        p_current_section_id, p_current_roll_number, p_new_shift_id, p_new_class_id, p_new_section_id,
        p_new_roll_number, p_action_user);
commit ;
end ;
/

declare
	v_re_admission_id   re_admission.re_admission_id%type ;
  v_old_roll_number   re_admission.current_roll_number%type ;
Begin
 if show_alert('save') = alert_button1 then
 	  v_old_roll_number := :RE_ADMISSION.ROLL_NUMBER ;
 	  :RE_ADMISSION.ROLL_NUMBER := :RE_ADMISSION.OLD_ROLL_NUMBER ;
 	  :RE_ADMISSION.action_user := :global.username ;
 	  
   :system.message_level := 5;
   commit_form ;
   :system.message_level := 0;
   
  

 select nvl(max(to_number(re_admission_id)), 0) + 1
 into   v_re_admission_id
 from   re_admission ;


   
   pro_re_admission_insert(v_re_admission_id, :RE_ADMISSION.STUDENT_ID, sysdate,
                           :RE_ADMISSION.OLD_SHIFT_ID, :RE_ADMISSION.OLD_CLASS_ID, :RE_ADMISSION.OLD_SECTION_ID,
                           v_old_roll_number, :RE_ADMISSION.SHIFT_ID, :RE_ADMISSION.CLASS_ID,
                           :RE_ADMISSION.SECTION_ID, :RE_ADMISSION.ROLL_NUMBER, :global.username) ;


  clear_form ;
  
 end if ;
exception
 when others then
  null ;
end ;


 insert into Room_Status (Room_Status_id, booking_M_id, room_id, check_in_date,
                          check_out_date, status,action_user)
 values(P_Room_Status_id, p_booking_M_id, p_room_id, p_check_in_date, p_check_out_date,
        p_status,p_action_user);


--room_status
====================

create or replace procedure pro_Room_Status_insert
(
 P_Room_Status_id      in Room_Status.Room_Status_id%type,
 p_booking_M_id        in Room_Status.booking_M_id%type, 
 p_room_id             in Room_Status.room_id%type,
 p_check_in_date       in Room_Status.check_in_date%type,
 p_check_out_date      in Room_Status.check_out_date%type, 
 p_action_user         in Room_Status.action_user%type
)
is
begin
 insert into Room_Status (Room_Status_id, booking_M_id, room_id, check_in_date,
                          check_out_date, status,action_user)
 values(P_Room_Status_id, p_booking_M_id, p_room_id, p_check_in_date, p_check_out_date,'Unavailable',p_action_user);
commit ;
end ;
/

declare
	v_Room_Status_id   Room_Status.Room_Status_id%type ;
Begin
 if show_alert('save') = alert_button1 then
 	  :BOOKING_M.action_user := :global.username ;
   commit_form ;

 select nvl(max(to_number(Room_Status_id)), 0) + 1
 into   v_Room_Status_id
 from   Room_Status ;


   
   pro_Room_Status_insert(v_Room_Status_id, :BOOKING_M.BOOKING_M_ID, :BOOKING_D.ROOM_ID, 
                           :BOOKING_M.CHECK_IN_DATE, :BOOKING_M.CHECK_OUT_DATE,:BOOKING_M.ACTION_USER) ;

  clear_form ;
  
 end if ;
exception
 when others then
  null ;
end ;

declare
	v_Room_Status_id   Room_Status.Room_Status_id%type ;
Begin
 if show_alert('save') = alert_button1 then
 	  :BOOKING_M.action_user := :global.username ;
 	  
   commit_form ;
   
 select nvl(max(to_number(Room_Status_id)), 0) + 1
 into   v_Room_Status_id
 from   Room_Status ;
  
   pro_Room_Status_insert(v_Room_Status_id, :BOOKING_M.BOOKING_M_ID, :BOOKING_D.ROOM_ID, 
                        :BOOKING_M.CHECK_IN_DATE, :BOOKING_M.CHECK_OUT_DATE,:BOOKING_M.ACTION_USER) ;
--
  clear_form ;
--  
 end if ;
exception
 when others then
  null ;
end ;


