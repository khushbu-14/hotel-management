SET SERVEROUTPUT ON;
    --drop table room_type_db;
    --select * from room_type;
    --drop table ROOM_TYPE_DB;
    -- TABLEC REATION PROCEDURE
    create or replace procedure room_type_creation is
    table_name varchar2(4000);
   
    BEGIN
    -- table creation query
       table_name:='CREATE TABLE ROOM_TYPE_DB(
                            ROOM_TYP_ID  NUMBER GENERATED BY DEFAULT AS IDENTITY,
                            ROOM_TYP_DESC VARCHAR2(255) NOT NULL UNIQUE,
                            NO_OF_BEDS NUMBER NULL,
                            STNDRD_RATE FLOAT NOT NULL,
                            constraint pk_room_typ_id PRIMARY KEY(ROOM_TYP_ID)
                    )';
       EXECUTE IMMEDIATE table_name;
    end room_type_creation;
    /
    
      DECLARE
      
            tName varchar2(50);
            nCount NUMBER;
        BEGIN
            tName:='ROOM_TYPE_DB';
            SELECT count(*) into nCount FROM user_tables where table_name = tName;
            IF(nCount > 0)
            
            THEN
                    DBMS_OUTPUT.PUT_LINE('TABLE '|| tName||' ALREADY EXISTS.');
            ELSE
            -- call to table creation stored procedure 
                begin 
                 room_type_creation;
                end;    
             DBMS_OUTPUT.PUT_LINE('TABLE '||tName||' CREATED.');
            
            END IF;
            exception 
              when no_data_found then
               dbms_output.put_line('table doesnt exits!, So we created one');
               
               -- call to table creation stored procedure 
               begin 
                 room_type_creation;
                end; 
                
                when others
                    then
                    dbms_output.put_line('Something went wrong!');
                    dbms_output.put_line(dbms_utility.format_error_stack);
    END;
    /  
    
     create or replace procedure insrt_room_type_db(roomtype_desc_name in varchar2,no_of_beds_name in number,standard_rate_name in float)
         as
          begin
                 dbms_output.put_line('----------------------------------------------------------');
                  insert into ROOM_TYPE_DB(ROOM_TYP_DESC,NO_OF_BEDS,STNDRD_RATE) values (roomtype_desc_name,no_of_beds_name,standard_rate_name);
                 dbms_output.put_line('Row inserted at RoomType table');
                 dbms_output.put_line('----------------------------------------------------------');
            commit;
            exception
            WHEN DUP_VAL_ON_INDEX
                then
                dbms_output.put_line('Oop! This record already exists');
                rollback;
                when others then
                    dbms_output.put_line('Error while inserting data in Location Table');
                    rollback;
                    dbms_output.put_line('The error encountered is: ');
                    dbms_output.put_line(dbms_utility.format_error_stack);
                    dbms_output.put_line('----------------------------------------------------------');
            end insrt_room_type_db;
     /
     
     execute insrt_room_type_db('Delux',2,1500);
     execute insrt_room_type_db('PentHouse',4,5000);
     execute insrt_room_type_db('Presidential Suite',4,10000);  
     execute insrt_room_type_db('Studio',1,1000);       
     
     select * from room_type_db;

     --insert into ROOM_TYPE_DB(ROOM_TYP_DESC,NO_OF_BEDS,STNDRD_RATE) values ('AAA',9,89);