set serveroutput on;

DECLARE nCount number;
BEGIN 
SELECT 
  count(*) into nCount 
FROM 
  ALL_USERS 
where 
  USERNAME = 'FRONTDESK';
IF(nCount > 0) THEN dbms_output.put_line('FRONTDESK USER ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'create user FRONTDESK identified by Database1234#';
EXECUTE IMMEDIATE 'GRANT CREATE SESSION,CONNECT TO FRONTDESK';
EXECUTE IMMEDIATE 'GRANT SELECT,UPATE,INSERT ON GUEST TO FRONTDESK';
dbms_output.put_line('User created'|| username);
END IF;
EXCEPTION WHEN OTHERS THEN dbms_output.put_line(
  dbms_utility.format_error_backtrace
);
dbms_output.put_line(SQLERRM);
ROLLBACK;
RAISE;
COMMIT;
END;
/ 




---------------------------------------------------FrontDesk-----------------------------

drop user frontdesk;
create user frontdesk identified by Database1234#;
grant connect to frontdesk;
grant create session to frontdesk;
grant unlimited tablespace to frontdesk;
grant select,insert,update on ADMIN.guest to frontdesk;

----------------------------------------------------HouseKeeping----------------------------
drop user housekeeping;
create user housekeeping identified by Database1234#;
grant connect,resource to housekeeping;
grant create session to housekeeping;
grant unlimited tablespace to housekeeping;

------------------------------------------------------Manager--------------------------------
drop user manager;
create user manager identified by Database1234#;
grant connect,resource to manager;
grant create session to manager;
grant unlimited tablespace to manager;

-------------------------------------------------------Main_Admin
drop user main_admin;
create user main_admin identified by Database1234#;
grant connect,resource to main_admin;
grant create session to main_admin;
grant unlimited tablespace to main_admin;

-------------------------------------------------------







---------------------------------Granting Priviliges to FrontDesk---------------------





-----------------------------------------------------



grant select,insert,update on house_keeping to housekeeping;


Grant SELECT on guest to frontdesk;



--Alter user frontdesk password Datanight1234;

--connect session frontdesk Datanight1234;

connect frontdesk

select * from DBA_sys_privs
where grantee='FRONTDESK'
;
