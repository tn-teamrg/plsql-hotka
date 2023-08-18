CREATE or REPLACE PROCEDURE Timer as
  v_start_time  NUMBER;
  v_end_time    NUMBER;
  v_id     user0.emp_info.empno%TYPE;
  v_row    user0.emp_info%ROWTYPE;
  


-- insert TYPES and Tables here


cursor empInfo_cur is
   select *
   from user0.emp_info;

BEGIN
  
-- Array LOAD Section --
  
-- Timing Routine - put load and access code between v_start and v_end --
   v_start_time := DBMS_UTILITY.GET_TIME;


-- put the code for loading the Associative Array collection here --


   v_end_time := (DBMS_UTILITY.GET_TIME - v_start_time) / 100;
   DBMS_OUTPUT.PUT_LINE('Associative Array LOAD Time: ' || v_end_time  );
  
-- Timing Routine - put load and access code between v_start and v_end --
   v_start_time := DBMS_UTILITY.GET_TIME;


-- put the code for loading the Nested Table collection here --


   v_end_time := (DBMS_UTILITY.GET_TIME - v_start_time) / 100;
   DBMS_OUTPUT.PUT_LINE('Nested Table LOAD Time: ' || v_end_time  );
 

-- Array Lookup Area -- adjust the collection name to what ever you used above...--

  v_start_time := DBMS_UTILITY.GET_TIME;
   
   DBMS_OUTPUT.PUT_LINE('Location 1 is ' || 
       EMPNO_AA_TABLE(1).First_Name || ' ' || EMPNO_AA_TABLE(1).Last_Name );
   DBMS_OUTPUT.PUT_LINE('Location 100 is ' || 
          EMPNO_AA_TABLE(100).First_Name || ' ' || EMPNO_AA_TABLE(100).Last_Name );
   DBMS_OUTPUT.PUT_LINE('Location 1000 is ' || 
          EMPNO_AA_TABLE(1000).First_Name || ' ' || EMPNO_AA_TABLE(1000).Last_Name );
   DBMS_OUTPUT.PUT_LINE('Location 10000 is ' || 
          EMPNO_AA_TABLE(10000).First_Name || ' ' || EMPNO_AA_TABLE(10000).Last_Name );
   
   v_end_time := (DBMS_UTILITY.GET_TIME - v_start_time) / 100;
   DBMS_OUTPUT.PUT_LINE('Associative Table Access: ' || v_end_time  );
 
   v_start_time := DBMS_UTILITY.GET_TIME;
    
    FOR i IN EMPNO_NT_TABLE.first .. EMPNO_NT_TABLE.last 
        LOOP
        IF EMPNO_NT_TABLE(i).EMPNO = 1 THEN
          DBMS_OUTPUT.PUT_LINE('Location 1 is ' || 
              EMPNO_NT_TABLE(i).First_Name || ' ' || EMPNO_NT_TABLE(i).Last_Name );
        END IF;
        IF EMPNO_NT_TABLE(i).EMPNO = 100 THEN
              DBMS_OUTPUT.PUT_LINE('Location 100 is ' || 
                  EMPNO_NT_TABLE(i).First_Name || ' ' || EMPNO_NT_TABLE(i).Last_Name );
        END IF;
        IF EMPNO_NT_TABLE(i).EMPNO = 1000 THEN
              DBMS_OUTPUT.PUT_LINE('Location 1000 is ' || 
                  EMPNO_NT_TABLE(i).First_Name || ' ' || EMPNO_NT_TABLE(i).Last_Name );
        END IF;
        IF EMPNO_NT_TABLE(i).EMPNO = 10000 THEN
              DBMS_OUTPUT.PUT_LINE('Location 10000 is ' || 
                  EMPNO_NT_TABLE(i).First_Name || ' ' || EMPNO_NT_TABLE(i).Last_Name );
        END IF;
    END LOOP;
    
    v_end_time := (DBMS_UTILITY.GET_TIME - v_start_time) / 100;
    DBMS_OUTPUT.PUT_LINE('Nested Table Access: ' || v_end_time  );
  
 
END;
/