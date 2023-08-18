CREATE OR REPLACE TRIGGER CHG_EMP_DEPT
   
---insert some code here--

BEGIN
    
   UPDATE EMP
      SET DEPTNO = (select DEPTNO from DEPT
                    where LOC = :NEW.LOC)
      WHERE ENAME = :OLD.ENAME;
   

END;
/
 	

