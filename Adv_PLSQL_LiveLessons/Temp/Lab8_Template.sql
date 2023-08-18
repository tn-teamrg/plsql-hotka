
CREATE OR REPLACE PROCEDURE USER0_EMP_DEPT (
   IN_TYPE   IN   VARCHAR2, 
   IN_NUM     IN   NUMBER) 
IS
    
   
   v_name    varchar2(20);
BEGIN
   IF IN_TYPE = 'E' THEN
 
   ELSIF IN_TYPE = 'D' THEN
 
   ELSE
      DBMS_OUTPUT.PUT_LINE('Invalid Type');
      RETURN;
   END IF;
      
   LOOP
       
   END LOOP;
    
END;


      
