
CREATE OR REPLACE PROCEDURE USER0_EMP_DEPT (
   IN_TYPE   IN   VARCHAR2, 
   IN_NUM     IN   NUMBER) 
IS
   TYPE any_ref_cur IS REF CURSOR;
   any_cur    any_ref_cur;
   
   v_name    varchar2(20);
BEGIN
   IF IN_TYPE = 'E' THEN
      OPEN any_cur FOR 
         SELECT ENAME FROM EMP
         WHERE EMPNO = IN_NUM;
   ELSIF IN_TYPE = 'D' THEN
      OPEN any_cur FOR 
         SELECT DNAME FROM DEPT
         WHERE DEPTNO = IN_NUM;
   ELSE
      DBMS_OUTPUT.PUT_LINE('Invalid Type');
      RETURN;
   END IF;
   
   LOOP
      FETCH any_cur INTO v_name; 
      EXIT WHEN any_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_name);
   END LOOP;
   CLOSE any_cur;
END;


      
