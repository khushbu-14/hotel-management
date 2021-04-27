SET SERVEROUTPUT ON;



    -- TABLEC REATION PROCEDURE
    create or replace procedure room_status_creation is
    table_name varchar2(4000);
   
    BEGIN
    -- table creation query
       table_name:='CREATE TABLE ROOM_STATUS_DB(
                            ROOM_STS_ID  NUMBER GENERATED BY DEFAULT AS IDENTITY,
                            ROOM_STS_TIMESTAMP TIMESTAMP NOT NULL,
                            ROOM_STS VARCHAR2(50) NOT NULL,
                            constraint pk_room_status_id PRIMARY KEY(ROOM_STS_ID)
                    )';
       EXECUTE IMMEDIATE table_name;
    end room_status_creation;
    /
    
      DECLARE
            table_name varchar2(50);
            nCount NUMBER;
        BEGIN
            table_name:='ROOM_STATUS_DB';
            SELECT count(*) into nCount FROM user_tables where table_name = 'ROOM_STATUS_DB';
            IF(nCount > 0)
            
            THEN
                    DBMS_OUTPUT.PUT_LINE('TABLE '|| table_name ||' ALREADY EXISTS.');
            ELSE
            -- call to table creation stored procedure 
                begin 
                 room_status_creation;
                end;    
            DBMS_OUTPUT.PUT_LINE('TABLE ' ||table_name ||' CREATED');
            
            END IF;
            exception 
              when no_data_found then
               dbms_output.put_line('table doesnt exits!, So we created one');
               
               -- call to table creation stored procedure 
               begin 
                 room_status_creation;
                end; 
                
                when others
                    then
                    dbms_output.put_line('Something went wrong!');
                    dbms_output.put_line(dbms_utility.format_error_stack);
    END;
    /  
    
     create or replace procedure insrt_room_status_db(room_status_timestamp in timestamp, room_status in varchar)
         as
          begin
                 dbms_output.put_line('----------------------------------------------------------');
                insert into  ROOM_STATUS_DB(ROOM_STS_TIMESTAMP, ROOM_STS) values (room_status_timestamp, room_status);
             dbms_output.put_line('Row inserted at ROOM_STATUS table');
                 dbms_output.put_line('----------------------------------------------------------');
            commit;
            exception
                WHEN DUP_VAL_ON_INDEX
                then
                dbms_output.put_line('Oop! This record already exists');
                when others then
                    dbms_output.put_line('Error while inserting data in Location Table');
                    rollback;
                    dbms_output.put_line('The error encountered is: ');
                    dbms_output.put_line(dbms_utility.format_error_stack);
                    dbms_output.put_line('----------------------------------------------------------');
            end insrt_room_status_db;
     /
    
    execute insrt_room_status_db(SYSDATE,'Clean');
    execute insrt_room_status_db(SYSDATE,'Not Clean');
    execute insrt_room_status_db(SYSDATE,'Cleaning in Progress');
    execute insrt_room_status_db(SYSDATE,'Out of Order');
    

    
    select * from room_status_db;