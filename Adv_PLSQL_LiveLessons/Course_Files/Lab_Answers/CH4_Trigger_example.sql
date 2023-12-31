
CREATE OR REPLACE TRIGGER Update_EMP_DEPT
   INSTEAD OF UPDATE ON EMP_DEPT_VW
   FOR EACH ROW
BEGIN
    UPDATE EMP
      SET ENAME = :NEW.ENAME,
          DEPTNO = (select deptno from dept
                    where LOC = :NEW.LOC)
      WHERE ENAME = :OLD.ENAME;

END;
/


UPDATE EMP_DEPT_VW
SET ENAME = 'Hotka'
WHERE ENAME = 'SMITH';

SELECT * FROM EMP_DEPT_VW;
ROLLBACK;



SET ECHO OFF
