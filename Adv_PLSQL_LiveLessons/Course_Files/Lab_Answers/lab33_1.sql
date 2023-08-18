CREATE OR REPLACE PACKAGE GET_DNAME IS
   FUNCTION dept_name (IN_Number number) RETURN varchar2; 
   FUNCTION dept_name (IN_Name varchar2) RETURN varchar2;
END;
/

CREATE or REPLACE PACKAGE BODY GET_DNAME IS

FUNCTION dept_name (IN_Number number) RETURN varchar2
IS
v_dname    dept.dname%TYPE;

BEGIN

select dname
into v_dname
from dept
where deptno = IN_Number;

RETURN v_dname;

END;

FUNCTION dept_name (IN_Name varchar2) RETURN varchar2
IS
v_dname    dept.dname%TYPE;

BEGIN

select dname
into v_dname
from dept
where LOC = IN_Name;

RETURN v_dname;

END;

END GET_DNAME;
/

