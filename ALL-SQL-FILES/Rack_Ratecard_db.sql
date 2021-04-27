    SET SERVEROUTPUT ON;
    
    -- TABLEC REATION PROCEDURE
    create or replace procedure Rack_Rate_Card_creation is
    table_name varchar2(4000);
   
    BEGIN
    -- table creation query
       table_name:= 'CREATE TABLE RACK_RATECARD_DB(
RACK_ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
RACK_AMOUNT FLOAT NOT NULL unique,
constraint PK_RACK_ID PRIMARY KEY(RACK_ID)
)';

    EXECUTE IMMEDIATE table_name;
    end Rack_Rate_Card_creation;
    /
    
      DECLARE
            
            table_name varchar2(50);
            nCount NUMBER;
        BEGIN
            table_name:= 'RACK_RATECARD_DB';
            SELECT count(*) into nCount FROM user_tables where table_name = 'RACK_RATECARD_DB';
            IF(nCount > 0)
            
            THEN
                    DBMS_OUTPUT.PUT_LINE('TABLE '||table_name ||' ALREADY EXISTS.');
            ELSE
            -- call to table creation stored procedure 
                begin 
                 Rack_Rate_Card_creation;
                end;    
            DBMS_OUTPUT.PUT_LINE('TABLE '||TABLE_NAME||' CREATED.');
            
            END IF;
            exception 
              when no_data_found then
               dbms_output.put_line('table doesnt exits!, So we created one');
               
               -- call to table creation stored procedure 
               begin 
                 Rack_Rate_Card_creation;
                end; 
                
                when others
                    then
                    dbms_output.put_line('Something went wrong!');
                    dbms_output.put_line(dbms_utility.format_error_stack);
    END;
    /  
    
     create or replace procedure insrt_Rack_RateCard_db(RACK_AMOUNT_name in FLOAT)
         as
          begin
                 dbms_output.put_line('----------------------------------------------------------');
                insert into  RACK_RATECARD_DB(RACK_AMOUNT) values (RACK_AMOUNT_name);
             dbms_output.put_line('Row inserted at RACK_RATECARD_DB table');
                 dbms_output.put_line('----------------------------------------------------------');
            commit;
            exception
            WHEN DUP_VAL_ON_INDEX
                then
                dbms_output.put_line('Oop! This record already exists');
                when others then
                    dbms_output.put_line('Error while inserting data in RACK_RATECARD_DB Table');
                    rollback;
                    dbms_output.put_line('The error encountered is: ');
                    dbms_output.put_line(dbms_utility.format_error_stack);
                    dbms_output.put_line('----------------------------------------------------------');
            end create or replace procedure insrt_Rack_RateCard_db(RACK_AMOUNT_name in FLOAT)
         as
          begin
                 dbms_output.put_line('----------------------------------------------------------');
                insert into  RACK_RATECARD_DB(RACK_AMOUNT) values (RACK_AMOUNT_name);
             dbms_output.put_line('Row inserted at RACK_RATECARD_DB table');
                 dbms_output.put_line('----------------------------------------------------------');
            commit;
            exception
            WHEN DUP_VAL_ON_INDEX
                then
                dbms_output.put_line('Oop! This record already exists');
                rollback;
                when others then
                    dbms_output.put_line('Error while inserting data in RACK_RATECARD_DB Table');
                    rollback;
                    dbms_output.put_line('The error encountered is: ');
                    dbms_output.put_line(dbms_utility.format_error_stack);
                    dbms_output.put_line('----------------------------------------------------------');
            end insrt_Rack_RateCard_db;
     /
    
    execute insrt_Rack_RateCard_db(5000);
    
    select * from RACK_RATECARD_DB;

     /
    
    execute insrt_Designation_db(500); 
    execute insrt_Designation_db(1500);
    execute insrt_Rack_RateCard_db(2000);
    execute insrt_Rack_RateCard_db(2500);
    execute insrt_Rack_RateCard_db(3000);
    execute insrt_Rack_RateCard_db(3500);
    execute insrt_Rack_RateCard_db(4000);
    execute insrt_Rack_RateCard_db(4500);
    execute insrt_Rack_RateCard_db(5000);
    execute insrt_Rack_RateCard_db(5500);
    execute insrt_Rack_RateCard_db(6000);
    execute insrt_Rack_RateCard_db(6500);
    execute insrt_Rack_RateCard_db(7000);
    execute insrt_Rack_RateCard_db(7500);
    execute insrt_Rack_RateCard_db(8000);
    execute insrt_Rack_RateCard_db(8500);
    execute insrt_Rack_RateCard_db(9000);
    execute insrt_Rack_RateCard_db(9500);
    execute insrt_Rack_RateCard_db(10000); 
    
    select * from RACK_RATECARD_DB;