
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



