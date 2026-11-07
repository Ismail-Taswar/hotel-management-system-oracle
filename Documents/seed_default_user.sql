--=====================================================
-- Seed data: first login user for the Forms runtime
-- Run AFTER the table scripts (schema only, no data).
-- Default login: admin / admin
--=====================================================

insert into user_type (user_type_id, user_type_name)
values (1, 'Admin');

insert into user_status (user_status_id, user_status_name)
values (1, 'Active');

insert into user_info (user_info_id, user_type_id, user_status_id, username, password)
values (1, 1, 1, 'admin', 'admin');

commit;
