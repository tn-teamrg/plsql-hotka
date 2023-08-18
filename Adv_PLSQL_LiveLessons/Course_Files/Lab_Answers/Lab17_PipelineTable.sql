
DROP TYPE DEPT_LIST;
DROP TYPE DEPT_TYPE;

CREATE TYPE DEPT_TYPE AS OBJECT (
    deptno    NUMBER(2),
    dname  VARCHAR2(14),
    loc  VARCHAR2(13));

CREATE TYPE DEPT_LIST AS TABLE OF DEPT_TYPE;
/

CREATE OR REPLACE FUNCTION dept_PIPE
   RETURN DEPT_LIST PIPELINED 
IS
   out_row  DEPT_TYPE := DEPT_TYPE(null, null, null);
   CURSOR C_DEPT IS 
      SELECT * FROM DEPT;
BEGIN
   FOR i In C_DEPT 
   LOOP
      out_row.deptno := i.deptno;
      out_row.dname := i.dname;
      out_row.loc := i.loc;
      PIPE ROW(out_row);
   END LOOP;
   RETURN;  
END;


SELECT *
FROM TABLE(DEPT_PIPE);


