
Create view :
=========================

create or replace view employee_view
as
select employee_id ,first_name, last_name,e.branch_id,b.branch_name,e.department_id,d.department_name, 
       e.designation_id,g.designation_name,mother_name, father_name, e.email, e.cell_number, date_of_birth,
       nid,present_address, permanent_address,religion,gender,join_date,salary, employee_image
from   employee e, department d, designation g,branch b
where  e.department_id=d.department_id
and    e.designation_id=g.designation_id
and    e.branch_id=b.branch_id
order by employee_id desc


Report Query from tables :
=============================
select employee_id ,b.branch_name,d.department_name, g.designation_name,first_name, last_name, mother_name, 
       father_name, e.email, e.cell_number, date_of_birth,nid,present_address, permanent_address,religion,
       gender,join_date,salary, employee_image
from   employee e, department d, designation g,branch b
where  e.department_id=d.department_id
and    e.designation_id=g.designation_id
and    e.branch_id=b.branch_id


Report Query From View :
==============================

select employee_id ,branch_name,department_name,designation_name,first_name, last_name, mother_name, 
       father_name,email,cell_number, date_of_birth,nid,present_address, permanent_address,religion,gender,
       join_date,salary, employee_image
from   employee_view 



select username, user_type_name, ui.action_user, ui.action_date_time
from   user_info ui, user_type ut
where  ui.user_type_id = ut.user_type_id 
and    ui.user_type_id like nvl(:p_user_type_id, '%')
order  by username ;


select employee_id ,branch_name,department_name,designation_name,first_name, last_name, mother_name, 
       father_name,email,cell_number, date_of_birth,nid,present_address, permanent_address,religion,gender,
       join_date,salary, employee_image
from   employee_view 
where  branch_name like nvl(:p_branch_name,'%')


Emp Lov Report:
=================


select  e.branch_id,b.branch_name||'-('||count(e.employee_id)||')' Branch_name
from   employee e, branch b
where e.branch_id=b.branch_id
group by e.branch_id,b.branch_name
order by b.branch_name


Emp Lov Report view:
=====================

create or replace view employee_lov_view
as
select  e.branch_id,b.branch_name||'-('||count(e.employee_id)||')' Branch_name
from   employee e, branch b
where e.branch_id=b.branch_id
group by e.branch_id,b.branch_name
order by b.branch_name


create or replace view employee_cell_lov_view
as
select  e.employee_id,e.cell_number
from   employee e, branch b
where e.branch_id=b.branch_id
order by branch_id




Emp Lov Report Query:
=====================

select branch_id, branch_name
from employee_lov_view



declare
	v_lov     boolean;
begin
	if   :control.branch_ID is null then
   	 v_lov := show_lov('branch_name');	
   	  go_item('control.run_report');
	else
   	  go_item('control.run_report');
	end if;
end;

























