
CREATE OR REPLACE PROCEDURE EMP_DEPT_Processing (
-- type 1 = EMP lookup by EMPNO
-- type 2 = EMP lookup by ENAME
-- type 3 = DEPT lookup by DEPTNO
-- type 4 = DEPT lookup by DNAME
   ED_Type   IN   NUMBER, 
   ED_NUM    IN   NUMBER,
   ED_NAME   IN   VARCHAR2) 
IS
   TYPE any_ref_cur IS REF CURSOR;
   TYPE EMP_ref_cur IS REF CURSOR RETURN EMP%ROWTYPE;
   Any_Cur    any_ref_cur;  
   EMP_Cur    EMP_ref_cur;          
   EMP_Rec    EMP%ROWTYPE;
   DEPT_Rec   DEPT%ROWTYPE;
   v_LOC      dept.loc%TYPE;
BEGIN
   IF ED_TYPE = 1 THEN
      OPEN EMP_CUR FOR 
         SELECT * FROM EMP
         WHERE EMPNO = ED_Num;
   ELSIF ED_TYPE = 2 THEN
      OPEN EMP_CUR FOR 
         SELECT * FROM EMP
         WHERE ENAME = ED_NAME;
   ELSIF ED_TYPE = 3 THEN
      OPEN any_cur FOR 
         SELECT LOC FROM DEPT
         WHERE DEPTNO = ED_NUM;
   ELSIF ED_TYPE = 4 THEN
      OPEN any_cur FOR 
         SELECT LOC FROM DEPT
         WHERE DNAME = ED_NAME;
   ELSE
      DBMS_OUTPUT.PUT_LINE('Invalid Type');
      RETURN;
   END IF;
  
   IF ED_TYPE < 3 THEN
      LOOP
         FETCH EMP_CUR into EMP_REC;
         EXIT WHEN EMP_CUR%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE('Employee Name = ' || emp_rec.ename );
      END LOOP;
      CLOSE EMP_CUR;
   ELSIF ED_TYPE < 5 THEN
      LOOP
         FETCH ANY_CUR into V_LOC;
         EXIT WHEN ANY_CUR%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE('Department Name = ' || v_loc );
      END LOOP;
      CLOSE ANY_CUR;
   END IF;


EXCEPTION
   WHEN ROWTYPE_MISMATCH THEN
      DBMS_OUTPUT.PUT_LINE('Wrong Options - try again');
      
END EMP_DEPT_Processing;
/


EXEC EMP_DEPT_Processing(ED_TYPE => 1, ED_NUM => 7788, ED_NAME => NULL);

EXEC EMP_DEPT_Processing(ED_TYPE => 2,ED_NUM => null, ED_NAME => 'SMITH');

EXEC EMP_DEPT_Processing(ED_TYPE => 3, ED_NUM => 20, ED_NAME => NULL);

EXEC EMP_DEPT_Processing(ED_TYPE => 4, ED_NUM => null, ED_NAME => 'SALES');
