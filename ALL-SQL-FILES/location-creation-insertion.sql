    SET SERVEROUTPUT ON;
    
    -- TABLEC REATION PROCEDURE
    create or replace procedure location_table_creation is
    table_name varchar2(4000);
   
    BEGIN
    -- table creation query
       table_name:='CREATE TABLE LOCATION3(
                            LOCATION_ID  NUMBER GENERATED BY DEFAULT AS IDENTITY,
                            STATE VARCHAR(8) NOT NULL,
                            CITY VARCHAR(50),
                            ZIPCODE VARCHAR(5) NOT NULL UNIQUE,
                            PRIMARY KEY(LOCATION_ID)
                    )';
       EXECUTE IMMEDIATE table_name;
    end location_table_creation;
    /
    
  DECLARE
        tname varchar2(50);
        nCount NUMBER;
    BEGIN
        SELECT count(*) into nCount FROM user_tables where table_name = 'LOCATION3';
        IF(nCount > 0)
        
        THEN
                DBMS_OUTPUT.PUT_LINE('TABLE LOCATION ALREADY EXISTS.');
          
        ELSE
        -- call to table creation stored procedure 
            begin 
             location_table_creation;
            end;    
        DBMS_OUTPUT.PUT_LINE('TABLE LOCATION CREATED.');
        
        END IF;
        exception 
          when no_data_found then
           dbms_output.put_line('table doesnt exits!, So we created one');
           
           -- call to table creation stored procedure 
           begin 
             location_table_creation;
            end; 
            
            when others
                then
                dbms_output.put_line('Something went wrong!');
                dbms_output.put_line(dbms_utility.format_error_stack);
END;
/  
    
    create or replace package insertion
        as
      procedure insrt_location (state_name in varchar, city_name in varchar, zipcode in varchar);
    end;
    /    

    create or replace package body insertion
    as
        procedure insrt_location(state_name in varchar, city_name in varchar, zipcode in varchar)
        as
        begin
             dbms_output.put_line('----------------------------------------------------------');
            insert into location3(state, city, zipcode) values (state_name, city_name, zipcode);
         dbms_output.put_line('Row inserted at Location table');
             dbms_output.put_line('----------------------------------------------------------');
        commit;
        exception
            when others then
                dbms_output.put_line('Error while inserting data in Location Table');
                rollback;
                dbms_output.put_line('The error encountered is: ');
                dbms_output.put_line(dbms_utility.format_error_stack);
                dbms_output.put_line('----------------------------------------------------------');
        end insrt_location;
    
    end;
    /
    
    execute insertion.insrt_location('MA','Boston','02120');
    execute insertion.insrt_location('CA','Los Angeles','90011');
    execute insertion.insrt_location('IL','Chicago','60629');
    execute insertion.insrt_location('NY','Brooklyn','11220');
    execute insertion.insrt_location('TX','Houston','77084');
    execute insertion.insrt_location('TX','Houston','77084');
    
    select * from location3;