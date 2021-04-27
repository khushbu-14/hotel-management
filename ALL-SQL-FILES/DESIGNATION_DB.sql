    SET SERVEROUTPUT ON;
    
    -- TABLEC REATION PROCEDURE
    create or replace procedure Designation_creation is
    table_name varchar2(4000);
   
    BEGIN
    -- table creation query
       table_name:= 'CREATE TABLE DESIGNATION_DB (
    DESG_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    DESG_NAME VARCHAR(50) NOT NULL unique,
constraint PK_DESG_ID  primary key(DESG_ID)
    )';

    EXECUTE IMMEDIATE table_name;
    end Designation_creation;
    /
    
      DECLARE
            
            table_name varchar2(50);
            nCount NUMBER;
        BEGIN
            table_name:= 'DESIGNATION_DB';
            SELECT count(*) into nCount FROM user_tables where table_name = 'DESIGNATION_DB';
            IF(nCount > 0)
            
            THEN
                    DBMS_OUTPUT.PUT_LINE('TABLE '||table_name ||' ALREADY EXISTS.');
            ELSE
            -- call to table creation stored procedure 
                begin 
                 Designation_creation;
                end;    
            DBMS_OUTPUT.PUT_LINE('TABLE '||TABLE_NAME||' CREATED.');
            
            END IF;
            exception 
            
              when no_data_found then
               dbms_output.put_line('table doesnt exits!, So we created one');
               
               -- call to table creation stored procedure 
               begin 
                 Designation_creation;
                end; 
                
                when others
                    then
                    dbms_output.put_line('Something went wrong!');
                    dbms_output.put_line(dbms_utility.format_error_stack);
    END;
    /  
    
     create or replace procedure insrt_Designation_db(DESG_NAME_name in varchar)
         as
          begin
                 dbms_output.put_line('----------------------------------------------------------');
                insert into  DESIGNATION_DB(DESG_NAME) values (DESG_NAME_name);
             dbms_output.put_line('Row inserted at DESIGNATION_DB table');
                 dbms_output.put_line('----------------------------------------------------------');
            commit;
            exception
             WHEN DUP_VAL_ON_INDEX
                then
                dbms_output.put_line('Oop! This record already exists');
                rollback;
                when others then
                    dbms_output.put_line('Error while inserting data in DESIGNATION_DB Table');
                    rollback;
                    dbms_output.put_line('The error encountered is: ');
                    dbms_output.put_line(dbms_utility.format_error_stack);
                    dbms_output.put_line('----------------------------------------------------------');
            end insrt_Designation_db;
     /
    
    execute insrt_Designation_db('Duty Manager');
    execute insrt_Designation_db('Team Leader');
    execute insrt_Designation_db('Front Desk Officer');
    execute insrt_Designation_db('Guest Service Officer');
    execute insrt_Designation_db('Senior Guest Service Officer');
    execute insrt_Designation_db('Assistent Front office manager');
    execute insrt_Designation_db('Front Office manager');
    execute insrt_Designation_db('Director of Room');
    execute insrt_Designation_db('Floor Attendant');
    execute insrt_Designation_db('Floor Supervisor');
    execute insrt_Designation_db('Assistent Manager HouseKeeping');
    execute insrt_Designation_db('Deupty House keeper ');
    execute insrt_Designation_db('Executive house keeper');
    
    select * from DESIGNATION_DB;
    
   