SET SERVEROUTPUT ON;
select * from room_type;
                
CREATE OR REPLACE 
    FUNCTION GET_BOOKING_AMOUNT(
        typ_id NUMBER,
        no_of_rooms NUMBER,
        no_of_guests NUMBER,
        amenity__id NUMBER,
        guest__id NUMBER,
        h_id NUMBER,
        b_start_date DATE,
        b_end_date DATE
    )
    
    RETURN NUMBER
        IS
        B_TOTAL_WITHOUT_DISCOUNT_AMOUNT NUMBER := 0;
        
        B_TOTAL_AMOUNT NUMBER := 0;
        B_TODAY_RATE NUMBER := 500;
        B_ROOM_AMOUNT NUMBER := 0;
        B_AMENITY_AMOUNT NUMBER := 0;
        B_IS_AMENITY_PERSON_SPECIFIC CHAR := 'y';
        B_DISCOUNT_AMOUNT NUMBER := 0;
        
        B_TOTAL_AMENITY_AMOUNT NUMBER := 0;
        B_TOTAL_ROOM_AMOUNT NUMBER := 0;

        B_NO_DAYS NUMBER:= 1;
        
        BEGIN
        
       -- DBMS_OUTPUT.PUT_LINE('room_typ_id: ' || typ_id || ' no_of_rooms : ' || no_of_rooms || ' no_of_guests : ' || no_of_guests || ' amenity_id : ' || amenity__id);
        
            dbms_output.put_line('----------------------------------------------------------');

        -- CALCULATE STAY PERIOD
             BEGIN
                IF b_end_date != b_start_date THEN
                    -- B_NO_DAYS :=  TO_DATE(b_end_date, 'YYYY-MM-DD') - TO_DATE(b_start_date, 'YYYY-MM-DD');
                     B_NO_DAYS := b_end_date - b_start_date;
                ELSE 
                 B_NO_DAYS := 1;
                 END IF;
                 
            EXCEPTION
                WHEN OTHERS THEN
                B_NO_DAYS := 1;
            END;

            DBMS_OUTPUT.PUT_LINE('Stay Period : ' || B_NO_DAYS || ' days');

            -- CALCULATE ROOM TYPE RATE
        BEGIN
            SELECT 
                    STNDRD_RATE
               INTO 
                    B_ROOM_AMOUNT 
               FROM 
                    ROOM_TYPE WHERE ROOM_TYP_ID = typ_id;
                    
            EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                        B_ROOM_AMOUNT := 0;
         END;
                    
            DBMS_OUTPUT.PUT_LINE('Room type rate is: ' || B_ROOM_AMOUNT);
               
        BEGIN
         SELECT 
                amenity_price, 
                IS_PRSN_SPC 
            INTO 
                B_AMENITY_AMOUNT, 
                B_IS_AMENITY_PERSON_SPECIFIC FROM AMENITY WHERE AMENITY_ID = amenity__id;
                
                 EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                        B_AMENITY_AMOUNT := 0;
                        B_IS_AMENITY_PERSON_SPECIFIC := 'n';
         END;
         
           DBMS_OUTPUT.PUT_LINE('AMENITY AMOUNT: ' || B_AMENITY_AMOUNT);
           DBMS_OUTPUT.PUT_LINE('IS AMENITY PERSON SPECIFIC: ' || B_IS_AMENITY_PERSON_SPECIFIC);
                 
      BEGIN
         SELECT 
                DISC_VALUE
            INTO 
                B_DISCOUNT_AMOUNT FROM GUEST_DISCOUNT WHERE GUEST_ID = guest__id;
                
                 EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                            B_DISCOUNT_AMOUNT := 0;
         END;
         
           DBMS_OUTPUT.PUT_LINE('Guest Discount is: ' || B_DISCOUNT_AMOUNT || '%');
           
    BEGIN
         SELECT 
                RACK_AMOUNT
            INTO 
                B_TODAY_RATE FROM HOTEL_RATES WHERE HOTEL_ID = h_id AND ANNUAL_RATE_DATE = TO_DATE(b_start_date);
                
                 EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                            B_DISCOUNT_AMOUNT := 0;
         END;
         
           DBMS_OUTPUT.PUT_LINE('Today rack amount is: ' || B_TODAY_RATE);
           
           -- calculate total amenity amount
           IF B_IS_AMENITY_PERSON_SPECIFIC = 'y' THEN
                B_TOTAL_AMENITY_AMOUNT := no_of_guests * B_AMENITY_AMOUNT;
                ELSE
                    B_TOTAL_AMENITY_AMOUNT := B_AMENITY_AMOUNT;
                END IF;
                
           dbms_output.put_line('Total Amenity Amount is : ' || B_TOTAL_AMENITY_AMOUNT);
           B_TOTAL_WITHOUT_DISCOUNT_AMOUNT := (B_TOTAL_AMENITY_AMOUNT + (B_ROOM_AMOUNT *  no_of_guests) + B_TODAY_RATE) * B_NO_DAYS;
           
           dbms_output.put_line('Booking rate per day without discount : ' || B_TOTAL_WITHOUT_DISCOUNT_AMOUNT);

           B_TOTAL_WITHOUT_DISCOUNT_AMOUNT := B_TOTAL_WITHOUT_DISCOUNT_AMOUNT * B_NO_DAYS;

           dbms_output.put_line('Total Booking rate without discount : ' || B_TOTAL_WITHOUT_DISCOUNT_AMOUNT);
           
           B_TOTAL_AMOUNT := B_TOTAL_WITHOUT_DISCOUNT_AMOUNT - ((B_DISCOUNT_AMOUNT / 100) * B_TOTAL_WITHOUT_DISCOUNT_AMOUNT);
           dbms_output.put_line('Total Booking rate after discount : ' || B_TOTAL_AMOUNT);
           
            dbms_output.put_line('----------------------------------------------------------');
            
            RETURN B_TOTAL_AMOUNT;
        END;
