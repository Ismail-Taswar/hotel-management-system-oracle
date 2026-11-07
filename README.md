# Hotel Management System (Oracle Forms & Reports)

A hotel management system built as a university course project.
Manages guests, rooms, bookings, check-in/check-out, food and
services, billing, expenses, employees, and role-based users — with a large
library of printable reports.

## Tech Stack

- **Oracle Forms Builder** (10g/11g) — data-entry modules (`.fmb` sources + `.fmx` runtime)
- **Oracle Reports Builder** — printable reports (`.rdf`)
- **Oracle Database** — schema via SQL table scripts; DB export dumps included

## Modules

| Area | Forms |
|------|-------|
| Front desk | BOOKING_MD, CHECK_IN, CHECK_OUT, GUEST, ACCOUNT_RECEIVABLE |
| Rooms | ROOM, ROOM_TYPE, ROOM_CATEGORY, FLOOR, BRANCH |
| Food & Services | FOOD, FOOD_TYPE, FOOD_CATEGORY, FOOD_MD, SERVICE, SERVICE_MD |
| Billing | BILL, BILL1, EXPENSE_MD, EXPENSE_TYPE, PAYMENT_MODE |
| HR | DEPARTMENT, DESIGNATION, EMPLOYEE |
| System | LOGIN, HOME_PAGE, USER_INFO, USER_TYPE, USER_STATUS, USER_ACCESSS_PRIVILEGE |

Reports (100+ `.rdf`) cover booking/bill/check-in/check-out by ID and date,
guest profiles, food orders, services, expenses, salary-wise employees, and
total bills — see `Reports/`.

## Repository Layout

```
Forms/            .fmb sources + .fmx runtime modules
Reports/          .rdf report definitions
Documents/        ERD & DFD (xlsx), table scripts, procedures, views
Databackup/       Oracle DB export dumps (Feb/May 2024) + backup scripts
Menu/             Forms menus (.mmb/.mmx)
Object Library/   shared Forms object library (.olb)
image/            UI assets (backgrounds, logos, employee photos)
```

## How to Run

1. Create a schema in Oracle DB and run
   `Documents/table_script_hotel_management_system.sql` (complete schema —
   `table_script_commom.sql` is an older subset kept for reference),
   then `Documents/Table_Script_Menu_Access_Control.sql` (access-control
   tables for the menu/user-privilege forms) and
   `Documents/Room status Procedure.sql`.
   The scripts create the schema only — no data.
2. Run `Documents/seed_default_user.sql` to create the first login user
   (default `admin` / `admin`), then open the `.fmb` files in Oracle Forms
   Builder, connect to the schema, compile, and run through the Forms runtime.
3. Alternatively, restore the full database with a dump from `Databackup/`
   (IMPDP) instead of steps 1–2 — dumps contain schema and real data.

## Author

Ismail Taswar ([@Ismail-Taswar](https://github.com/Ismail-Taswar)) — educational project.
