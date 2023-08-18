CREATE or REPLACE PROCEDURE Timer as
  v_start_time  NUMBER;
  v_end_time    NUMBER;
  v_id     user0.emp_info.empno%TYPE;
  v_row    user0.emp_info%ROWTYPE;
  
  a number := 0;

-- insert TYPES & Tables here

BEGIN
  
  
-- Timing Routine - put load and access code between v_start and v_end --
   v_start_time := DBMS_UTILITY.GET_TIME;


-- copy the start/stop and put code to be timed here...


   v_end_time := (v_start_time - DBMS_UTILITY.GET_TIME) / 100;
   DBMS_OUTPUT.PUT_LINE('Timing Notes: ' || v_end_time  );
  
  
 
END;
/