/    
   
DECLARE
        B_TOTAL_AMOUNT NUMBER := 0;
BEGIN
    B_TOTAL_AMOUNT := GET_BOOKING_AMOUNT(
        2,
        2,
        2,
        5,
        3,
        2,
    TO_DATE('2021/04/28', 'YYYY-MM-DD'),
    TO_DATE('2021/05/03', 'YYYY-MM-DD')
    );
    DBMS_OUTPUT.PUT_LINE('avg_room_amount: ' || B_TOTAL_AMOUNT);
END;
/

create or replace procedure insrt_room_booking(BKNG_ID IN NUMBER, 
            GUEST_ID IN NUMBER, NO_OF_GUEST IN NUMBER, 
            ROOM_TYP_ID IN NUMBER,AMOUNT IN FLOAT,
            AMENITY_ID IN NUMBER,
            BKNG_TYP_ID IN NUMBER,HOTEL_ID IN NUMBER,
            NO_OF_ROOM IN NUMBER,IS_MAIN IN CHAR,
            BKNG_START_DATE IN DATE,
            BKNG_END_DATE IN DATE
    )
         as

         DECLARE
            B_TOTAL_AMOUNT NUMBER := 0;

          begin
          
            dbms_output.put_line('----------------------------------------------------------');

        B_TOTAL_AMOUNT := GET_BOOKING_AMOUNT(
            ROOM_TYP_ID,
            NO_OF_ROOM,
            NO_OF_GUEST,
            AMENITY_ID,
            GUEST_ID,
            HOTEL_ID,
            BKNG_START_DATE,
            BKNG_END_DATE
        );

    insert into ROOM_BOOKING(BKNG_ID ,GUEST_ID, NO_OF_GUEST, 
                ROOM_TYP_ID, AMOUNT, AMENITY_ID,
                BKNG_TYP_ID, HOTEL_ID, NO_OF_ROOM,
                IS_MAIN, BKNG_START_DATE, BKNG_END_DATE) values (BKNG_ID  ,GUEST_ID, 
                NO_OF_GUEST,ROOM_TYP_ID, B_TOTAL_AMOUNT, AMENITY_ID, BKNG_TYP_ID, HOTEL_ID, NO_OF_ROOM, IS_MAIN,
                BKNG_START_DATE , BKNG_END_DATE);
             dbms_output.put_line('Row inserted at ROOM BOOKING table');
                 dbms_output.put_line('----------------------------------------------------------');
            commit;
            exception
            WHEN DUP_VAL_ON_INDEX
                then
                dbms_output.put_line('Oops! This record already exists');
                ROLLBACK;
                when others then
                    dbms_output.put_line('Error while inserting data in Room BOOKING Table ' || );
                    rollback;
                    dbms_output.put_line('The error encountered is: ');
                    dbms_output.put_line(dbms_utility.format_error_stack);
                    dbms_output.put_line('----------------------------------------------------------');
            end insrt_room_booking;
     /

SELECT * FROM GUEST;
SELECT * FROM MEMBER;

SELECT * FROM DISCOUNT;

SELECT * FROM ANNUAL_RATE;
SELECT * FROM rack_ratecard;

SELECT * FROM GUEST_DISCOUNT;

create view HOTEL_RATES AS
select a.rack_amount,b.* from
rack_ratecard a
join
annual_rate b
on b.rack_id = a.rack_id;

--SELECT * FROM HOTEL_RATES WHERE HOTEL_ID = 2 AND ANNUAL_RATE_DATE = TO_DATE(SYSDATE);

--SELECT SYSDATE - SYSDATE FROM DUAL;

SELECT TO_DATE('2021/05/03', 'YYYY-MM-DD') - TO_DATE('2021/04/28', 'YYYY-MM-DD') FROM DUAL;

 EXECUTE insrt_room_booking(
                        1, -- BKNG_ID
                        2, -- GUEST_ID
                        2, -- NO_OF_GUEST
                        5, -- ROOM_TYP_ID,
                        2, -- AMENITY_ID,
                        2, -- BKNG_TYP_ID,
                        2, -- HOTEL_ID,
                        2, -- NO_OF_ROOM,
                        TO_DATE('2021/04/28', 'YYYY-MM-DD'), -- BKNG START DATE,
                        TO_DATE('2021/05/03', 'YYYY-MM-DD') -- end date
                    );
     
     EXECUTE insrt_room_booking(2,1,3,2,5,2,1,3,TO_DATE('2021/04/26', 'YYYY-MM-DD'),TO_DATE('2021/05/01','YYYY-MM-DD'));
--EXECUTE insrt_room_booking(1,3 , 2,1,1500,3,2,1,2,'Y');  
--EXECUTE insrt_room_booking(1,3 , 2,1,1500,3,2,1,2,'Y');
--EXECUTE insrt_room_booking(1  ,1  , 5,1,1000,1,1,1,3,'Y');
--EXECUTE insrt_room_booking(2  ,2 , 3,1,765,2,2,1,2,'N');
--EXECUTE insrt_room_booking(3 ,3  , 4,1,500,3,1,2,4,'N');
--EXECUTE insrt_room_booking(4  ,4  , 4,1,500,4,1,2,4,'N');

--SELECT * FROM ROOM_BOOKING;